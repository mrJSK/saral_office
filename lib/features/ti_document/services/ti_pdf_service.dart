// lib/features/ti_document/services/ti_pdf_service.dart

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import '../models/ti_pdf_model.dart';

class TiPdfService {
  /// Generate single PDF with 2 pages and auto-open it
  Future generateAndOpen(TiPdfModel model) async {
    final pdfBytes = await _buildPdf(model);
    final file = await _savePdfToFile(pdfBytes, model);

    // Auto-open the PDF
    await OpenFilex.open(file.path);
    debugPrint('✅ TI PDF generated and opened: ${file.path}');
    return file;
  }

  /// Build single PDF document with 2 pages
  Future<Uint8List> _buildPdf(TiPdfModel model) async {
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

    return doc.save();
  }

  // ============================================================================
  // PAGE 1: OFFICE MEMORANDUM (OM)
  // ============================================================================
  pw.Widget _buildPage1OM(TiPdfModel model, pw.Font ttf, pw.Font ttfBold) {
    final df = DateFormat('dd/MM/yyyy');

    // Configurable styles for easy adjustments
    const double bodyFontSize = 12.0;
    const double headerFontSize = 16.0;
    const double lineSpacing = 10.0; // Increased spacing between lines of text

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        /// ====================================================================
        /// 1. TITLE
        /// ====================================================================
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

        pw.SizedBox(height: 40), // Increased gap
        /// ====================================================================
        /// 2. TOP NO / DATE ROW
        /// ====================================================================
        pw.Row(
          children: [
            pw.Text(
              'No. ',
              style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
            ),
            pw.Text(
              model.omNumber,
              style: pw.TextStyle(font: ttfBold, fontSize: bodyFontSize),
            ),
            pw.Spacer(),
            pw.Text(
              'Date ',
              style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
            ),
            pw.Text(
              df.format(model.omDate),
              style: pw.TextStyle(font: ttfBold, fontSize: bodyFontSize),
            ),
          ],
        ),

        pw.SizedBox(height: 30), // Increased gap
        /// ====================================================================
        /// 3. SANCTION TEXT (Main Body)
        /// ====================================================================
        pw.RichText(
          textAlign: pw.TextAlign.justify,
          text: pw.TextSpan(
            style: pw.TextStyle(
              font: ttf,
              fontSize: bodyFontSize,
              lineSpacing: 8, // Adjust line height here
            ),
            children: [
              const pw.TextSpan(
                text:
                    'Sanction is hereby accorded for opening of temporary imperest / temporary advance account for Rs. ',
              ),
              pw.TextSpan(
                text: '${model.amount.toStringAsFixed(0)}/-',
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' in the name of '),
              pw.TextSpan(
                text: model.employeeName,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ', Designation '),
              pw.TextSpan(
                text: model.employeeDesignation,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ', office '),
              pw.TextSpan(
                text: model.divisionName,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' for the purpose of '),
              pw.TextSpan(
                text: model.purpose,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' on the recommendation of '),
              pw.TextSpan(
                text: model.recommendingOffice,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' vide his letter No. '),
              pw.TextSpan(
                text: model.letterNumber,
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: ' Dated '),
              pw.TextSpan(
                text: df.format(model.letterDate),
                style: pw.TextStyle(font: ttfBold),
              ),
              const pw.TextSpan(text: '.'),
            ],
          ),
        ),

        pw.SizedBox(height: 25),

        /// ====================================================================
        /// 4. CONDITIONS
        /// ====================================================================
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
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: bodyFontSize,
                  lineSpacing: 1.5,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Paragraph(
                text:
                    '2. The account of the above should be submitted to this office within one month of its opening, '
                    'the amount will be received from the monthly pay in lump-sum. As soon as the purpose for which '
                    'the advance account has been opened is completed the account of adjustment should be submitted '
                    'without waiting for expiry of one month.',
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: bodyFontSize,
                  lineSpacing: 1.5,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Paragraph(
                text:
                    '3. In case the amount is not needed, it should be returned to chest, immediately.',
                style: pw.TextStyle(
                  font: ttf,
                  fontSize: bodyFontSize,
                  lineSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),

        pw.SizedBox(height: 40),

        /// ====================================================================
        /// 5. FIRST SIGNATURE (Sanctioning Authority)
        /// ====================================================================
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

        pw.Spacer(), // Pushes the following section to the bottom
        /// ====================================================================
        /// 6. COPY FORWARDED SECTION (The Missing Part)
        /// ====================================================================
        // Replicating the No/Date line for the endorsement
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'No. ${model.omNumber}',
              style: pw.TextStyle(font: ttf, fontSize: bodyFontSize),
            ),
            pw.Text(
              'Date: ${df.format(model.omDate)}',
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

        // List of recipients
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '1. ${model.employeeName}', // The person concerned
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

        /// ====================================================================
        /// 7. BOTTOM SIGNATURE (Sanctioning Authority)
        /// ====================================================================
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              // Visual line for signature
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

        pw.SizedBox(height: 20), // Bottom margin buffer
      ],
    );
  }

  // ============================================================================
  // PAGE 2: COPY FORWARDED / ETD FORM
  // ============================================================================

