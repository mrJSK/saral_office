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

  Future generateAndOpen(pa_model.PaymentAuthorityPdfModel pa) async {
    final pdfBytes = await _buildPdf(pa);
    final file = await _savePdfToFile(pdfBytes);
    await OpenFilex.open(file.path);
    return file;
  }

  Future<Uint8List> _buildPdf(pa_model.PaymentAuthorityPdfModel pa) async {
    final doc = pw.Document();

    // Use PdfGoogleFonts for fonts
    final ttf = await PdfGoogleFonts.robotoRegular();
    final ttfBold = await PdfGoogleFonts.robotoBold();

    final baseTextStyle = pw.TextStyle(font: ttf, fontSize: 10);
    final boldTextStyle = pw.TextStyle(
      font: ttfBold,
      fontSize: 10,
      fontWeight: pw.FontWeight.bold,
    );
    final headerTextStyle = pw.TextStyle(
      font: ttfBold,
      fontSize: 11,
      fontWeight: pw.FontWeight.bold,
    );
    final titleTextStyle = pw.TextStyle(
      font: ttfBold,
      fontSize: 13,
      fontWeight: pw.FontWeight.bold,
    );
    final smallTextStyle = pw.TextStyle(font: ttf, fontSize: 8);
    final smallBoldTextStyle = pw.TextStyle(
      font: ttfBold,
      fontSize: 8,
      fontWeight: pw.FontWeight.bold,
    );

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
                child: pw.Text('FOR CASH PAYMENT ONLY', style: titleTextStyle),
              ),
              pw.SizedBox(height: 12),

              // Header details section
              _buildHeaderBlock(pa, baseTextStyle, boldTextStyle),
              pw.SizedBox(height: 12),

              // Improved Classification Table with equal DEBIT/CREDIT division
              _buildImprovedClassificationTable(
                pa,
                baseTextStyle,
                boldTextStyle,
                smallTextStyle,
                smallBoldTextStyle,
                headerTextStyle,
              ),
              pw.SizedBox(height: 10),

              // Gross total row
              _buildGrossTotalRow(pa, baseTextStyle, boldTextStyle),
              pw.SizedBox(height: 16),

              // Signatures section
              _buildSignaturesSection(baseTextStyle),
              pw.SizedBox(height: 14),

              // Amount in words and debit to
              _buildAmountAndDebitToSection(pa, baseTextStyle, boldTextStyle),
              pw.SizedBox(height: 16),

              // Cashier section
              _buildCashierSection(baseTextStyle),
            ],
          );
        },
      ),
    );

    return doc.save();
  }

  pw.Widget _buildHeaderBlock(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
    pw.TextStyle bold,
  ) {
    String fmtDate(DateTime d) =>
        '${d.day.toString().padLeft(2, '0')}-${d.month.toString().padLeft(2, '0')}-${d.year}';

    final dateStr = fmtDate(pa.date);
    final authorityDateStr = fmtDate(pa.authorityOrderDate);
    final billDateStr = fmtDate(pa.billDate);

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
                style: bold,
              ),
            ),
            pw.Text('Dated: $dateStr', style: bold),
          ],
        ),
        pw.SizedBox(height: 3),
        pw.Text('Profit Center: ${pa.divisionCode}', style: base),
        pw.SizedBox(height: 3),
        pw.Text('S.J. Entry No. ___________________________', style: base),
        pw.SizedBox(height: 8),

        // Vendor/Payee details - Enhanced
        pw.Text('TO:', style: bold),
        pw.SizedBox(height: 3),
        pw.Text('Name: ${pa.payeeName}', style: bold),
        pw.SizedBox(height: 2),
        pw.Text('Address: ${pa.payeeAddress}', style: base),
        if (pa.payeePan != null && pa.payeePan!.isNotEmpty)
          pw.Text('PAN: ${pa.payeePan}', style: base),
        if (pa.payeeGst != null && pa.payeeGst!.isNotEmpty)
          pw.Text('GST: ${pa.payeeGst}', style: base),
        pw.SizedBox(height: 8),

        // Payment particulars
        pw.Text(
          'Particulars of Payment: ${pa.paymentParticulars}',
          style: base,
        ),
        pw.SizedBox(height: 6),

        // Authority and bill details
        pw.Text(
          'Authority Order No. ${pa.authorityOrderNo} dt. $authorityDateStr',
          style: bold,
        ),
        pw.SizedBox(height: 3),
        pw.Text('Bill/Invoice No. ${pa.billNo} dt. $billDateStr', style: base),
        pw.SizedBox(height: 3),
        pw.Text(
          'Amount (Net) Rs. ${pa.netAmount.toStringAsFixed(2)} Only',
          style: bold.copyWith(fontSize: 11),
        ),
      ],
    );
  }

  /// Improved Classification Table with better DEBIT/CREDIT structure
  pw.Widget _buildImprovedClassificationTable(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
    pw.TextStyle bold,
    pw.TextStyle small,
    pw.TextStyle smallBold,
    pw.TextStyle header,
  ) {
    final maxRows = pa.debitLines.length > pa.creditLines.length
        ? pa.debitLines.length
        : pa.creditLines.length;

    // Main container with border
    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.0, color: PdfColors.black),
      ),
      child: pw.Column(
        children: [
          // Header row: CLASSIFICATION title spanning full width
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            decoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
              ),
            ),
            child: pw.Center(child: pw.Text('CLASSIFICATION', style: header)),
          ),

          // Sub-header row: DEBIT | | CREDIT
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
              ),
            ),
            child: pw.Row(
              children: [
                // DEBIT column header
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                        right: pw.BorderSide(
                          width: 1.0,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    child: pw.Text('DEBIT', style: header),
                  ),
                ),

                // Divider space (for visual separation)
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                        right: pw.BorderSide(
                          width: 1.0,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    child: pw.SizedBox(),
                  ),
                ),

                // CREDIT column header
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: pw.Text('CREDIT', style: header),
                  ),
                ),
              ],
            ),
          ),

          // Column headers row
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
              ),
            ),
            child: pw.Row(
              children: [
                // DEBIT column headers
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 3,
                    ),
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                        right: pw.BorderSide(
                          width: 1.0,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text('Description', style: smallBold),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text('Numerical Head', style: smallBold),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text('Amount', style: smallBold),
                        ),
                      ],
                    ),
                  ),
                ),

                // Divider
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    decoration: pw.BoxDecoration(
                      border: pw.Border(
                        right: pw.BorderSide(
                          width: 1.0,
                          color: PdfColors.black,
                        ),
                      ),
                    ),
                    child: pw.SizedBox(),
                  ),
                ),

                // CREDIT column headers
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 3,
                    ),
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Expanded(
                          flex: 2,
                          child: pw.Text('Description', style: smallBold),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text('Numerical Head', style: smallBold),
                        ),
                        pw.Expanded(
                          flex: 1,
                          child: pw.Text('Amount', style: smallBold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Data rows
          ...List.generate(maxRows, (i) {
            final debitLine = i < pa.debitLines.length
                ? pa.debitLines[i]
                : null;
            final creditLine = i < pa.creditLines.length
                ? pa.creditLines[i]
                : null;

            // Check if this is the first credit line for "Please pay" message
            final showPleasePayInCredit = i == 0 && creditLine != null;

            return pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
                ),
              ),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // DEBIT column data
                  pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(
                            width: 1.0,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                      child: debitLine != null
                          ? pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(
                                    debitLine.description,
                                    style: small,
                                    maxLines: 2,
                                    overflow: pw.TextOverflow.clip,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Text(
                                    debitLine.glCode,
                                    style: smallBold,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Text(
                                    debitLine.amount.toStringAsFixed(2),
                                    style: smallBold,
                                    textAlign: pw.TextAlign.right,
                                  ),
                                ),
                              ],
                            )
                          : pw.SizedBox(height: 20),
                    ),
                  ),

                  // Divider column
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border(
                          right: pw.BorderSide(
                            width: 1.0,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                      child: pw.SizedBox(height: 20),
                    ),
                  ),

                  // CREDIT column data
                  pw.Expanded(
                    flex: 3,
                    child: pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 4,
                      ),
                      child: creditLine != null
                          ? pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                              children: [
                                // "Please pay" text on first credit line
                                if (showPleasePayInCredit)
                                  pw.Padding(
                                    padding: const pw.EdgeInsets.only(
                                      bottom: 3,
                                    ),
                                    child: pw.Text(
                                      'Please pay',
                                      style: smallBold,
                                    ),
                                  ),
                                pw.Row(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Expanded(
                                      flex: 2,
                                      child: pw.Text(
                                        creditLine.description,
                                        style: small,
                                        maxLines: 2,
                                        overflow: pw.TextOverflow.clip,
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 1,
                                      child: pw.Text(
                                        creditLine.glCode,
                                        style: smallBold,
                                      ),
                                    ),
                                    pw.Expanded(
                                      flex: 1,
                                      child: pw.Text(
                                        creditLine.amount.toStringAsFixed(2),
                                        style: smallBold,
                                        textAlign: pw.TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : pw.SizedBox(height: 20),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  pw.Widget _buildGrossTotalRow(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
    pw.TextStyle bold,
  ) {
    final debitTotal = pa.debitLines.fold(0.0, (sum, l) => sum + l.amount);
    final creditTotal = pa.creditLines.fold(0.0, (sum, l) => sum + l.amount);

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.0, color: PdfColors.black),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 6),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Expanded(
            flex: 3,
            child: pw.Row(
              children: [
                pw.Text('Gross Total', style: bold),
                pw.Spacer(),
                pw.Text(
                  'Rs. ${debitTotal.toStringAsFixed(2)}',
                  style: bold.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
          pw.Container(width: 1, height: 20, color: PdfColors.black),
          pw.Expanded(flex: 1, child: pw.SizedBox()),
          pw.Container(width: 1, height: 20, color: PdfColors.black),
          pw.Expanded(
            flex: 3,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [
                pw.Text(
                  'Rs. ${creditTotal.toStringAsFixed(2)}',
                  style: bold.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildSignaturesSection(pw.TextStyle base) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 40),
            pw.Text('Prepared By', style: base),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 40),
            pw.Text('Checked By', style: base),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.SizedBox(height: 40),
            pw.Text('Passed for Payment', style: base),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildAmountAndDebitToSection(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
    pw.TextStyle bold,
  ) {
    // Convert amount to Indian words
    final amountInWords = _convertAmountToWords(pa.netAmount);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Received Rupees (in words)', style: base),
        pw.SizedBox(height: 8),
        pw.Text(amountInWords, style: bold),
        pw.SizedBox(height: 20),
        pw.Text('And Debit to', style: base),
        pw.SizedBox(height: 16),
        pw.Text(
          'Name ___________________________________________',
          style: base,
        ),
        pw.SizedBox(height: 16),
        pw.Text(
          'Signature _______________________________________',
          style: base,
        ),
      ],
    );
  }

  pw.Widget _buildCashierSection(pw.TextStyle base) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'To The Cashier,\nPay Cash / Cheque Rs. ______________________________',
          style: base,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          '(Rupees _________________________________________________________________)',
          style: base,
        ),
        pw.SizedBox(height: 14),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('Rs.', style: base),
            pw.Text('Cheque No. ______________', style: base),
            pw.Text('Manager', style: base),
          ],
        ),
        pw.SizedBox(height: 16),
        pw.Text(
          '* Here indicate liability Account Code 4501/4502/4503 as the case may be.',
          style: base.copyWith(fontSize: 8),
        ),
      ],
    );
  }

  /// Convert amount to Indian words
  String _convertAmountToWords(double amount) {
    int rupees = amount.toInt();
    int paise = ((amount - rupees) * 100).round();

    final oneDigits = [
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
    final teens = [
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
    final tens = [
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
        return '${tens[num ~/ 10]}${num % 10 != 0 ? ' ${oneDigits[num % 10]}' : ''}';
      } else {
        return '${oneDigits[num ~/ 100]} Hundred${num % 100 != 0 ? ' ${convertBelowThousand(num % 100)}' : ''}';
      }
    }

    List<String> parts = [];

    // Crore
    int crore = rupees ~/ 10000000;
    if (crore > 0) {
      parts.add('${convertBelowThousand(crore)} Crore');
    }

    // Lakh
    int lakh = (rupees % 10000000) ~/ 100000;
    if (lakh > 0) {
      parts.add('${convertBelowThousand(lakh)} Lakh');
    }

    // Thousand
    int thousand = (rupees % 100000) ~/ 1000;
    if (thousand > 0) {
      parts.add('${convertBelowThousand(thousand)} Thousand');
    }

    // Remainder (hundreds and below)
    int remainder = rupees % 1000;
    if (remainder > 0) {
      parts.add(convertBelowThousand(remainder));
    }

    String result = parts.join(' ');
    if (result.isEmpty) {
      result = 'Zero';
    }

    if (paise > 0) {
      result += ' and ${convertBelowThousand(paise)} Paise';
    }

    return '$result Only';
  }

  Future<File> _savePdfToFile(Uint8List bytes) async {
    final output = await getApplicationDocumentsDirectory();
    final file = File(
      '${output.path}/payment_authority_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(bytes);
    return file;
  }
}
