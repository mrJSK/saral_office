// lib/features/ti_document/models/ti_pdf_model.dart

import 'dart:convert';
import 'dart:typed_data';

/// Page-3 row model (Imprest Cash Account Book)
/// Columns: Date, Vr. No, Transaction, Amount payable, Total, Head/GL Code
class ImprestLedgerEntry {
  final String date; // e.g. "26/12/2025"
  final String vrNo; // voucher / VR number
  final String transaction; // description
  final double payment; // amount payable
  final double total; // running total
  final String head; // Head / GL Code

  const ImprestLedgerEntry({
    required this.date,
    required this.vrNo,
    required this.transaction,
    required this.payment,
    required this.total,
    required this.head,
  });

  ImprestLedgerEntry copyWith({
    String? date,
    String? vrNo,
    String? transaction,
    double? payment,
    double? total,
    String? head,
  }) {
    return ImprestLedgerEntry(
      date: date ?? this.date,
      vrNo: vrNo ?? this.vrNo,
      transaction: transaction ?? this.transaction,
      payment: payment ?? this.payment,
      total: total ?? this.total,
      head: head ?? this.head,
    );
  }

  Map<String, dynamic> toMap() => {
    'date': date,
    'vrNo': vrNo,
    'transaction': transaction,
    'payment': payment,
    'total': total,
    'head': head,
  };

  factory ImprestLedgerEntry.fromMap(Map<String, dynamic> map) {
    return ImprestLedgerEntry(
      date: (map['date'] ?? '') as String,
      vrNo: (map['vrNo'] ?? '') as String,
      transaction: (map['transaction'] ?? '') as String,
      payment: (map['payment'] as num?)?.toDouble() ?? 0.0,
      total: (map['total'] as num?)?.toDouble() ?? 0.0,
      head: (map['head'] ?? '') as String,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ImprestLedgerEntry.fromJson(String source) =>
      ImprestLedgerEntry.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImprestLedgerEntry(date: $date, vrNo: $vrNo, payment: $payment, total: $total, head: $head)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ImprestLedgerEntry &&
        other.date == date &&
        other.vrNo == vrNo &&
        other.transaction == transaction &&
        other.payment == payment &&
        other.total == total &&
        other.head == head;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        vrNo.hashCode ^
        transaction.hashCode ^
        payment.hashCode ^
        total.hashCode ^
        head.hashCode;
  }
}

class TiPdfModel {
  // Office Memorandum Details
  final String omNumber;
  final DateTime omDate;

  // Recommending Office Details
  final String recommendingOffice;
  final String letterNumber;
  final DateTime letterDate;

  // Division & Employee
  final String divisionName;
  final String divisionCode;
  final String employeeName;
  final String employeeDesignation;

  // NEW: Employee Office Details
  final String? employeeOffice;
  final String? employeeOfficeHead;
  final String? employeeOfficeHeadDesignation;

  // Purpose of Temporary Advance
  final String purpose;

  // Amount for Temporary Advance Account
  final double amount;

  // ---------------------------------------------------------------------------
  // Page-3 inputs
  // ---------------------------------------------------------------------------
  final int vouchersCount;
  final List<ImprestLedgerEntry> imprestEntries;

  /// Optional: embed scanned register image
  final Uint8List? imprestScanBytes;
  final String? imprestScanPath;

  const TiPdfModel({
    required this.omNumber,
    required this.omDate,
    required this.recommendingOffice,
    required this.letterNumber,
    required this.letterDate,
    required this.divisionName,
    required this.divisionCode,
    required this.employeeName,
    required this.employeeDesignation,
    this.employeeOffice,
    this.employeeOfficeHead,
    this.employeeOfficeHeadDesignation,
    required this.purpose,
    required this.amount,
    this.vouchersCount = 0,
    this.imprestEntries = const [],
    this.imprestScanBytes,
    this.imprestScanPath,
  });

  // Backward-compatible alias (if any older PDF widgets still use this)
  double get imprestAmount => amount;

