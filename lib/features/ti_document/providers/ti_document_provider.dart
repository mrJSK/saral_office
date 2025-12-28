// lib/features/ti_document/providers/ti_document_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:saral_office/features/ti_document/models/imprest_ledger_entry.dart';

import '../../../core/di/injection.dart';
import '../../../core/database/models/division.dart';
import '../../employee/models/employee.dart';

import '../models/ti_document.dart';
import '../services/ti_document_service.dart';

// ============================================================================
// TI Document State Notifier
// ============================================================================

class TIDocumentNotifier extends StateNotifier<TIDocumentModel> {
  final Isar isar;
  final TIDocumentService _tiDocumentService;

  TIDocumentNotifier(this.isar, this._tiDocumentService)
    : super(const TIDocumentModel());

  // --------------------------------------------------------------------------
  // 1) OM
  // --------------------------------------------------------------------------

  void updateOMNumber(String number) =>
      state = state.copyWith(omNumber: number);

  void updateOMDate(DateTime date) => state = state.copyWith(omDate: date);

  void updateOMDetails({required String number, required DateTime date}) {
    state = state.copyWith(omNumber: number, omDate: date);
  }

  // --------------------------------------------------------------------------
  // 2) Amount
  // --------------------------------------------------------------------------

  void updateAmount(double amount) => state = state.copyWith(amount: amount);

  // --------------------------------------------------------------------------
  // 3) Purpose
  // --------------------------------------------------------------------------

  void updatePurpose(String purpose) =>
      state = state.copyWith(purpose: purpose);

  // --------------------------------------------------------------------------
  // 4) Recommending Office
  // --------------------------------------------------------------------------

  void updateRecommendingOffice(String office) =>
      state = state.copyWith(recommendingOffice: office);

  void updateLetterNumber(String letterNo) =>
      state = state.copyWith(letterNumber: letterNo);

  void updateLetterDate(DateTime date) =>
      state = state.copyWith(letterDate: date);

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

  void updateEmployeeOfficeDetails({
    String? office,
    String? head,
    String? headDesignation,
  }) {
    state = state.copyWith(
      employeeOffice: office,
      employeeOfficeHead: head,
      employeeOfficeHeadDesignation: headDesignation,
    );
  }

  // --------------------------------------------------------------------------
  // 5) Division
  // --------------------------------------------------------------------------

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

  // --------------------------------------------------------------------------
  // 6) Employee
  // --------------------------------------------------------------------------

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

  // --------------------------------------------------------------------------
  // 7) Page-3: vouchers count
  // --------------------------------------------------------------------------

  void updateVouchersCount(int count) =>
      state = state.copyWith(vouchersCount: count);

  void addImprestEntry(ImprestLedgerEntry entry) {
    final next = <ImprestLedgerEntry>[...state.imprestEntries, entry];
    state = state.copyWith(imprestEntries: _withRunningTotals(next));
  }

  void removeImprestEntry(int index) {
    final next = <ImprestLedgerEntry>[...state.imprestEntries]..removeAt(index);
    state = state.copyWith(imprestEntries: _withRunningTotals(next));
  }

  void updateImprestEntry(int index, ImprestLedgerEntry updated) {
    final next = <ImprestLedgerEntry>[...state.imprestEntries];
    next[index] = updated;
    state = state.copyWith(imprestEntries: _withRunningTotals(next));
  }

  void clearImprestEntries() {
    state = state.copyWith(imprestEntries: const <ImprestLedgerEntry>[]);
  }

  List<ImprestLedgerEntry> _withRunningTotals(List<ImprestLedgerEntry> list) {
    double running = 0.0;
    return list.map((e) {
      running += e.payment;
      return e.copyWith(total: running);
    }).toList();
  }

  // --------------------------------------------------------------------------
  // Load / Reset
  // --------------------------------------------------------------------------

  void load(TIDocumentModel document) => state = document;

  void reset() => state = const TIDocumentModel();

  bool validate() => state.isValid;

  // --------------------------------------------------------------------------
  // Generate + Save
  // --------------------------------------------------------------------------

  /// Generate & Save
  Future<void> generateAndSavePDF({required bool includeImprestPage}) async {
    if (!state.isValid) {
      throw Exception('Please fill all required fields');
    }

    // ✅ PASS includeImprestPage to the service
    await _tiDocumentService.generateTIDocumentPDF(
      state,
      includeImprestPage: includeImprestPage, // ← ADD THIS
    );
    await _tiDocumentService.saveTIDocument(state);
  }
}

// ============================================================================
// Providers
// ============================================================================

final tiDocumentServiceProvider = Provider<TIDocumentService>((ref) {
  final isar = ref.watch(isarProvider);
  return TIDocumentService(isar);
});

final tiDocumentProvider =
    StateNotifierProvider<TIDocumentNotifier, TIDocumentModel>((ref) {
      final isar = ref.watch(isarProvider);
      final service = ref.watch(tiDocumentServiceProvider);
      return TIDocumentNotifier(isar, service);
    });

final recentTIDocumentsProvider = FutureProvider<List<TIDocument>>((ref) async {
  final isar = ref.watch(isarProvider);
  return isar.tIDocuments.where().sortByCreatedAtDesc().limit(50).findAll();
});

final tiDocumentByIdProvider = FutureProvider.family<TIDocument?, int>((
  ref,
  id,
) async {
  final isar = ref.watch(isarProvider);
  return isar.tIDocuments.get(id);
});

final tiDocumentCountProvider = FutureProvider<int>((ref) async {
  final isar = ref.watch(isarProvider);
  return isar.tIDocuments.count();
});

final thisMonthTIDocumentsProvider = FutureProvider<int>((ref) async {
  final isar = ref.watch(isarProvider);
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  return isar.tIDocuments.filter().createdAtGreaterThan(startOfMonth).count();
});
