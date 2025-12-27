import 'dart:convert';
import 'package:isar/isar.dart';

import 'ti_pdf_model.dart';

part 'ti_document.g.dart';

@collection
class TIDocument {
  Id id = Isar.autoIncrement;

  // 1. OM (Office Memorandum) Details
  late String omNumber;
  late DateTime omDate;

  // 2. Amount
  late double amount;

  // 3. Recommending Office Details
  late String recommendingOffice;
  late String letterNumber;
  late DateTime letterDate;

  // 4. Division Details
  late String divisionName;
  late String fundsCenter;

  // 5. Employee Details
  late String employeeName;
  late String employeeDesignation;
  late String employeeSapId;

  // NEW FIELDS (Added to support the required parameters)
  late String employeeOffice;
  late String employeeOfficeHead;
  late String employeeOfficeHeadDesignation;

  // 6. Purpose
  late String purpose;

  // 7. Number of vouchers (page-3 footer)
  late int vouchersCount;

  // Metadata
  late DateTime createdAt;
  late DateTime updatedAt;
  late String status; // Draft, Generated, etc.

  String? pdfPath;

  /// Backup of all data in JSON format (includes imprestEntries)
  String? fullJsonData;
}

// ============================================================================
// State Model for Riverpod (Immutable)
// ============================================================================
class TIDocumentModel {
  // 1. OM Details
  final String? omNumber;
  final DateTime? omDate;

  // 2. Amount
  final double? amount;

  // 3. Recommending Office
  final String? recommendingOffice;
  final String? letterNumber;
  final DateTime? letterDate;

  // 4. Division
  final String? divisionName;
  final String? fundsCenter;

  // 5. Employee
  final String? employeeName;
  final String? employeeDesignation;
  final String? employeeSapId;

  // NEW FIELDS
  final String? employeeOffice;
  final String? employeeOfficeHead;
  final String? employeeOfficeHeadDesignation;

  // 6. Purpose
  final String? purpose;

  // 7. Page-3 inputs
  final int? vouchersCount;
  final List<ImprestLedgerEntry> imprestEntries;

  const TIDocumentModel({
    this.omNumber,
    this.omDate,
    this.amount,
    this.recommendingOffice,
    this.letterNumber,
    this.letterDate,
    this.divisionName,
    this.fundsCenter,
    this.employeeName,
    this.employeeDesignation,
    this.employeeSapId,
    this.employeeOffice,
    this.employeeOfficeHead,
    this.employeeOfficeHeadDesignation,
    this.purpose,
    this.vouchersCount,
    this.imprestEntries = const <ImprestLedgerEntry>[],
  });

  // FIX: All parameters in copyWith are now optional (nullable).
  TIDocumentModel copyWith({
    String? omNumber,
    DateTime? omDate,
    double? amount,
    String? recommendingOffice,
    String? letterNumber,
    DateTime? letterDate,
    String? divisionName,
    String? fundsCenter,
    String? employeeName,
    String? employeeDesignation,
    String? employeeSapId,
    String? employeeOffice,
    String? employeeOfficeHead,
    String? employeeOfficeHeadDesignation,
    String? purpose,
    int? vouchersCount,
    List<ImprestLedgerEntry>? imprestEntries,
  }) {
    return TIDocumentModel(
      omNumber: omNumber ?? this.omNumber,
      omDate: omDate ?? this.omDate,
      amount: amount ?? this.amount,
      recommendingOffice: recommendingOffice ?? this.recommendingOffice,
      letterNumber: letterNumber ?? this.letterNumber,
      letterDate: letterDate ?? this.letterDate,
      divisionName: divisionName ?? this.divisionName,
      fundsCenter: fundsCenter ?? this.fundsCenter,
      employeeName: employeeName ?? this.employeeName,
      employeeDesignation: employeeDesignation ?? this.employeeDesignation,
      employeeSapId: employeeSapId ?? this.employeeSapId,
      employeeOffice: employeeOffice ?? this.employeeOffice,
      employeeOfficeHead: employeeOfficeHead ?? this.employeeOfficeHead,
      employeeOfficeHeadDesignation:
          employeeOfficeHeadDesignation ?? this.employeeOfficeHeadDesignation,
      purpose: purpose ?? this.purpose,
      vouchersCount: vouchersCount ?? this.vouchersCount,
      imprestEntries: imprestEntries ?? this.imprestEntries,
    );
  }

  bool get isValid {
    return (omNumber != null && omNumber!.trim().isNotEmpty) &&
        (omDate != null) &&
        (amount != null && amount! > 0) &&
        (recommendingOffice != null && recommendingOffice!.trim().isNotEmpty) &&
        (letterNumber != null && letterNumber!.trim().isNotEmpty) &&
        (letterDate != null) &&
        (divisionName != null && divisionName!.trim().isNotEmpty) &&
        (fundsCenter != null && fundsCenter!.trim().isNotEmpty) &&
        (employeeName != null && employeeName!.trim().isNotEmpty) &&
        (employeeDesignation != null &&
            employeeDesignation!.trim().isNotEmpty) &&
        (employeeSapId != null && employeeSapId!.trim().isNotEmpty) &&
        // New validation checks (Optional: comment out if not strictly required)
        (employeeOffice != null && employeeOffice!.trim().isNotEmpty) &&
        (employeeOfficeHead != null && employeeOfficeHead!.trim().isNotEmpty) &&
        (employeeOfficeHeadDesignation != null &&
            employeeOfficeHeadDesignation!.trim().isNotEmpty) &&
        (purpose != null && purpose!.trim().isNotEmpty);
  }

