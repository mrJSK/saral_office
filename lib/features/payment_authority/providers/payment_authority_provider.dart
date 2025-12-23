// lib/features/payment_authority/providers/payment_authority_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saral_office/core/di/injection.dart';
import 'package:saral_office/core/database/services/isar_service.dart';
import 'package:saral_office/core/database/models/vendor.dart';
import 'package:saral_office/core/database/models/gl_account.dart';
import 'package:saral_office/core/database/models/division.dart';
import 'package:saral_office/features/payment_authority/providers/payment_authority_pdf_model.dart';
import 'package:saral_office/features/payment_authority/services/payment_authority_pdf_service.dart';

/// --------------------
/// Core services
/// --------------------

final isarServiceProvider = Provider<IsarService>((ref) {
  return getIt<IsarService>();
});

final pdfServiceProvider = Provider<PaymentAuthorityPdfService>((ref) {
  return getIt<PaymentAuthorityPdfService>();
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

/// Divisions (no recents)
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

/// Mark vendor as recently used (call from vendor_search_field on selection)
final markVendorAsUsedProvider = FutureProvider.family<void, Vendor>((
  ref,
  vendor,
) async {
  final isar = ref.read(isarServiceProvider);
  await isar.markVendorAsUsed(vendor); // implement in IsarService
});

/// Mark GL as recently used (call from account_entry_card on selection)
final markGlAsUsedProvider = FutureProvider.family<void, GLAccount>((
  ref,
  gl,
) async {
  final isar = ref.read(isarServiceProvider);
  await isar.markGlAsUsed(gl); // implement in IsarService
});

final paymentAuthorityPdfServiceProvider = Provider<PaymentAuthorityPdfService>(
  (ref) {
    return PaymentAuthorityPdfService();
  },
);

/// **Fix:** Changed from FutureProvider to Provider returning a function.
/// This allows triggering the PDF generation action on demand without type issues.
final generatePaymentAuthorityPdfProvider =
    Provider.autoDispose<Future<void> Function()>((ref) {
      return () async {
        final state = ref.read(paymentAuthorityProvider);
        final pdfService = ref.read(paymentAuthorityPdfServiceProvider);

        final pdfModel = PaymentAuthorityPdfModel(
          divisionName: state.division?.name ?? '',
          divisionCode: state.division?.fundsCenter ?? '',
          date: state.date,
          payeeName: state.vendor?.fullName ?? '',
          payeeAddress: state.vendor?.fullAddress ?? '',
          paymentParticulars: state.particulars ?? '',
          authorityOrderNo: state.authorityOrderNo ?? '',
          authorityOrderDate: state.date,
          billNo: state.billNumber ?? '',
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

final markDivisionAsUsedProvider = FutureProvider.family<void, Division>((
  ref,
  division,
) async {
  final isar = ref.read(isarServiceProvider);
  await isar.markDivisionAsUsed(division);
});
