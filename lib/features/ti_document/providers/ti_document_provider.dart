// lib/features/ti_document/providers/ti_document_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/ti_document.dart';
import '../models/ti_pdf_model.dart'; // ← NEW: Import PDF model
import '../../../core/di/injection.dart';
import '../services/ti_pdf_service.dart'; // ← CHANGED: Use new PDF service
import '../../employee/models/employee.dart';
import '../../../core/database/models/division.dart';

// ============================================================================
// TI Document State Notifier
// ============================================================================

class TIDocumentNotifier extends StateNotifier<TIDocumentModel> {
  final Isar isar;
  final TiPdfService _tiPdfService; // ← CHANGED: Use TiPdfService

  TIDocumentNotifier(this.isar, this._tiPdfService) : super(TIDocumentModel());

  // 1. Update OM (Office Memorandum) Details
  void updateOMNumber(String number) {
    state = state.copyWith(omNumber: number);
  }

  void updateOMDate(DateTime date) {
    state = state.copyWith(omDate: date);
  }

  void updateOMDetails({required String number, required DateTime date}) {
    state = state.copyWith(omNumber: number, omDate: date);
  }

  // 2. Update Recommending Office Details
  void updateRecommendingOffice(String office) {
    state = state.copyWith(recommendingOffice: office);
  }

  void updateLetterNumber(String letterNo) {
    state = state.copyWith(letterNumber: letterNo);
  }

  void updateLetterDate(DateTime date) {
    state = state.copyWith(letterDate: date);
  }

  void updateRecommendingOfficeDetails({
    required String office,
    required String letterNo,
    required DateTime letterDate,
  }) {
    state = state.copyWith(
      recommendingOffice: office,
      letterNumber: letterNo,
      letterDate: letterDate,
    );
  }

  // 3. Update Division Details
  void updateDivision(Division division) {
    state = state.copyWith(
      divisionName: division.name,
      fundsCenter: division.fundsCenter,
    );
  }

  void updateDivisionDetails({
    required String divisionName,
    required String fundsCenter,
  }) {
    state = state.copyWith(
      divisionName: divisionName,
      fundsCenter: fundsCenter,
    );
  }

  // 4. Update Employee Details
  void updateEmployee(Employee employee) {
    state = state.copyWith(
      employeeName: employee.employeeName,
      employeeDesignation: employee.designation,
      employeeSapId: employee.sapId,
    );
  }

  void updateEmployeeDetails({
    required String name,
    required String designation,
    required String sapId,
  }) {
    state = state.copyWith(
      employeeName: name,
      employeeDesignation: designation,
      employeeSapId: sapId,
    );
  }

  // Load existing document
  void load(TIDocumentModel document) {
    state = document;
  }

  // Reset to initial state
  void reset() {
    state = TIDocumentModel();
  }

  // ✅ UPDATED: Generate single PDF with 2 pages and auto-open
  Future<void> generateAndSavePDF() async {
    if (!state.isValid) {
      throw Exception('Please fill all required fields');
    }

    try {
      // Convert state to TiPdfModel
      final pdfModel = TiPdfModel(
        omNumber: state.omNumber ?? '',
        omDate: state.omDate ?? DateTime.now(),
        recommendingOffice: state.recommendingOffice ?? '',
        letterNumber: state.letterNumber ?? '',
        letterDate: state.letterDate ?? DateTime.now(),
        divisionName: state.divisionName ?? '',
        divisionCode: state.fundsCenter ?? '',
        employeeName: state.employeeName ?? '',
        employeeDesignation: state.employeeDesignation ?? '',
      );

      // Generate single PDF with 2 pages and auto-open (like Payment Authority)
      await _tiPdfService.generateAndOpen(pdfModel);

      // Save to database
      await _saveTIDocument(state);
    } catch (e) {
      throw Exception('Failed to generate PDF: $e');
    }
  }

  // ✅ NEW: Save to database
  Future<void> _saveTIDocument(TIDocumentModel document) async {
    try {
      final doc = document.toIsarDocument();
      await isar.writeTxn(() async {
        await isar.tIDocuments.put(doc);
      });
    } catch (e) {
      throw Exception('Failed to save TI Document: $e');
    }
  }

  // Validate current state
  bool validate() {
    return state.isValid;
  }
}

// ============================================================================
// Riverpod Providers
// ============================================================================

// Main TI Document Provider
final tiDocumentProvider =
    StateNotifierProvider<TIDocumentNotifier, TIDocumentModel>((ref) {
      final isar = ref.watch(isarProvider);
      final tiPdfService = ref.watch(tiPdfServiceProvider); // ← CHANGED
      return TIDocumentNotifier(isar, tiPdfService); // ← CHANGED
    });

// ✅ NEW: TI PDF Service Provider
final tiPdfServiceProvider = Provider<TiPdfService>((ref) {
  return TiPdfService();
});

// Recent TI Documents Provider (for history/listing)
final recentTIDocumentsProvider = FutureProvider<List<TIDocument>>((ref) async {
  final isar = ref.watch(isarProvider);
  return await isar.tIDocuments
      .where()
      .sortByCreatedAtDesc()
      .limit(50)
      .findAll();
});

// Get TI Document by ID
final tiDocumentByIdProvider = FutureProvider.family<TIDocument?, int>((
  ref,
  id,
) async {
  final isar = ref.watch(isarProvider);
  return await isar.tIDocuments.get(id);
});

// Provider to count total TI documents (for stats)
final tiDocumentCountProvider = FutureProvider<int>((ref) async {
  final isar = ref.watch(isarProvider);
  return await isar.tIDocuments.count();
});

// Provider for this month's TI documents count
final thisMonthTIDocumentsProvider = FutureProvider<int>((ref) async {
  final isar = ref.watch(isarProvider);
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);

  return await isar.tIDocuments
      .filter()
      .createdAtGreaterThan(startOfMonth)
      .count();
});
