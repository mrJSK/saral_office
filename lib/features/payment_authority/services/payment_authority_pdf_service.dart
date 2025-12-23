// lib/features/payment_authority/services/payment_authority_pdf_service.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../providers/payment_authority_pdf_model.dart' as pa_model;

class PaymentAuthorityPdfService {
  PaymentAuthorityPdfService();

  /// Generate PDF and open it
  Future<File> generateAndOpen(pa_model.PaymentAuthorityPdfModel pa) async {
    final pdfBytes = await _buildPdf(pa);
    final file = await _savePdfToFile(pdfBytes);
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

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(15),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Title
              pw.Center(
                child: pw.Text(
                  'FOR CASH PAYMENT ONLY',
                  style: textStyles['title'],
                ),
              ),
              pw.SizedBox(height: 12),

              // Header details section
              _buildHeaderBlock(pa, textStyles),
              pw.SizedBox(height: 12),

              // Classification table with DEBIT/CREDIT
              _buildClassificationTable(pa, textStyles),
              pw.SizedBox(height: 10),

              // Gross total row
              _buildGrossTotalRow(pa, textStyles),
              pw.SizedBox(height: 16),

              // Complete bottom section with signatures, debit to, and cashier
              _buildSignaturesAndDebitSection(pa, textStyles),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  /// Build text styles map
  Map<String, pw.TextStyle> _buildTextStyles(pw.Font ttf, pw.Font ttfBold) {
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
    Map<String, pw.TextStyle> styles,
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
        pw.Text('Address: ${pa.payeeAddress}', style: styles['base']),
        if (pa.payeePan != null && pa.payeePan!.isNotEmpty)
          pw.Text('PAN: ${pa.payeePan}', style: styles['base']),
        if (pa.payeeGst != null && pa.payeeGst!.isNotEmpty)
          pw.Text('GST: ${pa.payeeGst}', style: styles['base']),
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
          'Amount (Net) Rs. ${pa.netAmount.toStringAsFixed(2)} Only',
          style: styles['bold']?.copyWith(fontSize: 11),
        ),
      ],
    );
  }

  /// Build classification table with DEBIT/CREDIT columns using pw.Table
  pw.Widget _buildClassificationTable(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle> styles,
  ) {
    final maxRows = _getMaxRows(pa.debitLines.length, pa.creditLines.length);

    // Column width ratios
    const columnWidths = {
      0: pw.FlexColumnWidth(2.0), // DEBIT Description
      1: pw.FlexColumnWidth(1.2), // DEBIT Numerical Head
      2: pw.FlexColumnWidth(1.0), // DEBIT Amount
      3: pw.FlexColumnWidth(0.3), // Divider
      4: pw.FlexColumnWidth(2.0), // CREDIT Description
      5: pw.FlexColumnWidth(1.2), // CREDIT Numerical Head
      6: pw.FlexColumnWidth(1.0), // CREDIT Amount
    };

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.0, color: PdfColors.black),
      ),
      child: pw.Column(
        children: [
          // Main title: CLASSIFICATION (spanning full width)
          _buildClassificationTitle(styles),

          // Sub-header: DEBIT | CREDIT
          _buildDebitCreditSubHeader(styles, columnWidths),

          // Column headers
          _buildTableColumnHeaders(styles, columnWidths),

          // Data rows
          _buildDataRows(pa, styles, columnWidths, maxRows),
        ],
      ),
    );
  }

  /// Build CLASSIFICATION title row
  pw.Widget _buildClassificationTitle(Map<String, pw.TextStyle> styles) {
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

  /// Build DEBIT | CREDIT sub-header
  pw.Widget _buildDebitCreditSubHeader(
    Map<String, pw.TextStyle> styles,
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
              // DEBIT header (columns 0-2)
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                child: pw.Text('DEBIT', style: styles['header']),
              ),
              pw.SizedBox(),
              pw.SizedBox(),
              // Divider
              pw.SizedBox(),
              // CREDIT header (columns 4-6)
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                child: pw.Text('CREDIT', style: styles['header']),
              ),
              pw.SizedBox(),
              pw.SizedBox(),
            ],
          ),
        ],
      ),
    );
  }

  /// Build column headers row
  pw.Widget _buildTableColumnHeaders(
    Map<String, pw.TextStyle> styles,
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
              _headerCell('Description', styles['smallBold']!),
              _headerCell('Numerical Head', styles['smallBold']!),
              _headerCell('Amount', styles['smallBold']!),
              pw.SizedBox(), // Divider
              _headerCell('Description', styles['smallBold']!),
              _headerCell('Numerical Head', styles['smallBold']!),
              _headerCell('Amount', styles['smallBold']!),
            ],
          ),
        ],
      ),
    );
  }

  /// Build header cell widget
  pw.Widget _headerCell(String text, pw.TextStyle style) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: pw.Text(text, style: style),
    );
  }

  /// Build all data rows using pw.Table
  pw.Widget _buildDataRows(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle> styles,
    Map<int, pw.TableColumnWidth> columnWidths,
    int maxRows,
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

        return pw.TableRow(
          children: [
            // DEBIT: Description
            _buildDataCell(
              debitLine?.description ?? '',
              styles['small']!,
              hasContent: debitLine != null,
            ),
            // DEBIT: Numerical Head
            _buildDataCell(
              debitLine?.glCode ?? '',
              styles['smallBold']!,
              hasContent: debitLine != null,
            ),
            // DEBIT: Amount
            _buildDataCell(
              debitLine?.amount.toStringAsFixed(2) ?? '',
              styles['smallBold']!,
              align: pw.TextAlign.right,
              hasContent: debitLine != null,
            ),
            // Divider
            pw.SizedBox(),
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
            // CREDIT: Numerical Head
            _buildDataCell(
              creditLine?.glCode ?? '',
              styles['smallBold']!,
              hasContent: creditLine != null,
            ),
            // CREDIT: Amount
            _buildDataCell(
              creditLine?.amount.toStringAsFixed(2) ?? '',
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
    Map<String, pw.TextStyle> styles,
  ) {
    final debitTotal = pa.debitLines.fold<double>(
      0.0,
      (sum, l) => sum + l.amount,
    );
    final creditTotal = pa.creditLines.fold<double>(
      0.0,
      (sum, l) => sum + l.amount,
    );

    const columnWidths = {
      0: pw.FlexColumnWidth(2.0),
      1: pw.FlexColumnWidth(1.2),
      2: pw.FlexColumnWidth(1.0),
      3: pw.FlexColumnWidth(0.3),
      4: pw.FlexColumnWidth(2.0),
      5: pw.FlexColumnWidth(1.2),
      6: pw.FlexColumnWidth(1.0),
    };

    return pw.Container(
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
              pw.SizedBox(), // Col 0
              pw.SizedBox(), // Col 1
              // DEBIT Total
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
                child: pw.Text('Gross Total', style: styles['bold']),
              ),
              pw.SizedBox(), // Divider
              pw.SizedBox(), // Col 4
              pw.SizedBox(), // Col 5
              // CREDIT Total
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 6,
                ),
                child: pw.Text(
                  debitTotal.toStringAsFixed(2),
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
    Map<String, pw.TextStyle> styles,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Amount in words section
        _buildAmountInWordsSection(pa, styles),
        pw.SizedBox(height: 10),

        // Please pay to section with vendor details table
        _buildPleasePaysToSection(pa, styles),
        pw.SizedBox(height: 12),

        // Vendor details table
        _buildVendorDetailsTable(pa, styles),
        pw.SizedBox(height: 14),

        // Signatures line
        _buildSignaturesLine(styles),
        pw.SizedBox(height: 12),

        // Cashier details section
        _buildCashierDetailsSection(pa, styles),
      ],
    );
  }

  /// Amount in words section
  pw.Widget _buildAmountInWordsSection(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle> styles,
  ) {
    final amountInWords = _convertAmountToWords(pa.netAmount);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Received Rupees (in words)', style: styles['base']),
        pw.SizedBox(height: 4),
        pw.Text(amountInWords, style: styles['bold']),
      ],
    );
  }

  /// Please pay to section with vendor details inline
  pw.Widget _buildPleasePaysToSection(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle> styles,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('to', style: styles['base']),
        pw.SizedBox(width: 160),
        pw.Text('and Debit to', style: styles['base']),
      ],
    );
  }

  /// Vendor details table with Name, Address, PAN, GST
  /// Vendor details table with Name, Address, PAN, GST
  pw.Widget _buildVendorDetailsTable(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle> styles,
  ) {
    return pw.Table(
      border: pw.TableBorder.all(width: 0.5, color: PdfColors.black),
      columnWidths: const {0: pw.FlexColumnWidth(1), 1: pw.FlexColumnWidth(3)},
      children: [
        _buildVendorTableRow('Name', pa.payeeName, styles),
        _buildVendorTableRow('Address', pa.payeeAddress, styles),
        // This will now work correctly if the data is passed
        if (pa.payeePan != null && pa.payeePan!.isNotEmpty)
          _buildVendorTableRow('PAN', pa.payeePan!, styles),
        if (pa.payeeGst != null && pa.payeeGst!.isNotEmpty)
          _buildVendorTableRow('GST', pa.payeeGst!, styles),
      ],
    );
  }

  /// Build individual vendor table row
  pw.TableRow _buildVendorTableRow(
    String label,
    String value,
    Map<String, pw.TextStyle> styles,
  ) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(label, style: styles['smallBold']),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(value, style: styles['small']),
        ),
      ],
    );
  }

  /// Build signature line with three signature boxes
  pw.Widget _buildSignaturesLine(Map<String, pw.TextStyle> styles) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 32),
            pw.Text('Sig. of Dealing Asstt.', style: styles['small']),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 32),
            pw.Text('Sig. of D.A.', style: styles['small']),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 32),
            pw.Text('Sig. of E.E.', style: styles['small']),
          ],
        ),
      ],
    );
  }

  /// Build cashier section with D.A.(W), Dated, Sig. of Cashier
  pw.Widget _buildCashierDetailsSection(
    pa_model.PaymentAuthorityPdfModel pa,
    Map<String, pw.TextStyle> styles,
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
                pw.SizedBox(height: 32),
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

  /// Save PDF bytes to file
  Future<File> _savePdfToFile(Uint8List bytes) async {
    final output = await getApplicationDocumentsDirectory();
    final file = File(
      '${output.path}/payment_authority_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(bytes);
    return file;
  }
}
