// lib/features/ti_document/services/ti_pdf_service.dart

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/ti_document.dart';

class TiPdfService {
  /// Generate single PDF and auto-open it.
  /// Set [includeImprestPage] to true if you want the 3rd page.
  Future<File> generateAndOpen(
    TIDocumentModel model, {
    bool includeImprestPage = false,
  }) async {
    final pdfBytes = await _buildPdf(
      model,
      includeImprestPage: includeImprestPage,
    );
    final file = await _savePdfToFile(pdfBytes, model);

    await OpenFilex.open(file.path);
    debugPrint('✅ TI PDF generated and opened: ${file.path}');
    return file;
  }

  /// Build single PDF document (Page-1 + Page-2 + optional Page-3).
  Future<Uint8List> _buildPdf(
    TIDocumentModel model, {
    required bool includeImprestPage,
  }) async {
    final doc = pw.Document();

    // Load fonts
    final ttf = await PdfGoogleFonts.robotoRegular();
    final ttfBold = await PdfGoogleFonts.robotoBold();

    // PAGE 1: Office Memorandum (OM Form)
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => _buildPage1OM(model, ttf, ttfBold),
      ),
    );

    // PAGE 2: Copy Forwarded / ETD Form
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) => _buildPage2UPPCLForm(model, ttf, ttfBold),
      ),
    );

    // PAGE 3: Imprest Cash Account Book (optional)
    if (includeImprestPage) {
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (context) =>
              _buildPage3ImprestCashAccountBook(model, ttf, ttfBold),
        ),
      );
    }

    return doc.save();
  }

  // ============================================================================
  // PAGE 1: OFFICE MEMORANDUM (OM)
  // ============================================================================
  pw.Widget _buildPage1OM(TIDocumentModel model, pw.Font ttf, pw.Font ttfBold) {
    final df = DateFormat('dd/MM/yyyy');

    const double bodyFontSize = 12.0;
    const double headerFontSize = 16.0;

    final omNumber = (model.omNumber ?? '').trim();
    final omDate = model.omDate ?? DateTime.now();

    final amount = model.amount ?? 0.0;

    final employeeName = (model.employeeName ?? '').trim();
    final employeeDesignation = (model.employeeDesignation ?? '').trim();
    final divisionName = (model.divisionName ?? '').trim();

    final purpose = (model.purpose ?? '').trim();
    final recommendingOffice = (model.recommendingOffice ?? '').trim();

    final letterNumber = (model.letterNumber ?? '').trim();
    final letterDate = model.letterDate ?? DateTime.now();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // 1) TITLE
        pw.Center(
          child: pw.Text(
            'OFFICE MEMORANDUM',
            style: pw.TextStyle(
              font: ttfBold,
              fontSize: headerFontSize,
              decoration: pw.TextDecoration.underline,
            ),
          ),
        ),

        pw.SizedBox(height: 40),

        // 2) TOP NO / DATE ROW
        pw.Row(
          children: [
            pw.Text(
              'No. ',
              style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
            ),
            pw.Text(
              omNumber,
              style: pw.TextStyle(font: ttfBold, fontSize: bodyFontSize),
            ),
            pw.Spacer(),
            pw.Text(
              'Date ',
              style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
            ),
            pw.Text(
              df.format(omDate),
              style: pw.TextStyle(font: ttfBold, fontSize: bodyFontSize),
            ),
          ],
        ),

        pw.SizedBox(height: 30),

        // 3) SANCTION TEXT
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(
              font: ttf,
              fontSize: bodyFontSize,
              lineSpacing: 1.5,
            ),
            children: [
              const pw.TextSpan(
                text:
                    'Sanction is hereby accorded for opening of temporary imprest / temporary advance account for Rs. ',
              ),
              pw.TextSpan(
                text: '${amount.toStringAsFixed(0)}/-',
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' in the name of '),
              pw.TextSpan(
                text: employeeName,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ', Designation '),
              pw.TextSpan(
                text: employeeDesignation,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ', office '),
              pw.TextSpan(
                text: divisionName,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' for the purpose of '),
              pw.TextSpan(
                text: purpose,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' on the recommendation of '),
              pw.TextSpan(
                text: recommendingOffice,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' vide his letter No. '),
              pw.TextSpan(
                text: letterNumber,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' Dated '),
              pw.TextSpan(
                text: df.format(letterDate),
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: '.'),
            ],
          ),
        ),

        pw.SizedBox(height: 25),

        // 4) CONDITIONS
        pw.Text(
          'The above sanction is subject to the following conditions:',
          style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
        ),
        pw.SizedBox(height: 15),

        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Paragraph(
                text:
                    '1. The amount will be utilized for the purpose for which it has been advanced.',
                style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
              ),
              pw.SizedBox(height: 10),
              pw.Paragraph(
                text:
                    '2. The account of the above should be submitted to this office within one month of its opening, '
                    'the amount will be received from the monthly pay in lump-sum. As soon as the purpose for which '
                    'the advance account has been opened is completed the account of adjustment should be submitted '
                    'without waiting for expiry of one month.',
                style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
              ),
              pw.SizedBox(height: 10),
              pw.Paragraph(
                text:
                    '3. In case the amount is not needed, it should be returned to chest, immediately.',
                style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
              ),
            ],
          ),
        ),

        pw.SizedBox(height: 40),

        // 5) FIRST SIGNATURE (Sanctioning Authority)
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 30), // Space for signature
              pw.Text(
                'Sanctioning Authority',
                style: pw.TextStyle(font: ttfBold, fontSize: bodyFontSize),
              ),
            ],
          ),
        ),

        pw.Spacer(),

        // 6) COPY FORWARDED SECTION
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'No. $omNumber',
              style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
            ),
            pw.Text(
              'Date: ${df.format(omDate)}',
              style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
            ),
          ],
        ),
        pw.SizedBox(height: 15),

        pw.Text(
          'Copy forwarded to the following for information and necessary action:',
          style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
        ),
        pw.SizedBox(height: 15),

        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '1. $employeeName',
                style: pw.TextStyle(font: ttfBold, fontSize: bodyFontSize),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                '2. Dealing Assistant/Cashier',
                style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
              ),
            ],
          ),
        ),

        pw.SizedBox(height: 30),

        // 7) BOTTOM SIGNATURE
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: 150,
                decoration: const pw.BoxDecoration(
                  border: pw.Border(bottom: pw.BorderSide(width: 1)),
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'Sanctioning Authority',
                style: pw.TextStyle(font: ttfBold, fontSize: bodyFontSize),
              ),
            ],
          ),
        ),

        pw.SizedBox(height: 20),
      ],
    );
  }

  // ============================================================================
  // PAGE 2: COPY FORWARDED / ETD FORM
  // ============================================================================
  pw.Widget _buildPage2UPPCLForm(
    TIDocumentModel model,
    pw.Font regular,
    pw.Font bold,
  ) {
    final df = DateFormat('dd/MM/yyyy');
    pw.TextStyle r(double s) => pw.TextStyle(font: regular, fontSize: s);
    pw.TextStyle b(double s) => pw.TextStyle(font: bold, fontSize: s);

    final omDate = model.omDate ?? DateTime.now();
    final letterDate = model.letterDate ?? DateTime.now();

    final recommendingOffice = (model.recommendingOffice ?? '').trim();
    final divisionName = (model.divisionName ?? '').trim();

    final employeeName = (model.employeeName ?? '').trim();
    final purpose = (model.purpose ?? '').trim();

    final amount = (model.amount ?? 0.0).toStringAsFixed(0);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // HEADER
        pw.Center(child: pw.Text('U.P. POWER CORPORATION LTD.', style: b(12))),
        pw.SizedBox(height: 4),
        pw.Center(
          child: pw.Text(
            'REQUISITION OF TEMPORARY IMPREST / TEMPORARY ADVANCE',
            style: b(10),
          ),
        ),
        pw.SizedBox(height: 16),

        // Row 2: Name of Office (full width)
        pw.Text('Name of the Office : $recommendingOffice', style: r(10)),

        pw.SizedBox(height: 10),
        pw.Row(
          children: [
            pw.Text('No. ', style: r(10)),
            pw.Spacer(),
            pw.Text('Date : ${df.format(omDate)}', style: r(10)),
          ],
        ),
        pw.SizedBox(height: 10),

        pw.Text('Sir,', style: r(10)),
        pw.SizedBox(height: 6),
        pw.Text(
          'Please open a temporary imprest / temporary advance for Rs. $amount '
          'in my name against passed vouchers for payment on account of $purpose.',
          style: r(10),
          textAlign: pw.TextAlign.justify,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          'I certify that no temporary imprest / temporary advance is outstanding '
          'in my name as on date.',
          style: r(10),
        ),
        pw.SizedBox(height: 6),
        pw.Text(
          'I undertake that the account of above temporary imprest / temporary '
          'advance will be submitted within one month of the receipt of amount '
          'failing which the amount will be recovered from my monthly pay in lump sum.',
          style: r(10),
          textAlign: pw.TextAlign.justify,
        ),
        pw.SizedBox(height: 30),

        // SIGNATURE (APPLICANT)
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Container(
                width: 160,
                decoration: const pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(width: 1)),
                ),
                padding: const pw.EdgeInsets.only(top: 4),
                child: pw.Text(
                  'Signature and Designation of the Indentor',
                  style: r(9),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
        ),

        pw.SizedBox(height: 20),

        // FOR USE IN RECOMMENDING / AUTHORISING OFFICER
        pw.Center(
          child: pw.Text(
            'For use in Recommending / Authorising Officer',
            style: b(10),
          ),
        ),
        pw.SizedBox(height: 12),

        pw.Text('Name of the Office: $recommendingOffice', style: r(10)),
        pw.SizedBox(height: 6),

        pw.Row(
          children: [
            pw.Expanded(child: pw.Text('No.: ', style: r(10))),
            pw.Text('Date ${df.format(letterDate)}', style: r(10)),
          ],
        ),
        pw.SizedBox(height: 6),

        pw.Text(
          'G.M. / Dy. G.M. / E.E. / S.D.O. /\n'
          'C.A.O. / Dy. C.A.O. / S.A.O. / A.O.',
          style: r(10),
        ),
        pw.SizedBox(height: 10),

        pw.Text('Sir,', style: r(10)),
        pw.SizedBox(height: 6),

        pw.Text(
          'I forward the above requisition for opening of temporary imprest / '
          'temporary advance of Rs. $amount in the name of Shri $employeeName '
          'for (purpose) $purpose.',
          style: r(10),
          textAlign: pw.TextAlign.justify,
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'The account of this amount will be submitted for closing and adjustment '
          'at the earliest but within one month positively.',
          style: r(10),
          textAlign: pw.TextAlign.justify,
        ),
        pw.SizedBox(height: 28),

        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Container(
            width: 240,
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(width: 1)),
            ),
            padding: const pw.EdgeInsets.only(top: 4),
            child: pw.Text(
              'Signature and Seal of Recommending Authority',
              style: r(9),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ),

        // FOR USE IN DRAWING AND DISBURSING OFFICER
        pw.SizedBox(height: 18),
        pw.Center(
          child: pw.Text(
            'For use in Drawing and Disbursing Officer',
            style: b(10),
          ),
        ),
        pw.SizedBox(height: 12),

        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text('Name of the Office: $divisionName', style: r(10)),
            ),
            pw.Text('Date: ', style: r(10)),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Text('No. ', style: r(10)),
        pw.SizedBox(height: 6),

        pw.Text(
          'G.M. / Dy. G.M. / E.E. / S.D.O. /\n'
          'C.A.O. / Dy. C.A.O. / S.A.O. / A.O.',
          style: r(10),
        ),
        pw.SizedBox(height: 14),

        pw.Text(
          'The certificate given above by Shri ......................................................... '
          'has been checked and found correct / following temporary imprest / temporary '
          'advance are outstanding in his name.',
          style: r(10),
          textAlign: pw.TextAlign.justify,
        ),
        pw.SizedBox(height: 12),

        pw.Table(
          border: pw.TableBorder.all(width: 1),
          columnWidths: const {
            0: pw.FlexColumnWidth(1),
            1: pw.FlexColumnWidth(3),
            2: pw.FlexColumnWidth(3),
          },
          children: [
            pw.TableRow(
              children: [
                _cell('Sl.', bold),
                _cell('Date', bold),
                _cell('Amount', bold),
              ],
            ),
            pw.TableRow(
              children: [
                _cell('(1)', regular),
                _cell('', regular),
                _cell('', regular),
              ],
            ),
            pw.TableRow(
              children: [
                _cell('(2)', regular),
                _cell('', regular),
                _cell('', regular),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 28),

        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Container(
            width: 230,
            decoration: const pw.BoxDecoration(
              border: pw.Border(top: pw.BorderSide(width: 1)),
            ),
            padding: const pw.EdgeInsets.only(top: 4),
            child: pw.Text(
              'Signature of Divisional Accountant /\nAsstt. Accounts Officer',
              style: r(9),
              textAlign: pw.TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // PAGE 3: IMPREST CASH ACCOUNT BOOK (optional)
  // ============================================================================
  pw.Widget _buildPage3ImprestCashAccountBook(
    TIDocumentModel model,
    pw.Font regular,
    pw.Font bold,
  ) {
    pw.TextStyle r(double s) => pw.TextStyle(font: regular, fontSize: s);
    pw.TextStyle b(double s) => pw.TextStyle(font: bold, fontSize: s);

    String money(double v) => v.toStringAsFixed(0);

    final employeeName = (model.employeeName ?? '').trim();
    final employeeDesignation = (model.employeeDesignation ?? '').trim();
    final divisionName = (model.divisionName ?? '').trim();

    // Use derived data directly if your model doesn't store computed counts:
    final vouchersCount = model.imprestEntries.length;
    final amount = model.imprestEntries.fold(0.0, (sum, e) => sum + e.payment);

    pw.Widget cell(
      String text, {
      pw.TextStyle? style,
      pw.TextAlign align = pw.TextAlign.center,
      double minHeight = 22,
      pw.EdgeInsets pad = const pw.EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 3,
      ),
    }) {
      return pw.Container(
        constraints: pw.BoxConstraints(minHeight: minHeight),
        padding: pad,
        alignment: align == pw.TextAlign.left
            ? pw.Alignment.centerLeft
            : (align == pw.TextAlign.right
                  ? pw.Alignment.centerRight
                  : pw.Alignment.center),
        child: pw.Text(text, style: style ?? r(9), textAlign: align),
      );
    }

    // Body rows from model.imprestEntries
    final entryRows = model.imprestEntries.map((e) {
      return pw.TableRow(
        children: [
          cell(e.date), // Date
          cell(e.vrNo), // Vr. No
          cell(e.transaction, align: pw.TextAlign.left), // Transaction
          cell(money(e.payment), align: pw.TextAlign.right), // Amount payable
          cell(money(e.total), align: pw.TextAlign.right), // Total (running)
          cell(e.head, align: pw.TextAlign.left), // Head/GL Code
        ],
      );
    }).toList();

    // Totals
    final totalPayable = model.imprestEntries.fold<double>(
      0.0,
      (s, e) => s + e.payment,
    );

    final finalTotal = model.imprestEntries.isEmpty
        ? 0.0
        : model.imprestEntries.last.total;

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Center(child: pw.Text('IMPREST CASH ACCOUNT BOOK', style: b(16))),
        pw.SizedBox(height: 3),
        pw.Text(
          'Cash Book of $employeeName, $employeeDesignation, '
          'Office: $divisionName',
          style: r(10),
        ),
        pw.SizedBox(height: 8),

        pw.Table(
          border: pw.TableBorder.all(width: 1),
          columnWidths: const {
            0: pw.FlexColumnWidth(1.2), // Date
            1: pw.FlexColumnWidth(1.0), // Vr. No
            2: pw.FlexColumnWidth(4.2), // Transaction
            3: pw.FlexColumnWidth(1.4), // Amount payable
            4: pw.FlexColumnWidth(1.3), // Total
            5: pw.FlexColumnWidth(1.6), // Head/GL Code
          },
          children: [
            // Header row
            pw.TableRow(
              children: [
                cell('Date', style: b(9)),
                cell('Vr.\nNo', style: b(9)),
                cell('Transaction', style: b(9), align: pw.TextAlign.left),
                cell('Amount\npayable', style: b(9)),
                cell('Total', style: b(9)),
                cell('Head/GL Code', style: b(9), align: pw.TextAlign.left),
              ],
            ),

            // Entry rows (N rows)
            ...entryRows,

            // Total row
            pw.TableRow(
              children: [
                cell(''),
                cell(''),
                cell('Total', style: b(10)),
                cell(
                  money(totalPayable),
                  style: b(10),
                  align: pw.TextAlign.right,
                ),
                cell(
                  money(finalTotal),
                  style: b(10),
                  align: pw.TextAlign.right,
                ),
                cell(''),
              ],
            ),
          ],
        ),

        pw.SizedBox(height: 10),

        // Submission text
        pw.Text(
          'Submitted for adjustment: $vouchersCount passed vouchers, '
          'Amount Rs. ${money(amount)}/-',
          style: r(9),
        ),

        pw.SizedBox(height: 16),

        // Handwritten-style paragraph
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(width: 0.5, color: PdfColors.grey400),
            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(4)),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'It is submitted to $divisionName via ${model.recommendingOffice} for adjustment & enclosed.',
                style: pw.TextStyle(
                  font: regular,
                  fontSize: 10,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),

              pw.SizedBox(height: 20),
              // Signature area
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Seen:', style: r(9)),
                      pw.SizedBox(height: 20),
                      pw.Container(
                        width: 120,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.SizedBox(height: 20),
                      pw.Container(
                        width: 120,
                        decoration: const pw.BoxDecoration(
                          border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
                        ),
                      ),
                      pw.SizedBox(height: 4),
                      pw.Text('Recommeding authority', style: r(9)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Small helper for table cells (Page 2)
  // ---------------------------------------------------------------------------
  pw.Widget _cell(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Text(
        text,
        style: pw.TextStyle(font: font, fontSize: 9),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  // ============================================================================
  // Save PDF with proper filename: Division_Employee_OMNumber.pdf
  // ============================================================================
  Future<File> _savePdfToFile(Uint8List bytes, TIDocumentModel model) async {
    final output = await getApplicationDocumentsDirectory();

    final sanitizedDivision = _sanitizeFilename(
      (model.divisionName ?? '').trim(),
    );
    final sanitizedEmployee = _sanitizeFilename(
      (model.employeeName ?? '').trim(),
    );
    final sanitizedOM = _sanitizeFilename((model.omNumber ?? '').trim());

    final filename =
        '${sanitizedDivision}_${sanitizedEmployee}_${sanitizedOM}.pdf';

    final pdfDir = Directory('${output.path}/TI_Documents');
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }

    final file = File('${pdfDir.path}/$filename');
    await file.writeAsBytes(bytes);
    debugPrint('✅ TI PDF saved: ${file.path}');
    return file;
  }

  String _sanitizeFilename(String input) {
    return input
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special chars
        .replaceAll(RegExp(r'\s+'), '_') // Replace spaces with underscore
        .replaceAll(RegExp(r'_+'), '_') // Replace multiple underscores
        .trim();
  }

  /// Get PDF Storage Directory
  Future<String> getPDFStorageDirectory() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/TI_Documents';
  }
}
