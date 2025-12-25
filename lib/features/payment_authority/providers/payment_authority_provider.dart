// lib/features/payment_authority/providers/payment_authority_provider.dart

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saral_office/core/di/injection.dart';
import 'package:saral_office/core/database/services/isar_service.dart';
import 'package:saral_office/core/database/models/vendor.dart';
import 'package:saral_office/core/database/models/gl_account.dart';
import 'package:saral_office/core/database/models/division.dart';
import 'package:saral_office/core/database/models/saved_authority.dart';
import 'package:saral_office/features/payment_authority/providers/payment_authority_pdf_model.dart';
import 'package:saral_office/features/payment_authority/services/payment_authority_pdf_service.dart';

/// --------------------
/// Core services
/// --------------------

// ✅ Riverpod provider for IsarService
final isarServiceProvider = Provider<IsarService>((ref) {
  return getIsarService();
});

// ✅ Riverpod provider for PDF Service
final pdfServiceProvider = Provider<PaymentAuthorityPdfService>((ref) {
  // Pass the required IsarService instance
  final isarService = ref.watch(isarServiceProvider);
  return PaymentAuthorityPdfService(isarService);
});

/// --------------------
/// Search providers
/// --------------------

/// Vendors (when query is empty, IsarService returns recent vendors)
final vendorSearchProvider = FutureProvider.family<List<Vendor>, String>((
  ref,
  query,
) async {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.searchVendors(query);
});

/// GL Accounts (when query is empty, IsarService returns recent GLs)
final glAccountSearchProvider = FutureProvider.family<List<GLAccount>, String>((
  ref,
  query,
) async {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.searchGLAccounts(query);
});

/// Divisions (when query is empty, IsarService returns recent divisions)
final divisionSearchProvider = FutureProvider.family<List<Division>, String>((
  ref,
  query,
) async {
  final isarService = ref.watch(isarServiceProvider);
  return isarService.searchDivisions(query);
});

/// --------------------
/// Domain state models
/// --------------------

class PaymentAuthority {
  final Division? division;
  final DateTime date;
  final String authorityOrderNo;
  final String billNumber;
  final DateTime billDate;
  final Vendor? vendor;
  final String particulars;
  final List<AccountEntry> entries;

  PaymentAuthority({
    this.division,
    required this.date,
    this.authorityOrderNo = '',
    this.billNumber = '',
    required this.billDate,
    this.vendor,
    this.particulars = '',
    this.entries = const [],
  });

  PaymentAuthority copyWith({
    Division? division,
    DateTime? date,
    String? authorityOrderNo,
    String? billNumber,
    DateTime? billDate,
    Vendor? vendor,
    String? particulars,
    List<AccountEntry>? entries,
  }) {
    return PaymentAuthority(
      division: division ?? this.division,
      date: date ?? this.date,
      authorityOrderNo: authorityOrderNo ?? this.authorityOrderNo,
      billNumber: billNumber ?? this.billNumber,
      billDate: billDate ?? this.billDate,
      vendor: vendor ?? this.vendor,
      particulars: particulars ?? this.particulars,
      entries: entries ?? this.entries,
    );
  }

  double get totalDebit =>
      entries.where((e) => e.isDebit).fold(0.0, (sum, e) => sum + e.amount);

  double get totalCredit =>
      entries.where((e) => !e.isDebit).fold(0.0, (sum, e) => sum + e.amount);

  bool get isBalanced => (totalDebit - totalCredit).abs() < 0.01;

  /// Serialize to JSON for database storage
  Map<String, dynamic> toMap() {
    return {
      'division': division != null
          ? {
              'fundsCenter': division!.fundsCenter,
              'name': division!.name,
              'personResponsible': division!.personResponsible,
            }
          : null,
      'date': date.toIso8601String(),
      'authorityOrderNo': authorityOrderNo,
      'billNumber': billNumber,
      'billDate': billDate.toIso8601String(),
      'vendor': vendor != null
          ? {
              'vendorCode': vendor!.vendorCode,
              'name1': vendor!.name1,
              'name2': vendor!.name2,
              'street1': vendor!.street1,
              'street2': vendor!.street2,
              'street3': vendor!.street3,
              'street4': vendor!.street4,
              'city': vendor!.city,
              'district': vendor!.district,
              'postalCode': vendor!.postalCode,
              'region': vendor!.region,
              'pan': vendor!.pan,
              'gst': vendor!.gst,
              'ifsc': vendor!.ifsc,
              'bankAccount': vendor!.bankAccount,
              'email': vendor!.email,
            }
          : null,
      'particulars': particulars,
      'entries': entries
          .map(
            (e) => {
              'description': e.description,
              'amount': e.amount,
              'isDebit': e.isDebit,
              'glAccount': e.glAccount != null
                  ? {
                      'glCode': e.glAccount!.glCode,
                      'glDescription': e.glAccount!.glDescription,
                      'agCode': e.glAccount!.agCode,
                      'agDescription': e.glAccount!.agDescription,
                      'mainAccountCode': e.glAccount!.mainAccountCode,
                      'mainAccountDescription':
                          e.glAccount!.mainAccountDescription,
                    }
                  : null,
            },
          )
          .toList(),
    };
  }

