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
import 'package:saral_office/core/database/models/recent_service.dart';
import 'package:saral_office/core/database/models/recent_material.dart';
import 'package:saral_office/core/database/models/saved_authority.dart';
import 'package:saral_office/features/employee/models/employee.dart';
import 'package:saral_office/features/ti_document/models/ti_document.dart';
import 'package:saral_office/features/procurement/models/purchase_requisition.dart';
import '../models/vendor.dart';
import '../models/gl_account.dart';
import '../models/division.dart';
import '../models/service_master.dart';
import '../models/material_master.dart';

class IsarService {
  late Isar isar;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // Getter for db to maintain compatibility with existing code
  Future<Isar> get db async => isar;

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
          ServiceMasterSchema,
          MaterialMasterSchema,
          RecentGLSchema,
          RecentVendorSchema,
          RecentDivisionSchema,
          RecentServiceSchema,
          RecentMaterialSchema,
          SavedAuthoritySchema,
          TIDocumentSchema,
          EmployeeSchema,
          // Procurement schemas
          PurchaseRequisitionSchema,
          PRLineItemSchema,
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

  // ---------------------------------------------------------------------------
  // AUTHORITY METHODS
  // ---------------------------------------------------------------------------

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

  Stream<List<SavedAuthority>> watchRecentAuthorities() {
    return isar.savedAuthoritys
        .where()
        .sortByCreatedAtDesc()
        .limit(10)
        .watch(fireImmediately: true);
  }

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
  // SERVICE MASTER METHODS
  // ---------------------------------------------------------------------------

  Future<void> markServiceAsUsed(ServiceMaster service) async {
    await isar.writeTxn(() async {
      final existing = await isar.recentServices
          .filter()
          .activityNumberEqualTo(service.activityNumber)
          .findFirst();

      if (existing != null) {
        existing.serviceShortText = service.serviceShortText;
        existing.lastUsedAt = DateTime.now();
        await isar.recentServices.put(existing);
      } else {
        await isar.recentServices.put(
          RecentService()
            ..activityNumber = service.activityNumber
            ..serviceShortText = service.serviceShortText
            ..lastUsedAt = DateTime.now(),
        );
      }

      // Keep only latest 20
      final extra = await isar.recentServices
          .where()
          .sortByLastUsedAtDesc()
          .offset(20)
          .findAll();
      if (extra.isNotEmpty) {
        await isar.recentServices.deleteAll(extra.map((e) => e.id).toList());
      }
    });
  }