  TiPdfModel copyWith({
    String? omNumber,
    DateTime? omDate,
    String? recommendingOffice,
    String? letterNumber,
    DateTime? letterDate,
    String? divisionName,
    String? divisionCode,
    String? employeeName,
    String? employeeDesignation,
    String? employeeOffice,
    String? employeeOfficeHead,
    String? employeeOfficeHeadDesignation,
    String? purpose,
    double? amount,
    int? vouchersCount,
    List<ImprestLedgerEntry>? imprestEntries,
    Uint8List? imprestScanBytes,
    String? imprestScanPath,
  }) {
    return TiPdfModel(
      omNumber: omNumber ?? this.omNumber,
      omDate: omDate ?? this.omDate,
      recommendingOffice: recommendingOffice ?? this.recommendingOffice,
      letterNumber: letterNumber ?? this.letterNumber,
      letterDate: letterDate ?? this.letterDate,
      divisionName: divisionName ?? this.divisionName,
      divisionCode: divisionCode ?? this.divisionCode,
      employeeName: employeeName ?? this.employeeName,
      employeeDesignation: employeeDesignation ?? this.employeeDesignation,
      employeeOffice: employeeOffice ?? this.employeeOffice,
      employeeOfficeHead: employeeOfficeHead ?? this.employeeOfficeHead,
      employeeOfficeHeadDesignation:
          employeeOfficeHeadDesignation ?? this.employeeOfficeHeadDesignation,
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      vouchersCount: vouchersCount ?? this.vouchersCount,
      imprestEntries: imprestEntries ?? this.imprestEntries,
      imprestScanBytes: imprestScanBytes ?? this.imprestScanBytes,
      imprestScanPath: imprestScanPath ?? this.imprestScanPath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'omNumber': omNumber,
      'omDate': omDate.toIso8601String(),
      'recommendingOffice': recommendingOffice,
      'letterNumber': letterNumber,
      'letterDate': letterDate.toIso8601String(),
      'divisionName': divisionName,
      'divisionCode': divisionCode,
      'employeeName': employeeName,
      'employeeDesignation': employeeDesignation,
      'employeeOffice': employeeOffice,
      'employeeOfficeHead': employeeOfficeHead,
      'employeeOfficeHeadDesignation': employeeOfficeHeadDesignation,
      'purpose': purpose,
      'amount': amount,
      'vouchersCount': vouchersCount,
      'imprestEntries': imprestEntries.map((e) => e.toMap()).toList(),
      'imprestScanBytes': imprestScanBytes,
      'imprestScanPath': imprestScanPath,
    };
  }

  factory TiPdfModel.fromMap(Map<dynamic, dynamic> map) {
    final entriesRaw = map['imprestEntries'];
    final entries = <ImprestLedgerEntry>[];
    if (entriesRaw is List) {
      for (final item in entriesRaw) {
        if (item is Map) {
          entries.add(
            ImprestLedgerEntry.fromMap(Map<String, dynamic>.from(item as Map)),
          );
        }
      }
    }

    return TiPdfModel(
      omNumber: (map['omNumber'] ?? '') as String,
      omDate: DateTime.parse(
        (map['omDate'] ?? DateTime.now().toIso8601String()) as String,
      ),
      recommendingOffice: (map['recommendingOffice'] ?? '') as String,
      letterNumber: (map['letterNumber'] ?? '') as String,
      letterDate: DateTime.parse(
        (map['letterDate'] ?? DateTime.now().toIso8601String()) as String,
      ),
      divisionName: (map['divisionName'] ?? '') as String,
      divisionCode: (map['divisionCode'] ?? '') as String,
      employeeName: (map['employeeName'] ?? '') as String,
      employeeDesignation: (map['employeeDesignation'] ?? '') as String,
      employeeOffice: map['employeeOffice'] as String?,
      employeeOfficeHead: map['employeeOfficeHead'] as String?,
      employeeOfficeHeadDesignation:
          map['employeeOfficeHeadDesignation'] as String?,
      purpose: (map['purpose'] ?? '') as String,
      amount: (map['amount'] as num?)?.toDouble() ?? 0.0,
      vouchersCount: (map['vouchersCount'] as num?)?.toInt() ?? 0,
      imprestEntries: entries,
      imprestScanBytes: map['imprestScanBytes'] as Uint8List?,
      imprestScanPath: map['imprestScanPath'] as String?,
    );
  }

  String toJson() => jsonEncode(toMap());

  factory TiPdfModel.fromJson(String source) =>
      TiPdfModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TiPdfModel('
        'omNumber: $omNumber, '
        'omDate: $omDate, '
        'divisionName: $divisionName, '
        'employeeName: $employeeName, '
        'amount: $amount, '
        'vouchersCount: $vouchersCount, '
        'imprestEntries: ${imprestEntries.length}'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TiPdfModel &&
        other.omNumber == omNumber &&
        other.omDate == omDate &&
        other.recommendingOffice == recommendingOffice &&
        other.letterNumber == letterNumber &&
        other.letterDate == letterDate &&
        other.divisionName == divisionName &&
        other.divisionCode == divisionCode &&
        other.employeeName == employeeName &&
        other.employeeDesignation == employeeDesignation &&
        other.employeeOffice == employeeOffice &&
        other.employeeOfficeHead == employeeOfficeHead &&
        other.employeeOfficeHeadDesignation == employeeOfficeHeadDesignation &&
        other.purpose == purpose &&
        other.amount == amount &&
        other.vouchersCount == vouchersCount &&
        _listEquals(other.imprestEntries, imprestEntries) &&
        other.imprestScanPath == imprestScanPath;
  }

  @override
  int get hashCode {
    return omNumber.hashCode ^
        omDate.hashCode ^
        recommendingOffice.hashCode ^
        letterNumber.hashCode ^
        letterDate.hashCode ^
        divisionName.hashCode ^
        divisionCode.hashCode ^
        employeeName.hashCode ^
        employeeDesignation.hashCode ^
        employeeOffice.hashCode ^
        employeeOfficeHead.hashCode ^
        employeeOfficeHeadDesignation.hashCode ^
        purpose.hashCode ^
        amount.hashCode ^
        vouchersCount.hashCode ^
        imprestEntries.length.hashCode ^
        imprestScanPath.hashCode;
  }

  static bool _listEquals<T>(List<T> a, List<T> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
