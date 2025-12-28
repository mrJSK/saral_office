// lib/features/ti_document/services/ti_document_service.dart
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../models/ti_document.dart';
import 'ti_pdf_service.dart';

class TIDocumentService {
  final Isar isar;
  final TiPdfService _pdfService;

  TIDocumentService(this.isar) : _pdfService = TiPdfService();

  Future<void> saveTIDocument(
    TIDocumentModel tiDocument, {
    String status = 'Generated',
    String? pdfPath,
    DateTime? now,
  }) async {
    final doc = tiDocument.toIsarDocument(
      status: status,
      now: now,
      pdfPath: pdfPath,
    );

    await isar.writeTxn(() async {
      await isar.tIDocuments.put(doc);
    });

    debugPrint('✅ TI Document saved to database: OM ${doc.omNumber}');
  }

  Future<List<TIDocument>> getAllTIDocuments() async {
    return isar.tIDocuments.where().sortByCreatedAtDesc().findAll();
  }

  Future<List<TIDocument>> getTIDocumentsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    return isar.tIDocuments
        .filter()
        .createdAtBetween(startDate, endDate)
        .sortByCreatedAtDesc()
        .findAll();
  }

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

  /// Generates PDF and opens it; returns file path.
  /// Set [includeImprestPage] to true to include Page 3 (Imprest Cash Account Book).
  Future<String> generateTIDocumentPDF(
    TIDocumentModel tiDocument, {
    bool includeImprestPage = false,
  }) async {
    if (!tiDocument.isValid) {
      throw Exception('Invalid TI Document: Missing required fields');
    }

    try {
      final File file = await _pdfService.generateAndOpen(
        tiDocument,
        includeImprestPage: includeImprestPage,
      );
      debugPrint(
        '✅ TI Document PDF generated and opened successfully: ${file.path}',
      );
      return file.path;
    } catch (e) {
      debugPrint('❌ PDF Generation Error: $e');
      throw Exception('PDF Generation Error: $e');
    }
  }

  Future<String> generateAndSave(
    TIDocumentModel tiDocument, {
    String status = 'Generated',
    bool includeImprestPage = false,
  }) async {
    final pdfPath = await generateTIDocumentPDF(
      tiDocument,
      includeImprestPage: includeImprestPage,
    );
    await saveTIDocument(tiDocument, status: status, pdfPath: pdfPath);
    return pdfPath;
  }

  Future<String> getPDFStorageDirectory() async {
    return _pdfService.getPDFStorageDirectory();
  }

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

  Future<List<TIDocument>> getRecentTIDocuments({int limit = 5}) async {
    return isar.tIDocuments
        .where()
        .sortByCreatedAtDesc()
        .limit(limit)
        .findAll();
  }

  Future<List<TIDocument>> searchTIDocuments(String query) async {
    if (query.trim().isEmpty) {
      return getRecentTIDocuments(limit: 50);
    }

    return isar.tIDocuments
        .filter()
        .omNumberContains(query, caseSensitive: false)
        .or()
        .employeeNameContains(query, caseSensitive: false)
        .or()
        .divisionNameContains(query, caseSensitive: false)
        .sortByCreatedAtDesc()
        .findAll();
  }

  Future<TIDocument?> getTIDocumentById(int id) async {
    return isar.tIDocuments.get(id);
  }

  Future<int> getTIDocumentsCount() async {
    return isar.tIDocuments.count();
  }

  Future<int> getThisMonthTIDocumentsCount() async {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);

    return isar.tIDocuments.filter().createdAtGreaterThan(startOfMonth).count();
  }
}
