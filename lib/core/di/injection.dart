// lib/core/di/injection.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:saral_office/core/database/services/isar_service.dart';

// ✅ GLOBAL variables (outside any function)
IsarService? _isarServiceInstance;

/// Single initialization function to be called once in main()
Future<void> initializeApp() async {
  debugPrint('🔵 Starting initializeApp()...');

  // Create and initialize Isar service once
  final isarService = IsarService();
  await isarService.initialize();

  // Store it in the global variable
  _isarServiceInstance = isarService;

  debugPrint('✅ IsarService initialized: ${_isarServiceInstance != null}');
}

/// Getter for providers to access the singleton
IsarService getIsarService() {
  if (_isarServiceInstance == null) {
    throw Exception(
      'IsarService not initialized. Call initializeApp() in main() before runApp().',
    );
  }
  return _isarServiceInstance!;
}

// ============================================================================
// ✅ RIVERPOD PROVIDERS - ADD THESE
// ============================================================================

/// Provider for IsarService singleton
final isarServiceProvider = Provider<IsarService>((ref) {
  return getIsarService();
});

/// Provider for Isar instance
final isarProvider = Provider<Isar>((ref) {
  final service = ref.watch(isarServiceProvider);
  return service.isar;
});