  pw.Widget _buildPage2UPPCLForm(
    TiPdfModel model,
    pw.Font regular,
    pw.Font bold,
  ) {
    final df = DateFormat('dd/MM/yyyy');

    pw.TextStyle r(double s) => pw.TextStyle(font: regular, fontSize: s);
    pw.TextStyle b(double s) => pw.TextStyle(font: bold, fontSize: s);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // -----------------------------------------------------------------------
        // HEADER
        // -----------------------------------------------------------------------
        pw.Center(child: pw.Text('U.P. POWER CORPORATION LTD.', style: b(12))),
        pw.SizedBox(height: 4),
        pw.Center(
          child: pw.Text(
            'REQUISITION OF TEMPORARY IMPREST / TEMPORARY ADVANCE',
            style: b(10),
          ),
        ),
        pw.SizedBox(height: 16),

        // -----------------------------------------------------------------------
        // NAME OF OFFICE + DATE
        // -----------------------------------------------------------------------
        pw.Row(
          children: [
            pw.Expanded(
              child: pw.Text(
                'Name of the Office : ${model.divisionName}',
                style: r(10),
              ),
            ),
            pw.Text('Date : ${df.format(model.omDate)}', style: r(10)),
          ],
        ),
        pw.SizedBox(height: 10),

        pw.Text('Sir,', style: r(10)),
        pw.SizedBox(height: 6),

        pw.Text(
          'Please open a temporary imprest / temporary advance for Rs. '
          '${model.amount.toStringAsFixed(0)} '
          'in my name against passed vouchers for payment on account of '
          '${model.purpose}.',
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

        // -----------------------------------------------------------------------
        // SIGNATURE (APPLICANT)
        // -----------------------------------------------------------------------
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

        // -----------------------------------------------------------------------
        // FOR USE IN RECOMMENDING / AUTHORISING OFFICER (CORRECTED AS PER SCAN)
        // -----------------------------------------------------------------------
        pw.SizedBox(height: 20),

        pw.Center(
          child: pw.Text(
            'For use in Recommending / Authorising Officer',
            style: b(10),
          ),
        ),

        pw.SizedBox(height: 12),

        // Name of Office (TWO LINES)
        pw.Text('Name of the Office: ', style: r(10)),

        pw.SizedBox(height: 6),

        // No. + Date
        pw.Row(
          children: [
            pw.Expanded(child: pw.Text('No.: ', style: r(10))),
            pw.Text('Date ${df.format(model.letterDate)}', style: r(10)),
          ],
        ),

        pw.SizedBox(height: 6),

        // Designation list (EXACT)
        pw.Text(
          'G.M. / Dy. G.M. / E.E. / S.D.O. /\n'
          'C.A.O. / Dy. C.A.O. / S.A.O. / A.O.',
          style: r(10),
        ),

        pw.SizedBox(height: 10),

        pw.Text('Sir,', style: r(10)),
        pw.SizedBox(height: 6),

        // Main forwarding paragraph (EXACT STRUCTURE)
        pw.Text(
          'I forward the above requisition for opening of temporary imprest / '
          'temporary advance of Rs. ${model.amount.toStringAsFixed(0)} '
          'in the name of Shri ${model.employeeName} '
          'for (purpose) ${model.purpose}.',
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

        // Signature & Seal
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

        // ---------------------------------------------------------------------------
        // FOR USE IN DRAWING AND DISBURSING OFFICER (CORRECTED AS PER SCAN)
        // ---------------------------------------------------------------------------
        pw.SizedBox(height: 18),

        pw.Center(
          child: pw.Text(
            'For use in Drawing and Disbursing Officer',
            style: b(10),
          ),
        ),

        pw.SizedBox(height: 12),

        // Name of Office + Date
        pw.Row(
          children: [
            pw.Expanded(child: pw.Text('Name of the Office: ', style: r(10))),
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

        // Certification sentence (EXACT TEXT)
        pw.Text(
          'The certificate given above by Shri ......................................................... '
          'has been checked and found correct / following temporary imprest / temporary '
          'advance are outstanding in his name.',
          style: r(10),
          textAlign: pw.TextAlign.justify,
        ),

        pw.SizedBox(height: 12),

        // TABLE (ONLY Sl., Date, Amount)
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

        // Signature
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

  // ---------------------------------------------------------------------------
  // SMALL HELPER FOR TABLE CELLS
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
  // HELPER METHODS
  // ============================================================================

  /// Build signature box
  pw.Widget _buildSignatureBox(String label, pw.Font ttf) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        pw.SizedBox(height: 40),
        pw.Container(
          width: 100,
          decoration: const pw.BoxDecoration(
            border: pw.Border(top: pw.BorderSide(width: 1)),
          ),
          padding: const pw.EdgeInsets.only(top: 5),
          child: pw.Text(
            label,
            style: pw.TextStyle(font: ttf, fontSize: 8),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Save PDF with proper filename: Division_Employee_OMNumber.pdf
  Future<File> _savePdfToFile(Uint8List bytes, TiPdfModel model) async {
    final output = await getApplicationDocumentsDirectory();

    // Sanitize parts
    final sanitizedDivision = _sanitizeFilename(model.divisionName);
    final sanitizedEmployee = _sanitizeFilename(model.employeeName);
    final sanitizedOM = _sanitizeFilename(model.omNumber);

    // Format: Division_Employee_OMNumber.pdf
    final filename =
        '${sanitizedDivision}_${sanitizedEmployee}_${sanitizedOM}.pdf';

    // Create TI_Documents directory if it doesn't exist
    final pdfDir = Directory('${output.path}/TI_Documents');
    if (!await pdfDir.exists()) {
      await pdfDir.create(recursive: true);
    }

    final file = File('${pdfDir.path}/$filename');
    await file.writeAsBytes(bytes);
    debugPrint('✅ TI PDF saved: ${file.path}');
    return file;
  }

  /// Sanitize filename
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
