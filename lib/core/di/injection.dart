// lib/core/di/injection.dart

import 'package:saral_office/core/database/services/isar_service.dart';

// ✅ Single initialization function
Future<void> initializeApp() async {
  // Create and initialize Isar service once
  final isarService = IsarService();
  await isarService.initialize();

  // Store it in a global variable for provider access
  _isarServiceInstance = isarService;
}

// Private singleton instance
IsarService? _isarServiceInstance;

// Getter for providers to access
IsarService getIsarService() {
  if (_isarServiceInstance == null) {
    throw Exception('IsarService not initialized. Call initializeApp() first.');
  }
  return _isarServiceInstance!;
}
