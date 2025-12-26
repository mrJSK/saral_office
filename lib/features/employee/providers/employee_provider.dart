// lib/features/employee/providers/employee_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../../../core/di/injection.dart';
import '../models/employee.dart';

// ============================================================================
// Stream: All employees (live updates)
// ============================================================================

final employeesProvider = StreamProvider<List<Employee>>((ref) {
  final isar = ref.watch(isarProvider);

  // fires immediately AND whenever employees collection changes
  return isar.employees.watchLazy(fireImmediately: true).asyncMap((_) async {
    return await isar.employees.where().sortByCreatedAtDesc().findAll();
  });
});

// ============================================================================
// Future: search employees (used for search query)
// NOTE: we will manually refresh by invalidating this provider when needed.
// ============================================================================

final employeeSearchProvider = FutureProvider.family<List<Employee>, String>((
  ref,
  query,
) async {
  final isar = ref.watch(isarProvider);

  if (query.trim().isEmpty) {
    return await isar.employees.where().sortByCreatedAtDesc().findAll();
  }

  final q = query.trim().toLowerCase();

  // Isar doesn't support contains ignore-case easily without indexes.
  // So we fetch and filter in Dart (OK for small lists).
  final all = await isar.employees.where().findAll();

  final results = all.where((e) {
    return e.employeeName.toLowerCase().contains(q) ||
        e.designation.toLowerCase().contains(q) ||
        e.sapId.toLowerCase().contains(q);
  }).toList();

  // Keep same ordering
  results.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return results;
});

// ============================================================================
// Employee Notifier
// ============================================================================

class EmployeeNotifier extends StateNotifier<Employee> {
  final Ref ref;

  EmployeeNotifier(this.ref) : super(_empty());

  static Employee _empty() {
    return Employee()
      ..employeeName = ''
      ..designation = ''
      ..sapId = ''
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }

  Employee _copy({String? name, String? designation, String? sapId}) {
    return Employee()
      ..id = state.id
      ..employeeName = name ?? state.employeeName
      ..designation = designation ?? state.designation
      ..sapId = sapId ?? state.sapId
      ..createdAt = state.createdAt
      ..updatedAt = DateTime.now();
  }

  void updateName(String name) => state = _copy(name: name);
  void updateDesignation(String value) => state = _copy(designation: value);
  void updateSapId(String value) => state = _copy(sapId: value);

  void loadEmployee(Employee employee) {
    state = employee;
  }

  Future<void> saveEmployee() async {
    final name = state.employeeName.trim();
    final desig = state.designation.trim();
    final sap = state.sapId.trim();

    if (name.isEmpty || desig.isEmpty || sap.isEmpty) {
      throw Exception('All fields are required');
    }

    final isar = ref.read(isarProvider);

    final isNew = state.id == Isar.autoIncrement;

    final toSave = Employee()
      ..id = state.id
      ..employeeName = name
      ..designation = desig
      ..sapId = sap
      ..createdAt = isNew ? DateTime.now() : state.createdAt
      ..updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.employees.put(toSave);
    });

    // refresh UI
    ref.invalidate(employeesProvider);
    ref.invalidate(employeeSearchProvider);

    reset();
  }

  Future<void> deleteEmployee(int id) async {
    final isar = ref.read(isarProvider);
    await isar.writeTxn(() async {
      await isar.employees.delete(id);
    });

    ref.invalidate(employeesProvider);
    ref.invalidate(employeeSearchProvider);
  }

  void reset() {
    state = _empty();
  }
}

final employeeNotifierProvider =
    StateNotifierProvider<EmployeeNotifier, Employee>((ref) {
      return EmployeeNotifier(ref);
    });