  TIDocument toIsarDocument({
    String status = 'Generated',
    DateTime? now,
    String? pdfPath,
  }) {
    final ts = now ?? DateTime.now();

    final doc = TIDocument()
      ..omNumber = omNumber ?? ''
      ..omDate = omDate ?? ts
      ..amount = amount ?? 0.0
      ..recommendingOffice = recommendingOffice ?? ''
      ..letterNumber = letterNumber ?? ''
      ..letterDate = letterDate ?? ts
      ..divisionName = divisionName ?? ''
      ..fundsCenter = fundsCenter ?? ''
      ..employeeName = employeeName ?? ''
      ..employeeDesignation = employeeDesignation ?? ''
      ..employeeSapId = employeeSapId ?? ''
      ..employeeOffice = employeeOffice ?? ''
      ..employeeOfficeHead = employeeOfficeHead ?? ''
      ..employeeOfficeHeadDesignation = employeeOfficeHeadDesignation ?? ''
      ..purpose = purpose ?? ''
      ..vouchersCount = vouchersCount ?? 0
      ..createdAt = ts
      ..updatedAt = ts
      ..status = status
      ..pdfPath = pdfPath
      ..fullJsonData = toJson();

    return doc;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'omNumber': omNumber,
      'omDate': omDate?.toIso8601String(),
      'amount': amount,
      'recommendingOffice': recommendingOffice,
      'letterNumber': letterNumber,
      'letterDate': letterDate?.toIso8601String(),
      'divisionName': divisionName,
      'fundsCenter': fundsCenter,
      'employeeName': employeeName,
      'employeeDesignation': employeeDesignation,
      'employeeSapId': employeeSapId,
      'employeeOffice': employeeOffice,
      'employeeOfficeHead': employeeOfficeHead,
      'employeeOfficeHeadDesignation': employeeOfficeHeadDesignation,
      'purpose': purpose,
      'vouchersCount': vouchersCount,
      'imprestEntries': imprestEntries.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory TIDocumentModel.fromMap(Map<String, dynamic> map) {
    DateTime? dt(String? s) =>
        (s == null || s.isEmpty) ? null : DateTime.parse(s);

    final entriesRaw = map['imprestEntries'];
    final entries = <ImprestLedgerEntry>[];
    if (entriesRaw is List) {
      for (final item in entriesRaw) {
        if (item is Map) {
          entries.add(
            ImprestLedgerEntry.fromMap(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    return TIDocumentModel(
      omNumber: map['omNumber'] as String?,
      omDate: dt(map['omDate'] as String?),
      amount: (map['amount'] as num?)?.toDouble(),
      recommendingOffice: map['recommendingOffice'] as String?,
      letterNumber: map['letterNumber'] as String?,
      letterDate: dt(map['letterDate'] as String?),
      divisionName: map['divisionName'] as String?,
      fundsCenter: map['fundsCenter'] as String?,
      employeeName: map['employeeName'] as String?,
      employeeDesignation: map['employeeDesignation'] as String?,
      employeeSapId: map['employeeSapId'] as String?,
      employeeOffice: map['employeeOffice'] as String?,
      employeeOfficeHead: map['employeeOfficeHead'] as String?,
      employeeOfficeHeadDesignation:
          map['employeeOfficeHeadDesignation'] as String?,
      purpose: map['purpose'] as String?,
      vouchersCount: (map['vouchersCount'] as num?)?.toInt(),
      imprestEntries: entries,
    );
  }

  factory TIDocumentModel.fromJson(String source) =>
      TIDocumentModel.fromMap(jsonDecode(source) as Map<String, dynamic>);

  static TIDocumentModel fromIsarDocument(TIDocument doc) {
    // Prefer restoring full state (including imprestEntries) from fullJsonData.
    final json = doc.fullJsonData;
    if (json != null && json.trim().isNotEmpty) {
      try {
        return TIDocumentModel.fromJson(json);
      } catch (_) {
        // fall through to field mapping
      }
    }

    return TIDocumentModel(
      omNumber: doc.omNumber,
      omDate: doc.omDate,
      amount: doc.amount,
      recommendingOffice: doc.recommendingOffice,
      letterNumber: doc.letterNumber,
      letterDate: doc.letterDate,
      divisionName: doc.divisionName,
      fundsCenter: doc.fundsCenter,
      employeeName: doc.employeeName,
      employeeDesignation: doc.employeeDesignation,
      employeeSapId: doc.employeeSapId,
      employeeOffice: doc.employeeOffice,
      employeeOfficeHead: doc.employeeOfficeHead,
      employeeOfficeHeadDesignation: doc.employeeOfficeHeadDesignation,
      purpose: doc.purpose,
      vouchersCount: doc.vouchersCount,
      imprestEntries: const <ImprestLedgerEntry>[],
    );
  }
}
