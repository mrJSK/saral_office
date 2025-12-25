// lib/features/payment_authority/services/payment_authority_pdf_service.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:saral_office/core/database/services/isar_service.dart';

import '../providers/payment_authority_pdf_model.dart' as pa_model;

class PaymentAuthorityPdfService {
  final IsarService _isarService;

  PaymentAuthorityPdfService(this._isarService);

  /// Generate PDF and open it
  Future<File> generateAndOpen(pa_model.PaymentAuthorityPdfModel pa) async {
    final pdfBytes = await _buildPdf(pa);
    final file = await _savePdfToFile(pdfBytes, pa);
    await OpenFilex.open(file.path);
    return file;
  }

  /// Build the complete PDF document
  Future<Uint8List> _buildPdf(pa_model.PaymentAuthorityPdfModel pa) async {
    final doc = pw.Document();

    // Load fonts
    final ttf = await PdfGoogleFonts.robotoRegular();
    final ttfBold = await PdfGoogleFonts.robotoBold();

    // Define text styles
    final textStyles = _buildTextStyles(ttf, ttfBold);

    // Create printer-safe page theme
    final pageTheme = await _buildPageTheme(PdfPageFormat.a4);

    // 1. Fetch GL Descriptions from Isar
    final glCodes = <String>{
      ...pa.debitLines.map((e) => e.glCode),
      ...pa.creditLines.map((e) => e.glCode),
    };
    final glDescMap = await _isarService.getGlDescriptionMapForCodes(glCodes);

    doc.addPage(
      pw.MultiPage(
        pageTheme: pageTheme,
        // Ensure main axis (vertical) doesn't expand unnecessarily
        mainAxisAlignment: pw.MainAxisAlignment.start,
        build: (context) {
          // Calculate safe width for inner content (page width - margins - padding)
          final safeWidth = pageTheme.pageFormat.availableWidth - 12;

          return [
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                children: [
                  // Reduced top spacing
                  pw.SizedBox(height: 2),

                  // Title
                  pw.Center(
                    child: pw.Text(
                      'FOR CASH PAYMENT ONLY',
                      style: textStyles['title'],
                    ),
                  ),
                  // Compacted gap: 12 -> 8
                  pw.SizedBox(height: 8),

                  // Header details section
                  _buildHeaderBlock(pa, textStyles),
                  // Compacted gap: 12 -> 8
                  pw.SizedBox(height: 8),

                  // Classification table with DEBIT/CREDIT
                  _buildClassificationTable(
                    pa,
                    textStyles,
                    maxWidth: safeWidth,
                    glDescMap: glDescMap,
                  ),
                  // Compacted gap: 10 -> 6
                  pw.SizedBox(height: 6),

                  // Gross total row
                  _buildGrossTotalRow(pa, textStyles, maxWidth: safeWidth),
                  // Compacted gap: 16 -> 10
                  pw.SizedBox(height: 10),

                  _buildPaymentParagraph(pa, textStyles),
                  pw.SizedBox(height: 10),

                  // Complete bottom section with signatures, debit to, and cashier
                  _buildSignaturesAndDebitSection(
                    pa,
                    textStyles,
                    maxWidth: safeWidth,
                  ),

                  pw.SizedBox(height: 2),
                ],
              ),
            ),
          ];
        },
      ),
    );

    return doc.save();
  }

  pw.Widget _buildPaymentParagraph(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle?> styles,
  ) {
    final amountInWords = _convertAmountToWords(pa.netAmount);
    final payeeName = pa.payeeName.trim();
    final payeeAddress = pa.payeeAddress.trim();
    final particulars = pa.paymentParticulars.trim();

    return pw.Container(
      padding: const pw.EdgeInsets.fromLTRB(6, 6, 6, 6),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 0.6, color: PdfColors.grey700),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
        color: PdfColors.grey100,
      ),
      child: pw.RichText(
        text: pw.TextSpan(
          style: styles['base'],
          children: [
            pw.TextSpan(text: 'Paid Rupees (in words) ', style: styles['base']),
            pw.TextSpan(text: amountInWords, style: styles['bold']),
            pw.TextSpan(text: ' to ', style: styles['base']),
            pw.TextSpan(text: payeeName, style: styles['bold']),
            if (payeeAddress.isNotEmpty) pw.TextSpan(text: ', $payeeAddress'),
            if (particulars.isNotEmpty)
              pw.TextSpan(text: ', towards $particulars'),
            pw.TextSpan(text: '.', style: styles['base']),
          ],
        ),
      ),
    );
  }

  /// Helper to build printer-safe page theme
  Future<pw.PageTheme> _buildPageTheme(PdfPageFormat format) async {
    // UPDATED MARGINS:
    // Left/Right: 25mm (keeps text safe from hole punches/binding)
    // Top/Bottom: 10mm (reduced from 22mm to fit more vertical content)
    format = format.applyMargin(
      left: 25 * PdfPageFormat.mm,
      top: 10 * PdfPageFormat.mm,
      right: 25 * PdfPageFormat.mm,
      bottom: 10 * PdfPageFormat.mm,
    );

    return pw.PageTheme(
      pageFormat: format,
      theme: pw.ThemeData.withFont(
        base: await PdfGoogleFonts.robotoRegular(),
        bold: await PdfGoogleFonts.robotoBold(),
      ),
    );
  }

  /// Build text styles map
  Map<String, pw.TextStyle?> _buildTextStyles(pw.Font ttf, pw.Font ttfBold) {
    return {
      'title': pw.TextStyle(
        font: ttfBold,
        fontSize: 13,
        fontWeight: pw.FontWeight.bold,
      ),
      'header': pw.TextStyle(
        font: ttfBold,
        fontSize: 11,
        fontWeight: pw.FontWeight.bold,
      ),
      'bold': pw.TextStyle(
        font: ttfBold,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      'base': pw.TextStyle(font: ttf, fontSize: 10),
      'smallBold': pw.TextStyle(
        font: ttfBold,
        fontSize: 8,
        fontWeight: pw.FontWeight.bold,
      ),
      'small': pw.TextStyle(font: ttf, fontSize: 8),
    };
  }

  /// Build header block with division, vendor details, and payment info
  pw.Widget _buildHeaderBlock(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle?> styles,
  ) {
    final dateStr = _formatDate(pa.date);
    final authorityDateStr = _formatDate(pa.authorityOrderDate);
    final billDateStr = _formatDate(pa.billDate);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Division and date
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Text(
                'Name of unit/Division: ${pa.divisionName}',
                style: styles['bold'],
              ),
            ),
            pw.Text('Dated: $dateStr', style: styles['bold']),
          ],
        ),
        pw.SizedBox(height: 4),

        // Profit center and S.J. entry
        pw.Text('Profit Center: ${pa.divisionCode}', style: styles['base']),
        pw.SizedBox(height: 3),
        pw.Text(
          'S.J. Entry No. ___________________________',
          style: styles['base'],
        ),
        pw.SizedBox(height: 8),

        // Vendor/Payee details
        pw.Text('TO:', style: styles['bold']),
        pw.SizedBox(height: 3),
        pw.Text('Name: ${pa.payeeName}', style: styles['bold']),
        pw.SizedBox(height: 2),

        // Address wrapped in Expanded to prevent overflow
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'Address: ${pa.payeeAddress}',
                style: styles['base'],
                softWrap: true,
              ),
            ),
          ],
        ),

        // PAN and GST details
        if (pa.payeePan != null && pa.payeePan!.isNotEmpty) ...[
          pw.SizedBox(height: 2),
          pw.Text('PAN: ${pa.payeePan}', style: styles['base']),
        ],
        if (pa.payeeGst != null && pa.payeeGst!.isNotEmpty) ...[
          pw.SizedBox(height: 2),
          pw.Text('GST: ${pa.payeeGst}', style: styles['base']),
        ],

        // Bank Details Section
        if ((pa.payeeBankAccount != null && pa.payeeBankAccount!.isNotEmpty) ||
            (pa.payeeIfsc != null && pa.payeeIfsc!.isNotEmpty) ||
            (pa.payeeEmail != null && pa.payeeEmail!.isNotEmpty)) ...[
          pw.SizedBox(height: 6),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                top: pw.BorderSide(width: 0.5, color: PdfColors.grey700),
                bottom: pw.BorderSide(width: 0.5, color: PdfColors.grey700),
              ),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                if (pa.payeeBankAccount != null &&
                    pa.payeeBankAccount!.isNotEmpty)
                  pw.Text(
                    'Bank A/C: ${pa.payeeBankAccount}',
                    style: styles['base'],
                  ),
                if (pa.payeeIfsc != null && pa.payeeIfsc!.isNotEmpty)
                  pw.Text('IFSC: ${pa.payeeIfsc}', style: styles['base']),
                if (pa.payeeEmail != null && pa.payeeEmail!.isNotEmpty)
                  pw.Text('Email: ${pa.payeeEmail}', style: styles['base']),
              ],
            ),
          ),
        ],

        pw.SizedBox(height: 8),

        // Payment particulars
        pw.Text(
          'Particulars of Payment: ${pa.paymentParticulars}',
          style: styles['base'],
        ),
        pw.SizedBox(height: 6),

        // Authority and bill details
        pw.Text(
          'Authority Order No. ${pa.authorityOrderNo} dt. $authorityDateStr',
          style: styles['bold'],
        ),
        pw.SizedBox(height: 3),
        pw.Text(
          'Bill/Invoice No. ${pa.billNo} dt. $billDateStr',
          style: styles['base'],
        ),
        pw.SizedBox(height: 3),
        pw.Text(
          'Amount (Net) Rs. ${_formatIndianNumber(pa.netAmount)} Only', // ✅ NEW
          style: styles['bold']?.copyWith(fontSize: 11),
        ),
      ],
    );
  }

  // ---- Ledger column sizing ----
  static const double _descWidth = 1.5;
  static const double _numHeadWidth = 1.5;
  static const double _amountWidth = 0.9;

  // DEBIT or CREDIT group width (3 columns)
  static const double _groupWidth = _descWidth + _numHeadWidth + _amountWidth;

  /// Build classification table with DEBIT/CREDIT columns using pw.Table
  pw.Widget _buildClassificationTable(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle?> styles, {
    required double maxWidth,
    required Map<String, String> glDescMap,
  }) {
    final maxRows = _getMaxRows(pa.debitLines.length, pa.creditLines.length);

    const columnWidths = {
      0: pw.FlexColumnWidth(_descWidth),
      1: pw.FlexColumnWidth(_numHeadWidth),
      2: pw.FlexColumnWidth(_amountWidth),
      3: pw.FlexColumnWidth(_descWidth),
      4: pw.FlexColumnWidth(_numHeadWidth),
      5: pw.FlexColumnWidth(_amountWidth),
    };

    return pw.Container(
      width: maxWidth,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.0, color: PdfColors.black),
      ),
      child: pw.Column(
        children: [
          // Main title: CLASSIFICATION
          _buildClassificationTitle(styles),

          // Sub-header: DEBIT | CREDIT
          _buildDebitCreditSubHeader(styles),

          // Column headers
          _buildTableColumnHeaders(styles, columnWidths),

          // Data rows
          _buildDataRows(pa, styles, columnWidths, maxRows, glDescMap),
        ],
      ),
    );
  }

  /// Build CLASSIFICATION title row
  pw.Widget _buildClassificationTitle(Map<String, pw.TextStyle?> styles) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
        ),
      ),
      child: pw.Center(
        child: pw.Text('CLASSIFICATION', style: styles['header']),
      ),
    );
  }

  pw.Widget _buildDebitCreditSubHeader(Map<String, pw.TextStyle?> styles) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1, color: PdfColors.black),
        ),
      ),
      child: pw.Table(
        columnWidths: {
          0: pw.FlexColumnWidth(_groupWidth),
          1: pw.FlexColumnWidth(_groupWidth),
        },
        border: pw.TableBorder(
          verticalInside: pw.BorderSide(width: 1, color: PdfColors.black),
        ),
        children: [
          pw.TableRow(
            children: [
              _mergedHeaderCell('DEBIT', styles['header']!),
              _mergedHeaderCell('CREDIT', styles['header']!),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _mergedHeaderCell(String text, pw.TextStyle style) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.symmetric(vertical: 6),
      child: pw.Text(text, style: style),
    );
  }

  /// Build column headers row - ALL CENTERED
  pw.Widget _buildTableColumnHeaders(
    Map<String, pw.TextStyle?> styles,
    Map<int, pw.TableColumnWidth> columnWidths,
  ) {
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
        ),
      ),
      child: pw.Table(
        columnWidths: columnWidths,
        border: pw.TableBorder(
          horizontalInside: pw.BorderSide(width: 0),
          verticalInside: pw.BorderSide(width: 1.0, color: PdfColors.black),
        ),
        children: [
          pw.TableRow(
            children: [
              _headerCellCentered('Description', styles['smallBold']!),
              _headerCellCentered('GL Code', styles['smallBold']!),
              _headerCellCentered('Amount', styles['smallBold']!),

              _headerCellCentered('Description', styles['smallBold']!),
              _headerCellCentered('GL Code', styles['smallBold']!),
              _headerCellCentered('Amount', styles['smallBold']!),
            ],
          ),
        ],
      ),
    );
  }

  /// Build GL Code cell with centered Code (Bold) and ERP Description (Normal)
  pw.Widget _buildGlCodeCell(
    String glCode,
    String glDescription,
    pw.TextStyle codeStyle,
    pw.TextStyle descStyle, {
    bool hasContent = false,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      alignment: pw.Alignment.center, // Vertically center the entire block
      child: hasContent
          ? pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment:
                  pw.CrossAxisAlignment.center, // Horizontally center
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(
                  glCode,
                  style: codeStyle,
                  textAlign: pw.TextAlign.center,
                ),
                if (glDescription.isNotEmpty)
                  pw.Text(
                    glDescription,
                    style: descStyle,
                    textAlign: pw.TextAlign.center,
                    maxLines: 2,
                    overflow: pw.TextOverflow.clip,
                  ),
              ],
            )
          : pw.SizedBox(height: 18),
    );
  }

  /// Build CENTERED header cell widget
  pw.Widget _headerCellCentered(String text, pw.TextStyle style) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: pw.Center(child: pw.Text(text, style: style)),
    );
  }

  /// Build all data rows using pw.Table
  pw.Widget _buildDataRows(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle?> styles,
    Map<int, pw.TableColumnWidth> columnWidths,
    int maxRows,
    Map<String, String> glDescMap,
  ) {
    return pw.Table(
      columnWidths: columnWidths,
      border: pw.TableBorder(
        horizontalInside: pw.BorderSide(width: 1.0, color: PdfColors.black),
        verticalInside: pw.BorderSide(width: 1.0, color: PdfColors.black),
      ),
      children: List.generate(maxRows, (i) {
        final debitLine = i < pa.debitLines.length ? pa.debitLines[i] : null;
        final creditLine = i < pa.creditLines.length ? pa.creditLines[i] : null;
        final showPleasePay = i == 0 && creditLine != null;

        // Get ERP descriptions for GL codes
        final debitGlCode = debitLine?.glCode ?? '';
        final creditGlCode = creditLine?.glCode ?? '';
        final debitErpDesc = glDescMap[debitGlCode.trim()] ?? '';
        final creditErpDesc = glDescMap[creditGlCode.trim()] ?? '';

        return pw.TableRow(
          children: [
            // DEBIT: Description
            _buildDataCell(
              debitLine?.description ?? '',
              styles['small']!,
              hasContent: debitLine != null,
            ),
            // DEBIT: GL Code (Centered with Description)
            _buildGlCodeCell(
              debitGlCode,
              debitErpDesc,
              styles['smallBold']!, // Code is bold
              styles['small']!, // Desc is normal
              hasContent: debitLine != null,
            ),
            // DEBIT: Amount
            _buildDataCell(
              debitLine != null
                  ? _formatIndianNumber(debitLine.amount)
                  : '', // ✅ NEW
              styles['smallBold']!,
              align: pw.TextAlign.right,
              hasContent: debitLine != null,
            ),

            // CREDIT: Description (with optional "Please pay")
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 4,
              ),
              child: creditLine != null
                  ? pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        if (showPleasePay)
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(bottom: 3),
                            child: pw.Text(
                              'Please pay',
                              style: styles['smallBold'],
                            ),
                          ),
                        pw.Text(
                          creditLine.description,
                          style: styles['small'],
                          maxLines: 2,
                          overflow: pw.TextOverflow.clip,
                        ),
                      ],
                    )
                  : pw.SizedBox(height: 18),
            ),
            // CREDIT: GL Code (Centered with Description)
            _buildGlCodeCell(
              creditGlCode,
              creditErpDesc,
              styles['smallBold']!,
              styles['small']!,
              hasContent: creditLine != null,
            ),
            // CREDIT: Amount
            // CREDIT: Amount
            _buildDataCell(
              creditLine != null
                  ? _formatIndianNumber(creditLine.amount)
                  : '', // ✅ NEW
              styles['smallBold']!,
              align: pw.TextAlign.right,
              hasContent: creditLine != null,
            ),
          ],
        );
      }),
    );
  }

  /// Build data cell widget
  pw.Widget _buildDataCell(
    String text,
    pw.TextStyle style, {
    pw.TextAlign align = pw.TextAlign.left,
    bool hasContent = false,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: hasContent
          ? pw.Text(
              text,
              style: style,
              textAlign: align,
              maxLines: 2,
              overflow: pw.TextOverflow.clip,
            )
          : pw.SizedBox(height: 18),
    );
  }

  /// Build gross total row
  pw.Widget _buildGrossTotalRow(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle?> styles, {
    required double maxWidth,
  }) {
    final debitTotal = pa.debitLines.fold(0.0, (sum, l) => sum + l.amount);

    const columnWidths = {
      0: pw.FlexColumnWidth(_descWidth),
      1: pw.FlexColumnWidth(_numHeadWidth),
      2: pw.FlexColumnWidth(_amountWidth),
      3: pw.FlexColumnWidth(_descWidth),
      4: pw.FlexColumnWidth(_numHeadWidth),
      5: pw.FlexColumnWidth(_amountWidth),
    };

    return pw.Container(
      width: maxWidth,
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.0, color: PdfColors.black),
      ),
      child: pw.Table(
        columnWidths: columnWidths,
        border: pw.TableBorder(
          verticalInside: pw.BorderSide(width: 1.0, color: PdfColors.black),
        ),
        children: [
          pw.TableRow(
            children: [
              // DEBIT Total
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
                child: pw.Text('Gross Total', style: styles['bold']),
              ),
              // CREDIT Total
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
                child: pw.Text(
                  _formatIndianNumber(debitTotal), // ✅ NEW
                  style: styles['bold']?.copyWith(fontSize: 11),
                  textAlign: pw.TextAlign.right,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build entire bottom section with signatures, debit to, and cashier
  pw.Widget _buildSignaturesAndDebitSection(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle?> styles, {
    required double maxWidth,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Signatures line
        _buildSignaturesLine(styles),
        pw.SizedBox(height: 12),

        // Cashier details section
        _buildCashierDetailsSection(pa, styles),
      ],
    );
  }

  /// Build signature line with three signature boxes
  pw.Widget _buildSignaturesLine(Map<String, pw.TextStyle?> styles) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 24), // Reduced from 32
            pw.Text('Sig. of Dealing Asstt.', style: styles['small']),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 24), // Reduced from 32
            pw.Text('Sig. of D.A.', style: styles['small']),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 24), // Reduced from 32
            pw.Text('Sig. of E.E.', style: styles['small']),
          ],
        ),
      ],
    );
  }

  /// Build cashier section with D.A.(W), Dated, Sig. of Cashier
  pw.Widget _buildCashierDetailsSection(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle?> styles,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Top row: Payment info on left, D.A.(W) on right
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Paid in cash /by Cheque vide cash Book Vr. No.',
                  style: styles['small'],
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  'Cheque No. ___________________________',
                  style: styles['small'],
                ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text('D.A.(W)', style: styles['smallBold']),
                pw.SizedBox(height: 2),
                pw.Text('Dated ___________', style: styles['small']),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 10),

        // Bottom row: Disclaimer on left, Cashier signature on right
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Text(
                '* Here indicate liability Account Code 4501/4502/4503 as the case may be .',
                style: styles['small'],
              ),
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.SizedBox(height: 24), // Reduced from 32
                pw.Text('Sig. of Cashier', style: styles['small']),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Convert amount to Indian words (Crore, Lakh, Thousand, etc.)
  String _convertAmountToWords(double amount) {
    int rupees = amount.toInt();
    int paise = ((amount - rupees) * 100).round();

    const oneDigits = [
      '',
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
    ];

    const teens = [
      'Ten',
      'Eleven',
      'Twelve',
      'Thirteen',
      'Fourteen',
      'Fifteen',
      'Sixteen',
      'Seventeen',
      'Eighteen',
      'Nineteen',
    ];

    const tens = [
      '',
      '',
      'Twenty',
      'Thirty',
      'Forty',
      'Fifty',
      'Sixty',
      'Seventy',
      'Eighty',
      'Ninety',
    ];

    String convertBelowThousand(int num) {
      if (num == 0) {
        return '';
      } else if (num < 10) {
        return oneDigits[num];
      } else if (num < 20) {
        return teens[num - 10];
      } else if (num < 100) {
        return '${tens[num ~/ 10]}${num % 10 != 0 ? ' ${oneDigits[num % 10]}' : ''}'
            .trim();
      } else {
        return '${oneDigits[num ~/ 100]} Hundred${num % 100 != 0 ? ' ${convertBelowThousand(num % 100)}' : ''}'
            .trim();
      }
    }

    final parts = <String>[];

    // Crore (10 million)
    final crore = rupees ~/ 10000000;
    if (crore > 0) {
      parts.add('${convertBelowThousand(crore)} Crore');
    }

    // Lakh (100 thousand)
    final lakh = (rupees % 10000000) ~/ 100000;
    if (lakh > 0) {
      parts.add('${convertBelowThousand(lakh)} Lakh');
    }

    // Thousand
    final thousand = (rupees % 100000) ~/ 1000;
    if (thousand > 0) {
      parts.add('${convertBelowThousand(thousand)} Thousand');
    }

    // Hundreds and below
    final remainder = rupees % 1000;
    if (remainder > 0) {
      parts.add(convertBelowThousand(remainder));
    }

    String result = parts.join(' ').trim();
    if (result.isEmpty) {
      result = 'Zero';
    }

    if (paise > 0) {
      result += ' and ${convertBelowThousand(paise)} Paise';
    }

    return '$result Only';
  }

  /// Format date as DD-MM-YYYY
  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';

  /// Get maximum row count between debit and credit lines
  int _getMaxRows(int debitCount, int creditCount) =>
      debitCount > creditCount ? debitCount : creditCount;

  /// Save PDF with vendor_billnumber filename (sanitized)
  Future<File> _savePdfToFile(
    Uint8List bytes,
    pa_model.PaymentAuthorityPdfModel pa,
  ) async {
    final output = await getApplicationDocumentsDirectory();

    // Sanitize vendor name and bill number for filename
    final sanitizedVendor = _sanitizeFilename(pa.payeeName);
    final sanitizedBill = _sanitizeFilename(pa.billNo);

    final filename = '${sanitizedVendor}_$sanitizedBill.pdf';

    final file = File('${output.path}/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  /// Sanitize filename by removing special characters
  String _sanitizeFilename(String input) {
    // Remove special characters, keep only alphanumeric, underscore, hyphen
    return input
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special chars
        .replaceAll(RegExp(r'\s+'), '_') // Replace spaces with underscore
        .replaceAll(
          RegExp(r'_+'),
          '_',
        ) // Replace multiple underscores with single
        .trim();
  }

  /// Format number with Indian comma notation (e.g., 1,05,84,282.50)
  String _formatIndianNumber(double amount) {
    // Split into rupees and paise
    final rupees = amount.floor();
    final paise = ((amount - rupees) * 100).round();

    // Convert to string
    String rupeesStr = rupees.toString();

    // If less than 1000, no commas needed
    if (rupeesStr.length <= 3) {
      return paise > 0
          ? '$rupeesStr.${paise.toString().padLeft(2, '0')}'
          : '$rupeesStr.00';
    }

    // Split: last 3 digits, then groups of 2
    final lastThree = rupeesStr.substring(rupeesStr.length - 3);
    final remaining = rupeesStr.substring(0, rupeesStr.length - 3);

    // Add commas every 2 digits in remaining part (from right to left)
    String formatted = '';
    int count = 0;
    for (int i = remaining.length - 1; i >= 0; i--) {
      if (count == 2) {
        formatted = ',$formatted';
        count = 0;
      }
      formatted = remaining[i] + formatted;
      count++;
    }

    // Combine with last three digits
    formatted = '$formatted,$lastThree';

    // Add paise
    return '$formatted.${paise.toString().padLeft(2, '0')}';
  }
}
