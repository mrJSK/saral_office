// lib/features/payment_authority/services/payment_authority_pdf_service.dart

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Import the model with a prefix to avoid name clashes.
import '../providers/payment_authority_pdf_model.dart' as pa_model;

class PaymentAuthorityPdfService {
  PaymentAuthorityPdfService();

  /// Public entry: generate, save and open the PDF.
  Future<File> generateAndOpen(pa_model.PaymentAuthorityPdfModel pa) async {
    final pdfBytes = await _buildPdf(pa);
    final file = await _savePdfToFile(pdfBytes);
    await OpenFilex.open(file.path);
    return file;
  }

  Future<Uint8List> _buildPdf(pa_model.PaymentAuthorityPdfModel pa) async {
    final doc = pw.Document();

    final fontData = await rootBundle.load('assets/fonts/Roboto-Regular.ttf');
    final boldFontData = await rootBundle.load('assets/fonts/Roboto-Bold.ttf');

    final ttf = pw.Font.ttf(fontData);
    final ttfBold = pw.Font.ttf(boldFontData);

    final baseTextStyle = pw.TextStyle(font: ttf, fontSize: 9);
    final boldTextStyle = pw.TextStyle(
      font: ttfBold,
      fontSize: 9,
      fontWeight: pw.FontWeight.bold,
    );

    final amountFormat = (double value) => value.toStringAsFixed(2);

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              // Title
              pw.Center(
                child: pw.Text(
                  'FOR CASH PAYMENT ONLY',
                  style: boldTextStyle.copyWith(fontSize: 12),
                ),
              ),
              pw.SizedBox(height: 8),

              // Top header block (division, payee, particulars etc.)
              _buildHeaderBlock(pa, baseTextStyle, boldTextStyle),

              pw.SizedBox(height: 8),

              // Debit/Credit table header
              _buildDebitCreditHeader(boldTextStyle),

              // Debit/Credit table body
              _buildDebitCreditBody(
                pa,
                baseTextStyle,
                boldTextStyle,
                amountFormat,
              ),

              pw.SizedBox(height: 8),

              // Gross total row
              _buildGrossTotalRow(
                pa,
                baseTextStyle,
                boldTextStyle,
                amountFormat,
              ),

              pw.SizedBox(height: 20),

              // Prepared / Checked / Passed signatures
              _buildSignaturesSection(baseTextStyle),

              pw.SizedBox(height: 12),

              // Amount in words and to / and Debit to lines
              _buildAmountAndDebitToSection(pa, baseTextStyle),

              pw.SizedBox(height: 18),

              // Bottom cashier / cheque details
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
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              flex: 3,
              child: pw.Text(
                'Name of unit/Division: ${pa.divisionName}.  Code No. ${pa.divisionCode}',
                style: base,
              ),
            ),
            pw.SizedBox(width: 8),
            pw.Expanded(
              flex: 1,
              child: pw.Text(
                'Dated $dateStr',
                style: base,
                textAlign: pw.TextAlign.right,
              ),
            ),
          ],
        ),
        pw.Text('S.J.Entery No. _______________________________', style: base),
        pw.SizedBox(height: 4),
        pw.Text(
          'Name of Payee:-  ${pa.payeeName}  ${pa.payeeAddress}',
          style: base,
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Particulars of payment :- ${pa.paymentParticulars}',
          style: base,
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          'Authority Order No. ${pa.authorityOrderNo}  dt. $authorityDateStr',
          style: base,
        ),
        pw.Text(
          'No. of Bills/Invoice . NO. ${pa.billNo}  dt. $billDateStr',
          style: base,
        ),
        pw.Text(
          'Amount (Net)  Rs. ${pa.netAmount.toStringAsFixed(2)}  Only',
          style: base.copyWith(fontWeight: pw.FontWeight.bold),
        ),
      ],
    );
  }

  pw.Widget _buildDebitCreditHeader(pw.TextStyle bold) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.7)),
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        children: [
          pw.Expanded(
            flex: 1,
            child: pw.Center(child: pw.Text('DEBIT', style: bold)),
          ),
          pw.Container(width: 0.7, height: 18, color: PdfColors.black),
          pw.Expanded(
            flex: 1,
            child: pw.Center(child: pw.Text('CLASIFICATION', style: bold)),
          ),
          pw.Container(width: 0.7, height: 18, color: PdfColors.black),
          pw.Expanded(
            flex: 1,
            child: pw.Center(child: pw.Text('CREDIT', style: bold)),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildDebitCreditBody(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
    pw.TextStyle bold,
    String Function(double) fmt,
  ) {
    final maxRows = pa.debitLines.length > pa.creditLines.length
        ? pa.debitLines.length
        : pa.creditLines.length;

    pw.Widget buildSubHeaderRow() {
      return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: pw.Row(
          children: [
            pw.Expanded(flex: 3, child: pw.Text('Description', style: bold)),
            pw.Expanded(flex: 2, child: pw.Text('Numerical Head', style: bold)),
            pw.Expanded(flex: 2, child: pw.Text('AMOUNT', style: bold)),
          ],
        ),
      );
    }

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          left: const pw.BorderSide(width: 0.7),
          right: const pw.BorderSide(width: 0.7),
          bottom: const pw.BorderSide(width: 0.7),
        ),
      ),
      child: pw.Column(
        children: [
          pw.Row(
            children: [
              pw.Expanded(flex: 1, child: buildSubHeaderRow()),
              pw.Container(width: 0.7, height: 20, color: PdfColors.black),
              pw.Expanded(flex: 1, child: buildSubHeaderRow()),
            ],
          ),
          pw.Divider(height: 0.7),
          for (int i = 0; i < maxRows; i++)
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: i < pa.debitLines.length
                        ? _buildLineRow(pa.debitLines[i], base, fmt)
                        : pw.SizedBox(height: 14),
                  ),
                ),
                pw.Container(width: 0.7, height: 16, color: PdfColors.black),
                pw.Expanded(
                  flex: 1,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: i < pa.creditLines.length
                        ? _buildLineRow(pa.creditLines[i], base, fmt)
                        : pw.SizedBox(height: 14),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  pw.Widget _buildLineRow(
    pa_model.AuthorityLine line,
    pw.TextStyle base,
    String Function(double) fmt,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(flex: 3, child: pw.Text(line.description, style: base)),
        pw.Expanded(flex: 2, child: pw.Text(line.glCode, style: base)),
        pw.Expanded(
          flex: 2,
          child: pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text(fmt(line.amount), style: base),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildGrossTotalRow(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
    pw.TextStyle bold,
    String Function(double) fmt,
  ) {
    final debitTotal = pa.debitLines.fold<double>(
      0,
      (sum, l) => sum + l.amount,
    );
    final creditTotal = pa.creditLines.fold<double>(
      0,
      (sum, l) => sum + l.amount,
    );

    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.7)),
      padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Row(
              children: [
                pw.Text('Gross Total', style: bold),
                pw.Spacer(),
                pw.Text('Rs.', style: base),
                pw.SizedBox(width: 4),
                pw.Text(fmt(debitTotal), style: base),
              ],
            ),
          ),
          pw.VerticalDivider(width: 0.7),
          pw.Expanded(
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.end,
              children: [pw.Text(fmt(creditTotal), style: base)],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildSignaturesSection(pw.TextStyle base) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.SizedBox(height: 32),
              pw.Text('Prepared', style: base),
              pw.SizedBox(height: 24),
              pw.Text('Sig .of Dealing Asstt.', style: base),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.SizedBox(height: 32),
              pw.Text('Checked', style: base),
              pw.SizedBox(height: 24),
              pw.Text('Sig. of D.A.', style: base),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.SizedBox(height: 32),
              pw.Text('Passed for payment', style: base),
              pw.SizedBox(height: 24),
              pw.Text('Sig. of E.E.', style: base),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _buildAmountAndDebitToSection(
    pa_model.PaymentAuthorityPdfModel pa,
    pw.TextStyle base,
  ) {
    final amountWords = 'Rs. ${_amountInWords(pa.netAmount)} Only';

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Please pay ${pa.netAmount.toStringAsFixed(2)}  $amountWords.',
          style: base,
        ),
        pw.SizedBox(height: 8),
        pw.Row(
          children: [
            pw.Text('to _______________________________', style: base),
            pw.SizedBox(width: 12),
            pw.Text(
              'and Debit to _______________________________',
              style: base,
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildCashierSection(pw.TextStyle base) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Paid in cash /by Cheque vide cash Book Vr. No. ______________ Dated ____________',
          style: base,
        ),
        pw.Text(
          'Cheque No. ______________  Dated ____________  Sig. of Cashier',
          style: base,
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          '* Here indicate liability Account Code 4501/4502/4503 as the case may be.',
          style: base.copyWith(fontSize: 8),
        ),
        pw.SizedBox(height: 10),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('D.A.(W)', style: base),
            pw.Text('Sig. of E.E.', style: base),
          ],
        ),
      ],
    );
  }

  /// Very simple amount-to-words stub; replace with a robust implementation.
  String _amountInWords(double amount) {
    return amount.toStringAsFixed(2);
  }

  Future<File> _savePdfToFile(Uint8List bytes) async {
    final dir = await getApplicationDocumentsDirectory();
    final fileName =
        'payment_authority_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File('${dir.path}/$fileName');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
