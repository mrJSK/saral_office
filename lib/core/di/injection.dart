// lib/core/di/injection.dart

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:saral_office/core/database/services/firebase_service.dart';
import 'package:saral_office/core/database/services/isar_service.dart';
import 'package:saral_office/core/database/models/vendor.dart';
import 'package:saral_office/core/database/models/gl_account.dart';
import 'package:saral_office/core/database/models/division.dart';
import 'package:saral_office/core/database/models/service_master.dart';
import 'package:saral_office/core/database/models/material_master.dart';
import 'package:saral_office/features/procurement/models/purchase_requisition.dart';
import 'package:saral_office/features/procurement/services/pr_service.dart';

// ============================================================================
// GLOBAL SINGLETON INSTANCES
// ============================================================================

IsarService? _isarServiceInstance;
final _firebaseService = FirebaseService();

// ============================================================================
// INITIALIZATION
// ============================================================================

/// Single initialization function to be called once in main()
Future<void> initializeApp() async {
  debugPrint('🔵 Starting initializeApp()...');

  // Create and initialize Isar service once
  final isarService = IsarService();
  await isarService.initialize();

  // Store it in the global variable
  _isarServiceInstance = isarService;

  debugPrint('✅ IsarService initialized: ${_isarServiceInstance != null}');
  debugPrint('✅ Firebase service ready');
}

// ============================================================================
// SINGLETON GETTERS
// ============================================================================

/// Getter for IsarService singleton
IsarService getIsarService() {
  if (_isarServiceInstance == null) {
    throw Exception(
      'IsarService not initialized. Call initializeApp() in main() before runApp().',
    );
  }

  return _isarServiceInstance!;
}

/// Getter for FirebaseService singleton
FirebaseService getFirebaseService() => _firebaseService;

// ============================================================================
// CORE SERVICE PROVIDERS
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

/// Provider for FirebaseService singleton
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return getFirebaseService();
});

// ============================================================================
// PROCUREMENT SERVICE PROVIDERS
// ============================================================================

/// Provider for PRService
final prServiceProvider = Provider<PRService>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return PRService(isarService);
});

/// Provider for all Purchase Requisitions
final allPRsProvider = FutureProvider<List<PurchaseRequisition>>((ref) async {
  final prService = ref.watch(prServiceProvider);
  return prService.getAllPRs();
});

/// Provider for PR statistics
final prStatisticsProvider = FutureProvider<Map<String, int>>((ref) async {
  final prService = ref.watch(prServiceProvider);
  return prService.getPRStatistics();
});

/// Provider for recent PRs
final recentPRsProvider = FutureProvider<List<PurchaseRequisition>>((
  ref,
) async {
  final prService = ref.watch(prServiceProvider);
  return prService.getRecentPRs(limit: 10);
});

/// Provider for PR search
final prSearchProvider =
    FutureProvider.family<List<PurchaseRequisition>, String>((
      ref,
      query,
    ) async {
      final prService = ref.watch(prServiceProvider);
      return prService.searchPRs(query);
    });

/// Provider for PR with items
final prWithItemsProvider = FutureProvider.family<Map<String, dynamic>, String>(
  (ref, prNumber) async {
    final prService = ref.watch(prServiceProvider);
    return prService.getPRWithItems(prNumber);
  },
);

// ============================================================================
// VENDOR PROVIDERS
// ============================================================================

/// Provider for vendor search
final vendorSearchProvider = FutureProvider.family<List<Vendor>, String>((
  ref,
  query,
) async {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.searchVendors(query);
});

/// Stream provider for watching all vendors
final vendorsStreamProvider = StreamProvider<List<Vendor>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.watchVendors();
});

// ============================================================================
// GL ACCOUNT PROVIDERS
// ============================================================================

/// Provider for GL account search
final glAccountSearchProvider = FutureProvider.family<List<GLAccount>, String>((
  ref,
  query,
) async {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.searchGLAccounts(query);
});

/// Stream provider for watching all GL accounts
final glAccountsStreamProvider = StreamProvider<List<GLAccount>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.watchGLAccounts();
});

/// Provider for getting GL descriptions by codes
final glDescriptionMapProvider =
    FutureProvider.family<Map<String, String>, List<String>>((
      ref,
      codes,
    ) async {
      final isarService = ref.watch(isarServiceProvider);
      return isarService.getGlDescriptionMapForCodes(codes);
    });

// ============================================================================
// DIVISION PROVIDERS
// ============================================================================

/// Provider for division search
final divisionSearchProvider = FutureProvider.family<List<Division>, String>((
  ref,
  query,
) async {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.searchDivisions(query);
});

// ============================================================================
// SERVICE MASTER PROVIDERS
// ============================================================================

/// Provider for service search
final serviceSearchProvider =
    FutureProvider.family<List<ServiceMaster>, String>((ref, query) async {
      final isarService = ref.watch(isarServiceProvider);
      return isarService.searchServices(query);
    });

/// Stream provider for watching all services
final servicesStreamProvider = StreamProvider<List<ServiceMaster>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.watchServices();
});

// ============================================================================
// MATERIAL MASTER PROVIDERS
// ============================================================================

/// Provider for material search
final materialSearchProvider =
    FutureProvider.family<List<MaterialMaster>, String>((ref, query) async {
      final isarService = ref.watch(isarServiceProvider);
      return isarService.searchMaterials(query);
    });

/// Stream provider for watching all materials
final materialsStreamProvider = StreamProvider<List<MaterialMaster>>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.watchMaterials();
});

// ============================================================================
// DATABASE STATISTICS PROVIDERS
// ============================================================================

/// Provider for database statistics
final databaseStatsProvider = FutureProvider<DatabaseStats>((ref) async {
  final isar = ref.watch(isarProvider);

  final vendorCount = await isar.vendors.count();
  final glCount = await isar.gLAccounts.count();
  final divisionCount = await isar.divisions.count();
  final serviceCount = await isar.serviceMasters.count();
  final materialCount = await isar.materialMasters.count();
  final prCount = await isar.purchaseRequisitions.count();

  return DatabaseStats(
    vendorCount: vendorCount,
    glAccountCount: glCount,
    divisionCount: divisionCount,
    serviceCount: serviceCount,
    materialCount: materialCount,
    prCount: prCount,
  );
});

// ============================================================================
// UTILITY CLASSES
// ============================================================================

/// Class to hold database statistics
class DatabaseStats {
  final int vendorCount;
  final int glAccountCount;
  final int divisionCount;
  final int serviceCount;
  final int materialCount;
  final int prCount;

  DatabaseStats({
    required this.vendorCount,
    required this.glAccountCount,
    required this.divisionCount,
    required this.serviceCount,
    required this.materialCount,
    required this.prCount,
  });

  int get totalRecords =>
      vendorCount +
      glAccountCount +
      divisionCount +
      serviceCount +
      materialCount +
      prCount;

  @override
  String toString() {
    return 'DatabaseStats(vendors: $vendorCount, glAccounts: $glAccountCount, '
        'divisions: $divisionCount, services: $serviceCount, materials: $materialCount, '
        'prs: $prCount)';
  }
}

// ============================================================================
// DEBUGGING UTILITIES
// ============================================================================

/// Provider to check if database is initialized
final isDatabaseInitializedProvider = Provider<bool>((ref) {
  try {
    final isarService = ref.watch(isarServiceProvider);
    return isarService.isInitialized;
  } catch (e) {
    return false;
  }
});

/// Provider to force database reimport (for debugging)
final reimportDatabaseProvider = FutureProvider<void>((ref) async {
  final isarService = ref.watch(isarServiceProvider);
  await isarService.clearAndReimport();
});
