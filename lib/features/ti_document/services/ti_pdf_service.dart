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
  Future<File> generateAndOpen(TiPdfModel model) async {
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
        build: (context) => _buildPage2CopyForwarded(model, ttf, ttfBold),
      ),
    );

    return doc.save();
  }

  // ============================================================================
  // PAGE 1: OFFICE MEMORANDUM (OM)
  // ============================================================================

  pw.Widget _buildPage1OM(TiPdfModel model, pw.Font ttf, pw.Font ttfBold) {
    final dateFormatter = DateFormat('dd/MM/yyyy');

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Title
        pw.Center(
          child: pw.Text(
            'OFFICE MEMORANDUM',
            style: pw.TextStyle(
              font: ttfBold,
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
              decoration: pw.TextDecoration.underline,
            ),
          ),
        ),
        pw.SizedBox(height: 30),

        // Header with No. and Date
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'No....${model.omNumber}........',
              style: pw.TextStyle(font: ttf, fontSize: 11),
            ),
            pw.Text(
              'Date.......${dateFormatter.format(model.omDate)}',
              style: pw.TextStyle(font: ttf, fontSize: 11),
            ),
          ],
        ),
        pw.SizedBox(height: 30),

        // Main Content Paragraph
        pw.Paragraph(
          text:
              '       Section is hereby accorded for opening of temporary '
              'imperial/ temporary advance account for Rs.${model.amount.toStringAsFixed(2)}/- in the name of '
              '${model.employeeName} Designation..${model.employeeDesignation}... '
              'office..${model.divisionName}.. (purpose) Division of district...on the '
              'recommendation of....${model.recommendingOffice}....vide his letter '
              'No......${model.letterNumber}.......Dated......${dateFormatter.format(model.letterDate)}......',
          style: pw.TextStyle(font: ttf, fontSize: 11, lineSpacing: 1.5),
          textAlign: pw.TextAlign.justify,
        ),
        pw.SizedBox(height: 20),

        // Conditions Section
        pw.Text(
          'The above sanction is subject to the following conditions:',
          style: pw.TextStyle(font: ttf, fontSize: 11),
        ),
        pw.SizedBox(height: 10),

        // Condition 1
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '1. The amount will be utilized for the purpose for which it has been advanced.',
                style: pw.TextStyle(font: ttf, fontSize: 10, lineSpacing: 1.3),
              ),
              pw.SizedBox(height: 8),

              // Condition 2
              pw.Text(
                '2. The account of the above should be submitted to this office within one month of its\n'
                '   opening within which, the amount will be received from the monthly pay in lump-sum.\n'
                '   As soon as the purpose for which the advance account has been opened is completed the\n'
                '   account of adjustment should be submitted without waiting for the period of expiry of\n'
                '   one month.',
                style: pw.TextStyle(font: ttf, fontSize: 10, lineSpacing: 1.3),
              ),
              pw.SizedBox(height: 8),

              // Condition 3
              pw.Text(
                '3. In case the amount is not needed, it should be returned to chest, immediately.',
                style: pw.TextStyle(font: ttf, fontSize: 10, lineSpacing: 1.3),
              ),
            ],
          ),
        ),
        pw.Spacer(),

        // Signature Section
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 50),
              pw.Container(
                width: 120,
                decoration: const pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(width: 1)),
                ),
                padding: const pw.EdgeInsets.only(top: 5),
                child: pw.Text(
                  'Sanctioning Authority',
                  style: pw.TextStyle(font: ttf, fontSize: 9),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================================
  // PAGE 2: COPY FORWARDED / ETD FORM
  // ============================================================================

  pw.Widget _buildPage2CopyForwarded(
    TiPdfModel model,
    pw.Font ttf,
    pw.Font ttfBold,
  ) {
    final dateFormatter = DateFormat('dd/MM/yyyy');

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Header with No. and Date
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              'No....${model.omNumber}..........',
              style: pw.TextStyle(font: ttf, fontSize: 11),
            ),
            pw.Text(
              'Date......${dateFormatter.format(model.omDate)}',
              style: pw.TextStyle(font: ttf, fontSize: 11),
            ),
          ],
        ),
        pw.SizedBox(height: 30),

        // Copy Forwarded Text
        pw.Text(
          'Copy forwarded to the following for information and necessary action',
          style: pw.TextStyle(font: ttf, fontSize: 11),
        ),
        pw.SizedBox(height: 20),

        // List of Recipients
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '1. ${model.recommendingOffice}',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                '2. Person concerned',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                '3. Dealing Assistant/Cashier',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                '4. Office File',
                style: pw.TextStyle(font: ttf, fontSize: 10),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 30),

        // Details Box
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(border: pw.Border.all(width: 1.5)),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Row 1: Name and Amount
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Employee Name: ${model.employeeName}',
                    style: pw.TextStyle(font: ttf, fontSize: 9),
                  ),
                  pw.Text(
                    'Amount: Rs. ${model.amount.toStringAsFixed(2)}',
                    style: pw.TextStyle(font: ttfBold, fontSize: 9),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),

              // Row 2: Designation
              pw.Text(
                'Designation: ${model.employeeDesignation}',
                style: pw.TextStyle(font: ttf, fontSize: 9),
              ),
              pw.SizedBox(height: 8),

              // Row 3: Division
              pw.Text(
                'Division: ${model.divisionName} | Division Code: ${model.divisionCode}',
                style: pw.TextStyle(font: ttf, fontSize: 9),
              ),
              pw.SizedBox(height: 8),

              // Row 4: Letter Details
              pw.Text(
                'Letter No: ${model.letterNumber} | Letter Date: ${dateFormatter.format(model.letterDate)}',
                style: pw.TextStyle(font: ttf, fontSize: 9),
              ),
            ],
          ),
        ),
        pw.Spacer(),

        // Signature Section (Two signatures side by side)
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            _buildSignatureBox('Forwarded By', ttf),
            _buildSignatureBox('Received By', ttf),
          ],
        ),
        pw.SizedBox(height: 20),

        // Footer Signature
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.SizedBox(height: 30),
              pw.Container(
                width: 120,
                decoration: const pw.BoxDecoration(
                  border: pw.Border(top: pw.BorderSide(width: 1)),
                ),
                padding: const pw.EdgeInsets.only(top: 5),
                child: pw.Text(
                  'Sanctioning Authority',
                  style: pw.TextStyle(font: ttf, fontSize: 9),
                  textAlign: pw.TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
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
