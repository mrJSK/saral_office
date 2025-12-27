// lib/features/ti_document/services/ti_document_service.dart

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import '../models/ti_document.dart';
import '../models/ti_pdf_model.dart';
import 'ti_pdf_service.dart';

class TIDocumentService {
  final Isar isar;
  final TiPdfService _pdfService;

  TIDocumentService(this.isar) : _pdfService = TiPdfService();

  // ============================================================================
  // Save TI Document to Database
  // ============================================================================

  Future<void> saveTIDocument(TIDocumentModel tiDocument) async {
    final doc = tiDocument.toIsarDocument();

    await isar.writeTxn(() async {
      await isar.tIDocuments.put(doc);
    });

    debugPrint('✅ TI Document saved to database: OM ${doc.omNumber}');
  }

  // ============================================================================
  // Get All TI Documents
  // ============================================================================

  Future<List<TIDocument>> getAllTIDocuments() async {
    return await isar.tIDocuments.where().sortByCreatedAtDesc().findAll();
  }

  // ============================================================================
  // Get TI Documents by Date Range
  // ============================================================================

  Future<List<TIDocument>> getTIDocumentsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await isar.tIDocuments
        .filter()
        .createdAtBetween(startDate, endDate)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // ============================================================================
  // Delete TI Document
  // ============================================================================

  Future<void> deleteTIDocument(int id) async {
    await isar.writeTxn(() async {
      await isar.tIDocuments.delete(id);
    });

    debugPrint('🗑️ TI Document deleted: ID $id');
  }

  Future<void> deleteTIDocuments(List<int> ids) async {
    await isar.writeTxn(() async {
      await isar.tIDocuments.deleteAll(ids);
    });

    debugPrint('🗑️ ${ids.length} TI Documents deleted');
  }

  // ============================================================================
  // Generate PDF Document (uses TiPdfService)
  // ============================================================================

  Future<void> generateTIDocumentPDF(TIDocumentModel tiDocument) async {
    if (!tiDocument.isValid) {
      throw Exception('Invalid TI Document: Missing required fields');
    }

    try {
      // Convert TIDocumentModel to TiPdfModel
      final pdfModel = TiPdfModel(
        omNumber: tiDocument.omNumber ?? '',
        omDate: tiDocument.omDate ?? DateTime.now(),
        amount: tiDocument.amount ?? 0.0,
        recommendingOffice: tiDocument.recommendingOffice ?? '',
        letterNumber: tiDocument.letterNumber ?? '',
        letterDate: tiDocument.letterDate ?? DateTime.now(),
        divisionName: tiDocument.divisionName ?? '',
        divisionCode: tiDocument.fundsCenter ?? '',
        employeeName: tiDocument.employeeName ?? '',
        employeeDesignation: tiDocument.employeeDesignation ?? '',
        purpose: tiDocument.purpose ?? '',
        vouchersCount: tiDocument.vouchersCount ?? 0,
        imprestEntries: tiDocument.imprestEntries,
      );

      // Generate and open PDF (single PDF with 2 pages)
      await _pdfService.generateAndOpen(pdfModel);

      debugPrint('✅ TI Document PDF generated and opened successfully');
    } catch (e) {
      debugPrint('❌ PDF Generation Error: $e');
      throw Exception('PDF Generation Error: $e');
    }
  }

  // ============================================================================
  // Get PDF Storage Directory
  // ============================================================================

  Future<String> getPDFStorageDirectory() async {
    return await _pdfService.getPDFStorageDirectory();
  }

  // ============================================================================
  // Get Statistics
  // ============================================================================

  Future<Map<String, dynamic>> getTIDocumentStats() async {
    final allDocs = await getAllTIDocuments();
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    final thisMonthDocs = allDocs
        .where((doc) => doc.createdAt.isAfter(startOfMonth))
        .toList();

    return {
      'total': allDocs.length,
      'thisMonth': thisMonthDocs.length,
      'lastCreated': allDocs.isNotEmpty ? allDocs.first.createdAt : null,
    };
  }

  // ============================================================================
  // Get Recent TI Documents (for home screen)
  // ============================================================================

  Future<List<TIDocument>> getRecentTIDocuments({int limit = 5}) async {
    return await isar.tIDocuments
        .where()
        .sortByCreatedAtDesc()
        .limit(limit)
        .findAll();
  }

  // ============================================================================
  // Search TI Documents
  // ============================================================================

  Future<List<TIDocument>> searchTIDocuments(String query) async {
    if (query.isEmpty) {
      return await getRecentTIDocuments(limit: 50);
    }

    return await isar.tIDocuments
        .filter()
        .omNumberContains(query, caseSensitive: false)
        .or()
        .employeeNameContains(query, caseSensitive: false)
        .or()
        .divisionNameContains(query, caseSensitive: false)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // ============================================================================
  // Get TI Document by ID
  // ============================================================================

  Future<TIDocument?> getTIDocumentById(int id) async {
    return await isar.tIDocuments.get(id);
  }

  // ============================================================================
  // Get TI Documents Count
  // ============================================================================

  Future<int> getTIDocumentsCount() async {
    return await isar.tIDocuments.count();
  }

  // ============================================================================
  // Get This Month's TI Documents Count
  // ============================================================================

  Future<int> getThisMonthTIDocumentsCount() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    return await isar.tIDocuments
        .filter()
        .createdAtGreaterThan(startOfMonth)
        .count();
  }
}
