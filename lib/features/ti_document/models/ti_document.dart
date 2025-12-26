// lib/features/ti_document/models/ti_document.dart

import 'package:isar/isar.dart';

part 'ti_document.g.dart';

@collection
class TIDocument {
  Id id = Isar.autoIncrement;

  // 1. OM (Office Memorandum) Details
  late String omNumber;
  late DateTime omDate;

  // 2. Recommending Office Details
  late String recommendingOffice;
  late String letterNumber;
  late DateTime letterDate;

  // 3. Division Details
  late String divisionName;
  late String fundsCenter;

  // 4. Employee Details (Person creating/opening the TI)
  late String employeeName;
  late String employeeDesignation;
  late String employeeSapId;

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
  final String omNumber;
  final DateTime omDate;

  // 2. Recommending Office
  final String recommendingOffice;
  final String letterNumber;
  final DateTime letterDate;

  // 3. Division
  final String divisionName;
  final String fundsCenter;

  // 4. Employee
  final String employeeName;
  final String employeeDesignation;
  final String employeeSapId;

  TIDocumentModel({
    this.omNumber = '',
    DateTime? omDate,
    this.recommendingOffice = '',
    this.letterNumber = '',
    DateTime? letterDate,
    this.divisionName = '',
    this.fundsCenter = '',
    this.employeeName = '',
    this.employeeDesignation = '',
    this.employeeSapId = '',
  }) : omDate = omDate ?? DateTime.now(),
       letterDate = letterDate ?? DateTime.now();

  TIDocumentModel copyWith({
    String? omNumber,
    DateTime? omDate,
    String? recommendingOffice,
    String? letterNumber,
    DateTime? letterDate,
    String? divisionName,
    String? fundsCenter,
    String? employeeName,
    String? employeeDesignation,
    String? employeeSapId,
  }) {
    return TIDocumentModel(
      omNumber: omNumber ?? this.omNumber,
      omDate: omDate ?? this.omDate,
      recommendingOffice: recommendingOffice ?? this.recommendingOffice,
      letterNumber: letterNumber ?? this.letterNumber,
      letterDate: letterDate ?? this.letterDate,
      divisionName: divisionName ?? this.divisionName,
      fundsCenter: fundsCenter ?? this.fundsCenter,
      employeeName: employeeName ?? this.employeeName,
      employeeDesignation: employeeDesignation ?? this.employeeDesignation,
      employeeSapId: employeeSapId ?? this.employeeSapId,
    );
  }

  // Validation
  bool get isValid {
    return omNumber.isNotEmpty &&
        recommendingOffice.isNotEmpty &&
        letterNumber.isNotEmpty &&
        divisionName.isNotEmpty &&
        employeeName.isNotEmpty;
  }

  // Convert to Isar Document
  TIDocument toIsarDocument() {
    return TIDocument()
      ..omNumber = omNumber
      ..omDate = omDate
      ..recommendingOffice = recommendingOffice
      ..letterNumber = letterNumber
      ..letterDate = letterDate
      ..divisionName = divisionName
      ..fundsCenter = fundsCenter
      ..employeeName = employeeName
      ..employeeDesignation = employeeDesignation
      ..employeeSapId = employeeSapId
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
      "omDate": "${omDate.toIso8601String()}",
      "recommendingOffice": "$recommendingOffice",
      "letterNumber": "$letterNumber",
      "letterDate": "${letterDate.toIso8601String()}",
      "divisionName": "$divisionName",
      "fundsCenter": "$fundsCenter",
      "employeeName": "$employeeName",
      "employeeDesignation": "$employeeDesignation",
      "employeeSapId": "$employeeSapId"
    }
    ''';
  }

  // Create from Isar Document
  static TIDocumentModel fromIsarDocument(TIDocument doc) {
    return TIDocumentModel(
      omNumber: doc.omNumber,
      omDate: doc.omDate,
      recommendingOffice: doc.recommendingOffice,
      letterNumber: doc.letterNumber,
      letterDate: doc.letterDate,
      divisionName: doc.divisionName,
      fundsCenter: doc.fundsCenter,
      employeeName: doc.employeeName,
      employeeDesignation: doc.employeeDesignation,
      employeeSapId: doc.employeeSapId,
    );
  }
}