  Future<List<ServiceMaster>> searchServices(String query) async {
    try {
      if (!_isInitialized) return [];

      if (query.isEmpty) {
        final recentServiceNumbers = await isar.recentServices
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentServiceNumbers.isEmpty) {
          return await isar.serviceMasters.where().limit(50).findAll();
        }

        final services = <ServiceMaster>[];
        for (var recent in recentServiceNumbers) {
          final service = await isar.serviceMasters
              .filter()
              .activityNumberEqualTo(recent.activityNumber)
              .findFirst();
          if (service != null) services.add(service);
        }

        return services;
      }

      final results = await isar.serviceMasters
          .filter()
          .activityNumberContains(query, caseSensitive: false)
          .or()
          .serviceShortTextContains(query, caseSensitive: false)
          .or()
          .serviceLongTextContains(query, caseSensitive: false)
          .limit(50)
          .findAll();

      debugPrint('🔍 Found ${results.length} services for query: "$query"');
      return results;
    } catch (e) {
      debugPrint('❌ Error searching services: $e');
      return [];
    }
  }

  Stream<List<ServiceMaster>> watchServices() {
    return isar.serviceMasters.where().watch(fireImmediately: true);
  }

  // ---------------------------------------------------------------------------
  // MATERIAL MASTER METHODS
  // ---------------------------------------------------------------------------

  Future<void> markMaterialAsUsed(MaterialMaster material) async {
    await isar.writeTxn(() async {
      final existing = await isar.recentMaterials
          .filter()
          .materialEqualTo(material.material)
          .findFirst();

      if (existing != null) {
        existing.materialDesc = material.materialDesc;
        existing.lastUsedAt = DateTime.now();
        await isar.recentMaterials.put(existing);
      } else {
        await isar.recentMaterials.put(
          RecentMaterial()
            ..material = material.material
            ..materialDesc = material.materialDesc
            ..lastUsedAt = DateTime.now(),
        );
      }

      // Keep only latest 20
      final extra = await isar.recentMaterials
          .where()
          .sortByLastUsedAtDesc()
          .offset(20)
          .findAll();
      if (extra.isNotEmpty) {
        await isar.recentMaterials.deleteAll(extra.map((e) => e.id).toList());
      }
    });
  }

  Future<List<MaterialMaster>> searchMaterials(String query) async {
    try {
      if (!_isInitialized) return [];

      if (query.isEmpty) {
        final recentMaterialCodes = await isar.recentMaterials
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentMaterialCodes.isEmpty) {
          return await isar.materialMasters.where().limit(50).findAll();
        }

        final materials = <MaterialMaster>[];
        for (var recent in recentMaterialCodes) {
          final material = await isar.materialMasters
              .filter()
              .materialEqualTo(recent.material)
              .findFirst();
          if (material != null) materials.add(material);
        }

        return materials;
      }

      final results = await isar.materialMasters
          .filter()
          .materialContains(query, caseSensitive: false)
          .or()
          .materialDescContains(query, caseSensitive: false)
          .or()
          .materialGroupDescContains(query, caseSensitive: false)
          .limit(50)
          .findAll();

      debugPrint('🔍 Found ${results.length} materials for query: "$query"');
      return results;
    } catch (e) {
      debugPrint('❌ Error searching materials: $e');
      return [];
    }
  }

  Stream<List<MaterialMaster>> watchMaterials() {
    return isar.materialMasters.where().watch(fireImmediately: true);
  }

  // ---------------------------------------------------------------------------
  // DIVISION METHODS
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

  Future<List<Division>> searchDivisions(String query) async {
    try {
      if (!_isInitialized) return [];

      if (query.isEmpty) {
        final recentDivisionCodes = await isar.recentDivisions
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentDivisionCodes.isEmpty) {
          return await isar.divisions.where().limit(50).findAll();
        }

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

  // ---------------------------------------------------------------------------
  // VENDOR METHODS
  // ---------------------------------------------------------------------------

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

  Future<List<Vendor>> searchVendors(String query) async {
    try {
      if (!_isInitialized) return [];

      if (query.isEmpty) {
        final recentVendorCodes = await isar.recentVendors
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentVendorCodes.isEmpty) {
          return await isar.vendors.where().limit(50).findAll();
        }

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

  Stream<List<Vendor>> watchVendors() {
    return isar.vendors.where().watch(fireImmediately: true);
  }

  // ---------------------------------------------------------------------------
  // GL ACCOUNT METHODS
  // ---------------------------------------------------------------------------

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

    final rows = await isar.gLAccounts
        .filter()
        .anyOf(codes, (q, code) => q.glCodeEqualTo(code))
        .findAll();

    return {for (final r in rows) r.glCode.trim(): r.glDescription.trim()};
  }

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

  Future<List<GLAccount>> searchGLAccounts(String query) async {
    try {
      if (!_isInitialized) {
        debugPrint('⚠️ Isar not initialized');
        return [];
      }

      if (query.isEmpty) {
        final recentGLCodes = await isar.recentGLs
            .where()
            .sortByLastUsedAtDesc()
            .limit(20)
            .findAll();

        if (recentGLCodes.isEmpty) {
          return await isar.gLAccounts.where().limit(50).findAll();
        }

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

  Stream<List<GLAccount>> watchGLAccounts() {
    return isar.gLAccounts.where().watch(fireImmediately: true);
  }

  // ---------------------------------------------------------------------------
  // DATA IMPORT METHODS
  // ---------------------------------------------------------------------------

  Future<void> _checkAndImportData() async {
    final vendorCount = await isar.vendors.count();
    final glCount = await isar.gLAccounts.count();
    final divisionCount = await isar.divisions.count();
    final serviceCount = await isar.serviceMasters.count();
    final materialCount = await isar.materialMasters.count();

    debugPrint(
      '📊 Database counts - Vendors: $vendorCount, GL: $glCount, '
      'Divisions: $divisionCount, Services: $serviceCount, Materials: $materialCount',
    );

    if (vendorCount == 0 ||
        glCount == 0 ||
        divisionCount == 0 ||
        serviceCount == 0 ||
        materialCount == 0) {
      debugPrint('📦 Importing data for the first time...');
      await importAllData();
      debugPrint('✅ Data import complete!');
    } else {
      debugPrint('✅ Database already initialized with data');
    }
  }

  Future<void> importAllData() async {
    await Future.wait([
      _importVendors(),
      _importGLAccounts(),
      _importDivisions(),
      _importServices(),
      _importMaterials(),
    ]);
  }

  String? _safeCsvString(dynamic value) {
    if (value == null) return null;
    final str = value.toString().trim();
    return str.isEmpty ? null : str;
  }

  Future<void> _importVendors() async {
    try {
      debugPrint('📂 Loading Vendor_Master_Combined.csv...');
      final csvString = await rootBundle.loadString(
        'assets/data/Vendor_Master_Combined.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
        eol: '\n',
      );

      debugPrint('📄 Processing ${rows.length} rows');

      final vendors = <Vendor>[];
      for (var i = 1; i < rows.length; i++) {
        try {
          final row = rows[i];
          if (row.isEmpty) continue;

          String? safe(int index) {
            if (index >= row.length) return null;
            final v = row[index];
            if (v == null) return null;
            final s = v.toString().trim();
            return s.isEmpty ? null : s;
          }

          final vendorCode = safe(0);
          final name1 = safe(1);

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
            ..ifsc = safe(13)
            ..bankAccount = safe(14)
            ..email = safe(15);

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
        await isar.vendors.clear();
        await isar.vendors.putAll(vendors);
      });

      debugPrint('✅ Imported ${vendors.length} vendors');
    } catch (e, stackTrace) {
      debugPrint('❌ Error importing vendors: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

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

  Future<void> _importServices() async {
    try {
      debugPrint('📂 Loading service_master.csv...');
      final csvString = await rootBundle.loadString(
        'assets/data/service_master.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
        eol: '\n',
      );

      debugPrint('📄 Processing ${rows.length} rows');

      final services = <ServiceMaster>[];
      for (var i = 1; i < rows.length; i++) {
        try {
          final row = rows[i];
          if (row.isEmpty) continue;

          String? safe(int index) {
            if (index >= row.length) return null;
            final v = row[index];
            if (v == null) return null;
            final s = v.toString().trim();
            return s.isEmpty ? null : s;
          }

          final activityNumber = safe(0);
          final serviceShortText = safe(9);

          if (activityNumber == null ||
              activityNumber.isEmpty ||
              serviceShortText == null ||
              serviceShortText.isEmpty) {
            continue;
          }

          final service = ServiceMaster()
            ..activityNumber = activityNumber
            ..materialGroup = safe(1) ?? ''
            ..materialGroupDesc = safe(2) ?? ''
            ..baseUnit = safe(3) ?? ''
            ..serviceCategory = safe(4) ?? ''
            ..serviceCategoryDesc = safe(5) ?? ''
            ..valuationClass = safe(6)
            ..valuationClassDesc = safe(7)
            ..glAccount = safe(8)
            ..serviceShortText = serviceShortText
            ..serviceLongText = safe(10) ?? serviceShortText
            ..deletionIndicator = safe(11);

          services.add(service);
        } catch (e) {
          debugPrint('⚠️ Error parsing service row $i: $e');
          continue;
        }
      }

      if (services.isEmpty) {
        debugPrint('⚠️ No services parsed from CSV file');
        return;
      }

      debugPrint('💾 Saving ${services.length} services to database...');
      await isar.writeTxn(() async {
        await isar.serviceMasters.clear();
        await isar.serviceMasters.putAll(services);
      });

      debugPrint('✅ Imported ${services.length} services');
    } catch (e, stackTrace) {
      debugPrint('❌ Error importing services: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  Future<void> _importMaterials() async {
    try {
      debugPrint('📂 Loading material_master.csv...');
      final csvString = await rootBundle.loadString(
        'assets/data/material_master.csv',
      );

      final List<List<dynamic>> rows = const CsvToListConverter().convert(
        csvString,
        eol: '\n',
      );

      debugPrint('📄 Processing ${rows.length} rows');

      final materials = <MaterialMaster>[];
      for (var i = 1; i < rows.length; i++) {
        try {
          final row = rows[i];
          if (row.isEmpty) continue;

          String? safe(int index) {
            if (index >= row.length) return null;
            final v = row[index];
            if (v == null) return null;
            final s = v.toString().trim();
            return s.isEmpty ? null : s;
          }

          final material = safe(1);
          final materialDesc = safe(3);

          if (material == null ||
              material.isEmpty ||
              materialDesc == null ||
              materialDesc.isEmpty) {
            continue;
          }

          final materialEntry = MaterialMaster()
            ..materialType = safe(0) ?? ''
            ..material = material
            ..baseUnitOfMeasure = safe(2) ?? ''
            ..materialDesc = materialDesc
            ..plant = safe(4) ?? ''
            ..materialGroup = safe(5) ?? ''
            ..materialGroupDesc = safe(6) ?? ''
            ..subGroup = safe(7) ?? ''
            ..subGroupDesc = safe(8) ?? ''
            ..splitValuationStatus = safe(9) ?? ''
            ..serialNumberStatus = safe(10) ?? '';

          materials.add(materialEntry);
        } catch (e) {
          debugPrint('⚠️ Error parsing material row $i: $e');
          continue;
        }
      }

      if (materials.isEmpty) {
        debugPrint('⚠️ No materials parsed from CSV file');
        return;
      }

      debugPrint('💾 Saving ${materials.length} materials to database...');
      await isar.writeTxn(() async {
        await isar.materialMasters.clear();
        await isar.materialMasters.putAll(materials);
      });

      debugPrint('✅ Imported ${materials.length} materials');
    } catch (e, stackTrace) {
      debugPrint('❌ Error importing materials: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  // ---------------------------------------------------------------------------
  // UTILITY METHODS
  // ---------------------------------------------------------------------------

  Future<void> clearAndReimport() async {
    try {
      debugPrint('🗑️ Clearing all data...');
      await isar.writeTxn(() async {
        await isar.vendors.clear();
        await isar.gLAccounts.clear();
        await isar.divisions.clear();
        await isar.serviceMasters.clear();
        await isar.materialMasters.clear();
        await isar.savedAuthoritys.clear();
      });

      debugPrint('📦 Reimporting data...');
      await importAllData();

      final vendorCount = await isar.vendors.count();
      final glCount = await isar.gLAccounts.count();
      final divisionCount = await isar.divisions.count();
      final serviceCount = await isar.serviceMasters.count();
      final materialCount = await isar.materialMasters.count();

      debugPrint('✅ Reimport complete:');
      debugPrint('   Vendors: $vendorCount');
      debugPrint('   GL Accounts: $glCount');
      debugPrint('   Divisions: $divisionCount');
      debugPrint('   Services: $serviceCount');
      debugPrint('   Materials: $materialCount');
    } catch (e) {
      debugPrint('❌ Error during reimport: $e');
      rethrow;
    }
  }
}
