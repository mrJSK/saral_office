// lib/features/ti_document/models/ti_document.dart

import 'package:isar/isar.dart';

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

  // 5. Employee Details (Person creating/opening the TI)
  late String employeeName;
  late String employeeDesignation;
  late String employeeSapId;

  // 6. Purpose (NEW FIELD ADDED)
  late String purpose;

  // Metadata
  late DateTime createdAt;
  late DateTime updatedAt;
  late String status; // Draft, Generated, etc.

  String? pdfPath;
  String? fullJsonData; // Backup of all data in JSON format
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

  // 6. Purpose (NEW FIELD ADDED)
  final String? purpose;

  TIDocumentModel({
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
    this.purpose, // <--- Add to constructor
  });

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
    String? purpose, // <--- Add to copyWith
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
      purpose: purpose ?? this.purpose, // <--- Add logic
    );
  }

  // Validation
  bool get isValid {
    return omNumber != null &&
        omNumber!.isNotEmpty &&
        amount != null &&
        amount! > 0 &&
        recommendingOffice != null &&
        recommendingOffice!.isNotEmpty &&
        letterNumber != null &&
        letterNumber!.isNotEmpty &&
        divisionName != null &&
        divisionName!.isNotEmpty &&
        employeeName != null &&
        employeeName!.isNotEmpty &&
        purpose != null && // <--- Add validation for purpose
        purpose!.isNotEmpty;
  }

  // Convert to Isar Document
  TIDocument toIsarDocument() {
    return TIDocument()
      ..omNumber = omNumber ?? ''
      ..omDate = omDate ?? DateTime.now()
      ..amount = amount ?? 0.0
      ..recommendingOffice = recommendingOffice ?? ''
      ..letterNumber = letterNumber ?? ''
      ..letterDate = letterDate ?? DateTime.now()
      ..divisionName = divisionName ?? ''
      ..fundsCenter = fundsCenter ?? ''
      ..employeeName = employeeName ?? ''
      ..employeeDesignation = employeeDesignation ?? ''
      ..employeeSapId = employeeSapId ?? ''
      ..purpose =
          purpose ??
          '' // <--- Set purpose
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now()
      ..status = 'Generated'
      ..fullJsonData = toJson();
  }

  // Serialization
  String toJson() {
    return '''
    {
      "omNumber": "$omNumber",
      "omDate": "${omDate?.toIso8601String()}",
      "amount": $amount,
      "recommendingOffice": "$recommendingOffice",
      "letterNumber": "$letterNumber",
      "letterDate": "${letterDate?.toIso8601String()}",
      "divisionName": "$divisionName",
      "fundsCenter": "$fundsCenter",
      "employeeName": "$employeeName",
      "employeeDesignation": "$employeeDesignation",
      "employeeSapId": "$employeeSapId",
      "purpose": "$purpose"
    }
    ''';
  }

  // Create from Isar Document
  static TIDocumentModel fromIsarDocument(TIDocument doc) {
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
      purpose: doc.purpose, // <--- Map from Isar doc
    );
  }
}