  /// Deserialize from JSON
  static PaymentAuthority fromMap(Map<String, dynamic> map) {
    final divisionData = map['division'] as Map<String, dynamic>?;
    final vendorData = map['vendor'] as Map<String, dynamic>?;
    final entriesData = (map['entries'] as List<dynamic>?) ?? [];

    Division? division;
    if (divisionData != null) {
      division = Division()
        ..fundsCenter = divisionData['fundsCenter'] ?? ''
        ..name = divisionData['name'] ?? ''
        ..personResponsible = divisionData['personResponsible'];
    }

    Vendor? vendor;
    if (vendorData != null) {
      vendor = Vendor()
        ..vendorCode = vendorData['vendorCode'] ?? ''
        ..name1 = vendorData['name1'] ?? ''
        ..name2 = vendorData['name2'] ?? ''
        ..street1 = vendorData['street1'] ?? ''
        ..street2 = vendorData['street2'] ?? ''
        ..street3 = vendorData['street3'] ?? ''
        ..street4 = vendorData['street4'] ?? ''
        ..city = vendorData['city'] ?? ''
        ..district = vendorData['district'] ?? ''
        ..postalCode = vendorData['postalCode'] ?? ''
        ..region = vendorData['region'] ?? ''
        ..pan = vendorData['pan'] ?? ''
        ..gst = vendorData['gst'] ?? ''
        ..ifsc = vendorData['ifsc']
        ..bankAccount = vendorData['bankAccount']
        ..email = vendorData['email'];
    }

    final entries = <AccountEntry>[];
    for (var entryData in entriesData) {
      final entry = entryData as Map<String, dynamic>;
      final glData = entry['glAccount'] as Map<String, dynamic>?;

      GLAccount? glAccount;
      if (glData != null) {
        glAccount = GLAccount()
          ..glCode = glData['glCode'] ?? ''
          ..glDescription = glData['glDescription'] ?? ''
          ..agCode = glData['agCode']
          ..agDescription = glData['agDescription']
          ..mainAccountCode = glData['mainAccountCode']
          ..mainAccountDescription = glData['mainAccountDescription'];
      }

      entries.add(
        AccountEntry(
          description: entry['description'] ?? '',
          glAccount: glAccount,
          amount: (entry['amount'] as num?)?.toDouble() ?? 0.0,
          isDebit: entry['isDebit'] as bool? ?? false,
        ),
      );
    }

    return PaymentAuthority(
      division: division,
      date: DateTime.parse(
        map['date'] as String? ?? DateTime.now().toIso8601String(),
      ),
      authorityOrderNo: map['authorityOrderNo'] as String? ?? '',
      billNumber: map['billNumber'] as String? ?? '',
      billDate: DateTime.parse(
        map['billDate'] as String? ?? DateTime.now().toIso8601String(),
      ),
      vendor: vendor,
      particulars: map['particulars'] as String? ?? '',
      entries: entries,
    );
  }
}

class AccountEntry {
  final String description;
  final GLAccount? glAccount;
  final double amount;
  final bool isDebit;

  AccountEntry({
    required this.description,
    this.glAccount,
    required this.amount,
    required this.isDebit,
  });

  AccountEntry copyWith({
    String? description,
    GLAccount? glAccount,
    double? amount,
    bool? isDebit,
  }) {
    return AccountEntry(
      description: description ?? this.description,
      glAccount: glAccount ?? this.glAccount,
      amount: amount ?? this.amount,
      isDebit: isDebit ?? this.isDebit,
    );
  }
}

/// --------------------
/// State Notifier
/// --------------------

class PaymentAuthorityNotifier extends StateNotifier<PaymentAuthority> {
  PaymentAuthorityNotifier()
    : super(PaymentAuthority(date: DateTime.now(), billDate: DateTime.now()));

  void updateDivision(Division division) {
    state = state.copyWith(division: division);
  }

  void updateDate(DateTime date) {
    state = state.copyWith(date: date);
  }

  void updateAuthorityOrderNo(String value) {
    state = state.copyWith(authorityOrderNo: value);
  }

  void updateBillNumber(String value) {
    state = state.copyWith(billNumber: value);
  }

