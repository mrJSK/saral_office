// lib/core/database/services/isar_service.dart

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart' as excel_pkg;
import 'package:saral_office/core/database/models/recent_division.dart';
import 'package:saral_office/core/database/models/recent_gl.dart';
import 'package:saral_office/core/database/models/recent_vendor.dart';
import 'package:saral_office/core/database/models/saved_authority.dart'; // Added import
import '../models/vendor.dart';
import '../models/gl_account.dart';
import '../models/division.dart';

class IsarService {
  late Isar isar;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Initialize Isar database
  Future<void> initialize() async {
    try {
      debugPrint('🔧 Initializing Isar...');
      final dir = await getApplicationDocumentsDirectory();

      isar = await Isar.open(
        [
          VendorSchema,
          GLAccountSchema,
          DivisionSchema,
          RecentGLSchema,
          RecentVendorSchema,
          RecentDivisionSchema,
          SavedAuthoritySchema, // Added Schema
        ],
        directory: dir.path,
        inspector: kDebugMode,
      );

      debugPrint('✅ Isar opened successfully');

      // Check if data needs to be imported
      await _checkAndImportData();

      _isInitialized = true;
    } catch (e, stackTrace) {
      debugPrint('❌ Error initializing Isar: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  Future<void> deleteAuthorities(List<int> ids) async {
    try {
      await isar.writeTxn(() async {
        await isar.savedAuthoritys.deleteAll(ids);
      });
      debugPrint('✅ Deleted ${ids.length} authorities');
    } catch (e) {
      debugPrint('❌ Error deleting authorities: $e');
      rethrow;
    }
  }

  // ---------------------------------------------------------------------------
  // NEW METHODS FOR SAVED AUTHORITIES
  // ---------------------------------------------------------------------------

  // Save payment authority to database
  Future<void> saveAuthority(SavedAuthority authority) async {
    try {
      await isar.writeTxn(() async {
        await isar.savedAuthoritys.put(authority);
      });
      debugPrint('✅ Authority saved: ${authority.authorityOrderNo}');
    } catch (e) {
      debugPrint('❌ Error saving authority: $e');
      rethrow;
    }
  }

  // Watch recent authorities (latest first, limit 10)
  Stream<List<SavedAuthority>> watchRecentAuthorities() {
    return isar.savedAuthoritys
        .where()
        .sortByCreatedAtDesc()
        .limit(10)
        .watch(fireImmediately: true);
  }

  // Get recent authorities once
  Future<List<SavedAuthority>> getRecentAuthorities() async {
    try {
      return await isar.savedAuthoritys
          .where()
          .sortByCreatedAtDesc()
          .limit(10)
          .findAll();
    } catch (e) {
      debugPrint('❌ Error fetching recent authorities: $e');
      return [];
    }
  }

  // ---------------------------------------------------------------------------
  // EXISTING METHODS
  // ---------------------------------------------------------------------------

  Future<void> markDivisionAsUsed(Division division) async {
    await isar.writeTxn(() async {
      final existing = await isar.recentDivisions
          .filter()
          .fundsCenterEqualTo(division.fundsCenter)
          .findFirst();

      if (existing != null) {
        existing.name = division.name;
        existing.lastUsedAt = DateTime.now();
        await isar.recentDivisions.put(existing);
      } else {
        await isar.recentDivisions.put(
          RecentDivision()
            ..fundsCenter = division.fundsCenter
            ..name = division.name
            ..lastUsedAt = DateTime.now(),
        );
      }

      // keep only latest 20
      final extra = await isar.recentDivisions
          .where()
          .sortByLastUsedAtDesc()
          .offset(20)
          .findAll();
      if (extra.isNotEmpty) {
        await isar.recentDivisions.deleteAll(extra.map((e) => e.id).toList());
      }
    });
  }

  // Mark a vendor as recently used
  Future<void> markVendorAsUsed(Vendor vendor) async {
    await isar.writeTxn(() async {
      final existing = await isar.recentVendors
          .filter()
          .vendorCodeEqualTo(vendor.vendorCode)
          .findFirst();

      if (existing != null) {
        existing.name1 = vendor.name1;
        existing.lastUsedAt = DateTime.now();
        await isar.recentVendors.put(existing);
      } else {
        await isar.recentVendors.put(
          RecentVendor()
            ..vendorCode = vendor.vendorCode
            ..name1 = vendor.name1
            ..lastUsedAt = DateTime.now(),
        );
      }

      // keep only latest 20
      final extra = await isar.recentVendors
          .where()
          .sortByLastUsedAtDesc()
          .offset(20)
          .findAll();
      if (extra.isNotEmpty) {
        await isar.recentVendors.deleteAll(extra.map((e) => e.id).toList());
      }
    });
  }

  Future<Map<String, String>> getGlDescriptionMapForCodes(
    Iterable<String> glCodes,
  ) async {
    if (!_isInitialized) return {};

    final codes = glCodes
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();

    if (codes.isEmpty) return {};

    // Use anyOf() to OR multiple glCodeEqualTo() filters
    final rows = await isar.gLAccounts
        .filter()
        .anyOf(codes, (q, code) => q.glCodeEqualTo(code))
        .findAll();

    return {for (final r in rows) r.glCode.trim(): r.glDescription.trim()};
  }

  // Mark a GL account as recently used
  Future<void> markGlAsUsed(GLAccount gl) async {
    await isar.writeTxn(() async {
      final existing = await isar.recentGLs
          .filter()
          .glCodeEqualTo(gl.glCode)
          .findFirst();

      if (existing != null) {
        existing.glDescription = gl.glDescription;
        existing.lastUsedAt = DateTime.now();
        await isar.recentGLs.put(existing);
      } else {
        await isar.recentGLs.put(
          RecentGL()
            ..glCode = gl.glCode
            ..glDescription = gl.glDescription
            ..lastUsedAt = DateTime.now(),
        );
      }

      // keep only latest 20
      final extra = await isar.recentGLs
          .where()
          .sortByLastUsedAtDesc()
          .offset(20)
          .findAll();
      if (extra.isNotEmpty) {
        await isar.recentGLs.deleteAll(extra.map((e) => e.id).toList());
      }
    });
  }

  // Check if data already exists, if not import
  Future<void> _checkAndImportData() async {
    final vendorCount = await isar.vendors.count();
    final glCount = await isar.gLAccounts.count();
    final divisionCount = await isar.divisions.count();

    debugPrint(
      '📊 Database counts - Vendors: $vendorCount, GL: $glCount, Divisions: $divisionCount',
    );

    if (vendorCount == 0 || glCount == 0 || divisionCount == 0) {
      debugPrint('📦 Importing data for the first time...');
      await importAllData();
      debugPrint('✅ Data import complete!');
    } else {
      debugPrint('✅ Database already initialized with data');
    }
  }

  // Import all data from CSV/Excel files
  Future<void> importAllData() async {
    await Future.wait([
      _importVendors(),
      _importGLAccounts(),
      _importDivisions(),
    ]);
  }

  // Safe string extraction helper for CSV data
  String? _safeCsvString(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }

  // Import Vendors from CSV
  // Import Vendors from CSV
  Future<void> _importVendors() async {
    try {
      // ✅ UPDATED: Pointing to the new combined CSV file
      debugPrint('📂 Loading Vendor_Master_Combined.csv...');
      final csvString = await rootBundle.loadString(
        'assets/data/Vendor_Master_Combined.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
        eol: '\n', // Explicitly handle newlines to prevent parsing errors
      );

      debugPrint('📄 Processing ${rows.length} rows');
      final vendors = <Vendor>[];

      // Skip header row (index 0)
      for (var i = 1; i < rows.length; i++) {
        try {
          final row = rows[i];
          if (row.isEmpty) continue;

          // Helper to safely get string values without crashing on nulls/bounds
          String? safe(int index) {
            if (index >= row.length) return null;
            final v = row[index];
            if (v == null) return null;
            final s = v.toString().trim();
            return s.isEmpty ? null : s;
          }

          final vendorCode = safe(0);
          final name1 = safe(1);

          // Validation: Code and Name are mandatory
          if (vendorCode == null ||
              vendorCode.isEmpty ||
              name1 == null ||
              name1.isEmpty) {
            continue;
          }

          final vendor = Vendor()
            ..vendorCode = vendorCode
            ..name1 = name1
            ..name2 = safe(2) ?? ''
            ..street1 = safe(3) ?? ''
            ..street2 = safe(4) ?? ''
            ..street3 = safe(5) ?? ''
            ..street4 = safe(6) ?? ''
            ..city = safe(7) ?? ''
            ..district = safe(8) ?? ''
            ..postalCode = safe(9) ?? ''
            ..region = safe(10) ?? ''
            ..pan = safe(11) ?? ''
            ..gst = safe(12) ?? ''
            // ✅ NEW FIELDS MAPPED FROM COMBINED CSV
            ..ifsc =
                safe(13) // Index 13: IFSC
            ..bankAccount =
                safe(14) // Index 14: Bank Account
            ..email = safe(15); // Index 15: Email

          vendors.add(vendor);
        } catch (e) {
          debugPrint('⚠️ Error parsing vendor row $i: $e');
          continue;
        }
      }

      if (vendors.isEmpty) {
        debugPrint('⚠️ No vendors parsed from Vendor_Master_Combined.csv');
        return;
      }

      debugPrint('💾 Saving ${vendors.length} vendors to database...');
      await isar.writeTxn(() async {
        // ✅ IMPORTANT: Clear old data to prevent duplicates and ensure new fields populate
        await isar.vendors.clear();
        await isar.vendors.putAll(vendors);
      });

      debugPrint('✅ Imported ${vendors.length} vendors');
    } catch (e, stackTrace) {
      debugPrint('❌ Error importing vendors: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  // Import GL Accounts from CSV with complete null safety
  Future<void> _importGLAccounts() async {
    try {
      debugPrint('📂 Loading account_code_gl_mapping.csv...');

      final csvString = await rootBundle.loadString(
        'assets/data/account_code_gl_mapping.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
      );

      debugPrint('📄 Processing ${rows.length} rows');

      final glAccounts = <GLAccount>[];

      // Skip header row
      for (var i = 1; i < rows.length; i++) {
        try {
          final row = rows[i];

          if (row.length < 8) {
            debugPrint('⚠️ Skipping row $i: insufficient columns');
            continue;
          }

          final glCode = _safeCsvString(row[6]) ?? '';
          final glDescription = _safeCsvString(row[7]) ?? '';

          if (glCode.isEmpty || glDescription.isEmpty) {
            continue;
          }

          final glAccount = GLAccount()
            ..glCode = glCode
            ..glDescription = glDescription
            ..agCode = _safeCsvString(row[0])
            ..agDescription = _safeCsvString(row[1])
            ..mainAccountCode = _safeCsvString(row[2])
            ..mainAccountDescription = _safeCsvString(row[3]);

          glAccounts.add(glAccount);
        } catch (e) {
          debugPrint('⚠️ Error parsing GL row $i: $e');
          continue;
        }
      }

      if (glAccounts.isEmpty) {
        debugPrint('⚠️ No GL accounts parsed from CSV file');
        return;
      }

      await isar.writeTxn(() async {
        await isar.gLAccounts.putAll(glAccounts);
      });

      debugPrint('✅ Imported ${glAccounts.length} GL accounts');
    } catch (e, stackTrace) {
      debugPrint('❌ Error importing GL accounts: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  // Import Divisions from CSV with complete null safety
  Future<void> _importDivisions() async {
    try {
      debugPrint('📂 Loading fm_area_1000.csv...');

      final csvString = await rootBundle.loadString(
        'assets/data/fm_area_1000.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
      );

      debugPrint('📄 Processing ${rows.length} rows');

      final divisions = <Division>[];

      // Skip header row
      for (var i = 1; i < rows.length; i++) {
        try {
          final row = rows[i];

          if (row.length < 2) {
            debugPrint('⚠️ Skipping row $i: insufficient columns');
            continue;
          }

          final fundsCenter = _safeCsvString(row[0]) ?? '';
          final name = _safeCsvString(row[1]) ?? '';

          if (fundsCenter.isEmpty || name.isEmpty) {
            continue;
          }

          final division = Division()
            ..fundsCenter = fundsCenter
            ..name = name
            ..personResponsible = row.length > 4
                ? _safeCsvString(row[4])
                : null;

          divisions.add(division);
        } catch (e) {
          debugPrint('⚠️ Error parsing division row $i: $e');
          continue;
        }
      }

      if (divisions.isEmpty) {
        debugPrint('⚠️ No divisions parsed from CSV file');
        return;
      }

      await isar.writeTxn(() async {
        await isar.divisions.putAll(divisions);
      });

      debugPrint('✅ Imported ${divisions.length} divisions');
    } catch (e, stackTrace) {
      debugPrint('❌ Error importing divisions: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  // Search methods
  // lib/core/database/services/isar_service.dart

  // Replace your searchVendors method:
  Future<List<Vendor>> searchVendors(String query) async {
    try {
      if (!_isInitialized) return [];

      if (query.isEmpty) {
        // ✅ Return recent vendors when no search query
        final recentVendorCodes = await isar.recentVendors
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentVendorCodes.isEmpty) {
          // No recents yet, return first 50
          return await isar.vendors.where().limit(50).findAll();
        }

        // Fetch full vendor data for recent vendor codes
        final vendors = <Vendor>[];
        for (var recent in recentVendorCodes) {
          final vendor = await isar.vendors
              .filter()
              .vendorCodeEqualTo(recent.vendorCode)
              .findFirst();
          if (vendor != null) vendors.add(vendor);
        }
        return vendors;
      }

      // Search logic
      final byCode = await isar.vendors
          .filter()
          .vendorCodeContains(query, caseSensitive: false)
          .findAll();

      final byName = await isar.vendors
          .filter()
          .name1Contains(query, caseSensitive: false)
          .findAll();

      final results = {...byCode, ...byName}.toList();
      return results.take(50).toList();
    } catch (e) {
      debugPrint('❌ Error searching vendors: $e');
      return [];
    }
  }

  // Replace your searchGLAccounts method:
  Future<List<GLAccount>> searchGLAccounts(String query) async {
    try {
      if (!_isInitialized) {
        debugPrint('⚠️ Isar not initialized');
        return [];
      }

      if (query.isEmpty) {
        // ✅ Return recent GL accounts when no search query
        final recentGLCodes = await isar.recentGLs
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentGLCodes.isEmpty) {
          // No recents yet, return first 50
          return await isar.gLAccounts.where().limit(50).findAll();
        }

        // Fetch full GL data for recent GL codes
        final glAccounts = <GLAccount>[];
        for (var recent in recentGLCodes) {
          final gl = await isar.gLAccounts
              .filter()
              .glCodeEqualTo(recent.glCode)
              .findFirst();
          if (gl != null) glAccounts.add(gl);
        }
        return glAccounts;
      }

      final results = await isar.gLAccounts
          .filter()
          .glCodeContains(query, caseSensitive: false)
          .or()
          .glDescriptionContains(query, caseSensitive: false)
          .limit(50)
          .findAll();

      debugPrint('🔍 Found ${results.length} GL accounts for query: "$query"');
      return results;
    } catch (e) {
      debugPrint('❌ Error searching GL accounts: $e');
      return [];
    }
  }

  // Replace your searchDivisions method:
  Future<List<Division>> searchDivisions(String query) async {
    try {
      if (!_isInitialized) return [];

      if (query.isEmpty) {
        // ✅ Return recent divisions when no search query
        final recentDivisionCodes = await isar.recentDivisions
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentDivisionCodes.isEmpty) {
          // No recents yet, return first 50
          return await isar.divisions.where().limit(50).findAll();
        }

        // Fetch full division data for recent division codes
        final divisions = <Division>[];
        for (var recent in recentDivisionCodes) {
          final division = await isar.divisions
              .filter()
              .fundsCenterEqualTo(recent.fundsCenter)
              .findFirst();
          if (division != null) divisions.add(division);
        }
        return divisions;
      }

      final results = await isar.divisions
          .filter()
          .fundsCenterContains(query, caseSensitive: false)
          .or()
          .nameContains(query, caseSensitive: false)
          .findAll();

      return results;
    } catch (e) {
      debugPrint('❌ Error searching divisions: $e');
      return [];
    }
  }

  // Watch methods for real-time updates
  Stream<List<Vendor>> watchVendors() {
    return isar.vendors.where().watch(fireImmediately: true);
  }

  Stream<List<GLAccount>> watchGLAccounts() {
    return isar.gLAccounts.where().watch(fireImmediately: true);
  }

  // Clear and reimport (for debugging)
  Future<void> clearAndReimport() async {
    try {
      debugPrint('🗑️ Clearing all data...');

      await isar.writeTxn(() async {
        await isar.vendors.clear();
        await isar.gLAccounts.clear();
        await isar.divisions.clear();
        await isar.savedAuthoritys.clear(); // Clear authorities too
      });

      debugPrint('📦 Reimporting data...');
      await importAllData();

      final vendorCount = await isar.vendors.count();
      final glCount = await isar.gLAccounts.count();
      final divisionCount = await isar.divisions.count();

      debugPrint('✅ Reimport complete:');
      debugPrint('  Vendors: $vendorCount');
      debugPrint('  GL Accounts: $glCount');
      debugPrint('  Divisions: $divisionCount');
    } catch (e) {
      debugPrint('❌ Error during reimport: $e');
    }
  }
}
