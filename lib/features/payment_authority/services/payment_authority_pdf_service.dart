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

  Future<File> generateAndOpen(pa_model.PaymentAuthorityPdfModel pa) async {
    final pdfBytes = await _buildPdf(pa);
    final file = await _savePdfToFile(pdfBytes);
    await OpenFilex.open(file.path);
    return file;
  }

  Future<Uint8List> _buildPdf(pa_model.PaymentAuthorityPdfModel pa) async {
    final doc = pw.Document();

    // Use PdfGoogleFonts for bold fonts
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

              // Three-column Debit/Credit/Classification table
              _buildThreeColumnTable(
                pa,
                baseTextStyle,
                boldTextStyle,
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
              _buildAmountAndDebitToSection(baseTextStyle),
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
        pw.Text('Profit Center. ${pa.divisionCode}', style: base),
        pw.SizedBox(height: 3),
        pw.Text('S.J. Entry No. ___________________________', style: base),
        pw.SizedBox(height: 6),

        // Payee info
        pw.Text('Name of Payee: ${pa.payeeName}', style: bold),
        pw.SizedBox(height: 2),
        pw.Text('Address: ${pa.payeeAddress}', style: base),
        pw.SizedBox(height: 6),

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

  /// Three-column table: DEBIT | CLASSIFICATION | CREDIT
  pw.Widget _buildThreeColumnTable(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
    pw.TextStyle bold,
    pw.TextStyle header,
  ) {
    final maxRows = pa.debitLines.length > pa.creditLines.length
        ? pa.debitLines.length
        : pa.creditLines.length;

    // Header row with three columns
    final headerRow = pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(width: 1.0, color: PdfColors.black),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          // DEBIT column header
          pw.Expanded(
            flex: 3,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 6,
              ),
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  right: pw.BorderSide(width: 1.0, color: PdfColors.black),
                ),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('DEBIT', style: header),
                  pw.Text('Description', style: bold.copyWith(fontSize: 8)),
                  pw.Text('Numerical Head', style: bold.copyWith(fontSize: 8)),
                  pw.Text('AMOUNT', style: bold.copyWith(fontSize: 8)),
                ],
              ),
            ),
          ),
          // CLASSIFICATION column header (middle)
          pw.Expanded(
            flex: 1,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 6,
              ),
              decoration: pw.BoxDecoration(
                border: pw.Border(
                  right: pw.BorderSide(width: 1.0, color: PdfColors.black),
                ),
              ),
              child: pw.Center(child: pw.Text('CLASSIFICATION', style: header)),
            ),
          ),
          // CREDIT column header
          pw.Expanded(
            flex: 3,
            child: pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 6,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('CREDIT', style: header),
                  pw.Text('Description', style: bold.copyWith(fontSize: 8)),
                  pw.Text('Numerical Head', style: bold.copyWith(fontSize: 8)),
                  pw.Text('AMOUNT', style: bold.copyWith(fontSize: 8)),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    // Data rows
    final dataRows = <pw.Widget>[];
    for (int i = 0; i < maxRows; i++) {
      final debitLine = i < pa.debitLines.length ? pa.debitLines[i] : null;
      final creditLine = i < pa.creditLines.length ? pa.creditLines[i] : null;

      dataRows.add(
        pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border(
              left: pw.BorderSide(width: 1.0, color: PdfColors.black),
              right: pw.BorderSide(width: 1.0, color: PdfColors.black),
              bottom: pw.BorderSide(width: 1.0, color: PdfColors.black),
            ),
          ),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Debit side
              pw.Expanded(
                flex: 3,
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 6,
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(width: 1.0, color: PdfColors.black),
                    ),
                  ),
                  child: debitLine != null
                      ? pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              debitLine.description,
                              style: base,
                              maxLines: 2,
                              overflow: pw.TextOverflow.clip,
                            ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  debitLine.glCode,
                                  style: bold.copyWith(fontSize: 9),
                                ),
                                pw.Text(
                                  debitLine.amount.toStringAsFixed(2),
                                  style: bold.copyWith(fontSize: 9),
                                ),
                              ],
                            ),
                          ],
                        )
                      : pw.SizedBox(height: 20),
                ),
              ),
              // Classification column (middle - empty)
              pw.Expanded(
                flex: 1,
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 6,
                  ),
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(width: 1.0, color: PdfColors.black),
                    ),
                  ),
                  child: pw.SizedBox(height: 20),
                ),
              ),
              // Credit side
              pw.Expanded(
                flex: 3,
                child: pw.Container(
                  padding: const pw.EdgeInsets.symmetric(
                    horizontal: 3,
                    vertical: 6,
                  ),
                  child: creditLine != null
                      ? pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              creditLine.description,
                              style: base,
                              maxLines: 2,
                              overflow: pw.TextOverflow.clip,
                            ),
                            pw.SizedBox(height: 2),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text(
                                  creditLine.glCode,
                                  style: bold.copyWith(fontSize: 9),
                                ),
                                pw.Text(
                                  creditLine.amount.toStringAsFixed(2),
                                  style: bold.copyWith(fontSize: 9),
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
        ),
      );
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [headerRow, ...dataRows],
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
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
          pw.VerticalDivider(width: 1.0),
          pw.Expanded(flex: 1, child: pw.SizedBox()),
          pw.VerticalDivider(width: 1.0),
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

  pw.Widget _buildAmountAndDebitToSection(pw.TextStyle base) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Received Rupees (in words)', style: base),
        pw.Divider(height: 20),
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

  Future<File> _savePdfToFile(Uint8List bytes) async {
    final output = await getApplicationDocumentsDirectory();
    final file = File(
      '${output.path}/payment_authority_${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    await file.writeAsBytes(bytes);
    return file;
  }
}
