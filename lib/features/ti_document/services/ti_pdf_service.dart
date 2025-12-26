import 'dart:io';
import 'dart:typed_data';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/ti_pdf_model.dart';

class TiPdfService {
  /// Generate single PDF with 2 pages and auto-open it
  Future<File> generateAndOpen(TiPdfModel model) async {
    final pdfBytes = await _buildPdf(model);
    final file = await _savePdfToFile(pdfBytes, model);

    // Auto-open the PDF (just like Payment Authority)
    await OpenFilex.open(file.path);

    return file;
  }

  /// Build single PDF document with 2 pages
  Future<Uint8List> _buildPdf(TiPdfModel model) async {
    final doc = pw.Document();

    // Load fonts
    final ttf = await PdfGoogleFonts.robotoRegular();
    final ttfBold = await PdfGoogleFonts.robotoBold();

    final baseStyle = pw.TextStyle(font: ttf, fontSize: 10);
    final boldStyle = pw.TextStyle(
      font: ttfBold,
      fontSize: 10,
      fontWeight: pw.FontWeight.bold,
    );
    final titleStyle = pw.TextStyle(
      font: ttfBold,
      fontSize: 14,
      fontWeight: pw.FontWeight.bold,
    );

    // Page theme
    final pageTheme = await _buildPageTheme(PdfPageFormat.a4);

    // PAGE 1: Office Memorandum
    doc.addPage(
      pw.Page(
        pageTheme: pageTheme,
        build: (context) =>
            _buildOfficeMemorandumPage(model, baseStyle, boldStyle, titleStyle),
      ),
    );

    // PAGE 2: Forwarded Sheet
    doc.addPage(
      pw.Page(
        pageTheme: pageTheme,
        build: (context) =>
            _buildForwardedSheetPage(model, baseStyle, boldStyle, titleStyle),
      ),
    );

    return doc.save();
  }

  /// Build Page 1: Office Memorandum
  pw.Widget _buildOfficeMemorandumPage(
    TiPdfModel model,
    pw.TextStyle baseStyle,
    pw.TextStyle boldStyle,
    pw.TextStyle titleStyle,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Title
          pw.Center(child: pw.Text('OFFICE MEMORANDUM', style: titleStyle)),
          pw.SizedBox(height: 20),

          // OM Number and Date
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('No: ${model.omNumber}', style: boldStyle),
              pw.Text('Date: ${_formatDate(model.omDate)}', style: boldStyle),
            ],
          ),
          pw.SizedBox(height: 20),

          // Division
          pw.Text('Division: ${model.divisionName}', style: baseStyle),
          pw.Text('Division Code: ${model.divisionCode}', style: baseStyle),
          pw.SizedBox(height: 20),

          // Employee Details
          pw.Text('Employee: ${model.employeeName}', style: boldStyle),
          pw.Text(
            'Designation: ${model.employeeDesignation}',
            style: baseStyle,
          ),
          pw.SizedBox(height: 20),

          // Recommending Office
          pw.Text('Recommending Office:', style: boldStyle),
          pw.Text(model.recommendingOffice, style: baseStyle),
          pw.SizedBox(height: 10),

          pw.Text('Letter No: ${model.letterNumber}', style: baseStyle),
          pw.Text(
            'Letter Date: ${_formatDate(model.letterDate)}',
            style: baseStyle,
          ),

          pw.Spacer(),

          // Signatures
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildSignatureBox('Dealing Assistant'),
              _buildSignatureBox('Deputy Accountant'),
              _buildSignatureBox('Executive Engineer'),
            ],
          ),
        ],
      ),
    );
  }

  /// Build Page 2: Forwarded Sheet
  pw.Widget _buildForwardedSheetPage(
    TiPdfModel model,
    pw.TextStyle baseStyle,
    pw.TextStyle boldStyle,
    pw.TextStyle titleStyle,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(20),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Title
          pw.Center(child: pw.Text('FORWARDED SHEET', style: titleStyle)),
          pw.SizedBox(height: 20),

          // Reference
          pw.Text('Reference: OM No. ${model.omNumber}', style: boldStyle),
          pw.Text('Dated: ${_formatDate(model.omDate)}', style: baseStyle),
          pw.SizedBox(height: 20),

          // Employee
          pw.Text('Name: ${model.employeeName}', style: baseStyle),
          pw.Text(
            'Designation: ${model.employeeDesignation}',
            style: baseStyle,
          ),
          pw.SizedBox(height: 20),

          // Division
          pw.Text(
            'From Division: ${model.divisionName} (${model.divisionCode})',
            style: baseStyle,
          ),
          pw.SizedBox(height: 20),

          // Forwarded information
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 1)),
            child: pw.Text(
              'This document is forwarded for necessary action as per the instructions provided in the Office Memorandum.',
              style: baseStyle,
            ),
          ),

          pw.Spacer(),

          // Signatures
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _buildSignatureBox('Forwarded By'),
              _buildSignatureBox('Received By'),
            ],
          ),
        ],
      ),
    );
  }

  /// Helper: Build signature box
  pw.Widget _buildSignatureBox(String label) {
    return pw.Column(
      children: [
        pw.SizedBox(height: 30),
        pw.Container(
          width: 120,
          decoration: const pw.BoxDecoration(
            border: pw.Border(top: pw.BorderSide(width: 1)),
          ),
          padding: const pw.EdgeInsets.only(top: 5),
          child: pw.Text(
            label,
            style: pw.TextStyle(fontSize: 8),
            textAlign: pw.TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Helper: Format date
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  /// Helper: Build page theme
  Future<pw.PageTheme> _buildPageTheme(PdfPageFormat format) async {
    format = format.applyMargin(
      left: 25 * PdfPageFormat.mm,
      top: 20 * PdfPageFormat.mm,
      right: 25 * PdfPageFormat.mm,
      bottom: 20 * PdfPageFormat.mm,
    );

    return pw.PageTheme(
      pageFormat: format,
      theme: pw.ThemeData.withFont(
        base: await PdfGoogleFonts.robotoRegular(),
        bold: await PdfGoogleFonts.robotoBold(),
      ),
    );
  }

  /// Save PDF with proper filename: Division_Employee_TINumber.pdf
  Future<File> _savePdfToFile(Uint8List bytes, TiPdfModel model) async {
    final output = await getApplicationDocumentsDirectory();

    // Sanitize parts
    final sanitizedDivision = _sanitizeFilename(model.divisionName);
    final sanitizedEmployee = _sanitizeFilename(model.employeeName);
    final sanitizedOM = _sanitizeFilename(model.omNumber);

    // Format: Division_Employee_OMNumber.pdf
    final filename =
        '${sanitizedDivision}_${sanitizedEmployee}_${sanitizedOM}.pdf';

    final file = File('${output.path}/$filename');
    await file.writeAsBytes(bytes);

    return file;
  }

  /// Sanitize filename
  String _sanitizeFilename(String input) {
    return input
        .replaceAll(RegExp(r'[^\w\s-]'), '') // Remove special chars
        .replaceAll(RegExp(r'\s+'), '_') // Replace spaces
        .replaceAll(RegExp(r'_+'), '_') // Replace multiple underscores
        .trim();
  }
}