  void updateBillDate(DateTime date) {
    state = state.copyWith(billDate: date);
  }

  void updateVendor(Vendor vendor) {
    state = state.copyWith(vendor: vendor);
  }

  void updateParticulars(String value) {
    state = state.copyWith(particulars: value);
  }

  void addEntry(AccountEntry entry) {
    state = state.copyWith(entries: [...state.entries, entry]);
  }

  void updateEntry(int index, AccountEntry entry) {
    final newEntries = List<AccountEntry>.from(state.entries);
    if (index >= 0 && index < newEntries.length) {
      newEntries[index] = entry;
      state = state.copyWith(entries: newEntries);
    }
  }

  void removeEntry(int index) {
    final entries = List<AccountEntry>.from(state.entries);
    if (index >= 0 && index < entries.length) {
      entries.removeAt(index);
      state = state.copyWith(entries: entries);
    }
  }

  /// Load a saved authority into the state (restore for editing)
  void load(PaymentAuthority authority) {
    state = authority;
  }

  void reset() {
    state = PaymentAuthority(date: DateTime.now(), billDate: DateTime.now());
  }
}

final paymentAuthorityProvider =
    StateNotifierProvider<PaymentAuthorityNotifier, PaymentAuthority>((ref) {
      return PaymentAuthorityNotifier();
    });

/// --------------------
/// Actions with services
/// --------------------

/// Mark vendor as recently used
final markVendorAsUsedProvider = FutureProvider.family<void, Vendor>((
  ref,
  vendor,
) async {
  final isar = ref.read(isarServiceProvider);
  await isar.markVendorAsUsed(vendor);
});

/// Mark GL as recently used
final markGlAsUsedProvider = FutureProvider.family<void, GLAccount>((
  ref,
  gl,
) async {
  final isar = ref.read(isarServiceProvider);
  await isar.markGlAsUsed(gl);
});

/// Mark division as recently used
final markDivisionAsUsedProvider = FutureProvider.family<void, Division>((
  ref,
  division,
) async {
  final isar = ref.read(isarServiceProvider);
  await isar.markDivisionAsUsed(division);
});

/// Generate PDF and save authority to database
final generatePaymentAuthorityPdfProvider =
    Provider.autoDispose<Future<void> Function()>((ref) {
      return () async {
        final state = ref.read(paymentAuthorityProvider);
        final pdfService = ref.read(pdfServiceProvider);
        final isar = ref.read(isarServiceProvider);

        // Save to database before generating PDF
        final savedAuthority = SavedAuthority()
          ..createdAt = DateTime.now()
          ..authorityOrderNo = state.authorityOrderNo
          ..vendorName = state.vendor?.name1 ?? 'N/A'
          ..amount = state.totalDebit
          ..divisionCode = state.division?.fundsCenter ?? ''
          ..divisionName = state.division?.name ?? ''
          ..fullJsonData = jsonEncode(state.toMap());

        await isar.saveAuthority(savedAuthority);

        // Generate PDF
        final pdfModel = PaymentAuthorityPdfModel(
          divisionName: state.division?.name ?? '',
          divisionCode: state.division?.fundsCenter ?? '',
          date: state.date,
          payeeName: state.vendor?.name1 ?? '',
          payeeAddress: state.vendor?.fullAddress ?? '',
          // Pass new fields from the selected vendor
          payeePan: state.vendor?.pan,
          payeeGst: state.vendor?.gst,
          payeeIfsc: state.vendor?.ifsc, // <--- NEW
          payeeBankAccount: state.vendor?.bankAccount, // <--- NEW
          payeeEmail: state.vendor?.email, // <--- NEW
          paymentParticulars: state.particulars,
          authorityOrderNo: state.authorityOrderNo,
          authorityOrderDate: state.date,
          billNo: state.billNumber,
          billDate: state.billDate,
          netAmount: state.totalDebit,
          debitLines: state.entries
              .where((e) => e.isDebit)
              .map(
                (e) => AuthorityLine(
                  description: e.description,
                  glCode: e.glAccount?.glCode ?? '',
                  amount: e.amount,
                ),
              )
              .toList(),
          creditLines: state.entries
              .where((e) => !e.isDebit)
              .map(
                (e) => AuthorityLine(
                  description: e.description,
                  glCode: e.glAccount?.glCode ?? '',
                  amount: e.amount,
                ),
              )
              .toList(),
        );

        await pdfService.generateAndOpen(pdfModel);
      };
    });

/// Recent authorities stream provider
final recentAuthoritiesProvider = StreamProvider<List<SavedAuthority>>((
  ref,
) async* {
  final isar = ref.watch(isarServiceProvider);
  yield* isar.watchRecentAuthorities();
});
