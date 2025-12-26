// lib/features/ti_document/models/ti_pdf_model.dart

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

  // Purpose of Temporary Advance
  final String purpose;

  // Amount for Temporary Advance Account
  final double amount;

  TiPdfModel({
    required this.omNumber,
    required this.omDate,
    required this.recommendingOffice,
    required this.letterNumber,
    required this.letterDate,
    required this.divisionName,
    required this.divisionCode,
    required this.employeeName,
    required this.employeeDesignation,
    required this.purpose,
    required this.amount,
  });

  // ---------------------------------------------------------------------------
  // COPY WITH
  // ---------------------------------------------------------------------------
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
    String? purpose,
    double? amount,
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
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
    );
  }

  // ---------------------------------------------------------------------------
  // TO MAP (DB / API)
  // ---------------------------------------------------------------------------
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
      'purpose': purpose,
      'amount': amount,
    };
  }

  // ---------------------------------------------------------------------------
  // FROM MAP
  // ---------------------------------------------------------------------------
  factory TiPdfModel.fromMap(Map<String, dynamic> map) {
    return TiPdfModel(
      omNumber: map['omNumber'] as String,
      omDate: DateTime.parse(map['omDate'] as String),
      recommendingOffice: map['recommendingOffice'] as String,
      letterNumber: map['letterNumber'] as String,
      letterDate: DateTime.parse(map['letterDate'] as String),
      divisionName: map['divisionName'] as String,
      divisionCode: map['divisionCode'] as String,
      employeeName: map['employeeName'] as String,
      employeeDesignation: map['employeeDesignation'] as String,
      purpose: map['purpose'] as String,
      amount: (map['amount'] as num).toDouble(),
    );
  }

  // ---------------------------------------------------------------------------
  // DEBUG
  // ---------------------------------------------------------------------------
  @override
  String toString() {
    return 'TiPdfModel('
        'omNumber: $omNumber, '
        'omDate: $omDate, '
        'recommendingOffice: $recommendingOffice, '
        'letterNumber: $letterNumber, '
        'letterDate: $letterDate, '
        'divisionName: $divisionName, '
        'divisionCode: $divisionCode, '
        'employeeName: $employeeName, '
        'employeeDesignation: $employeeDesignation, '
        'purpose: $purpose, '
        'amount: $amount'
        ')';
  }

  // ---------------------------------------------------------------------------
  // EQUALITY
  // ---------------------------------------------------------------------------
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
        other.purpose == purpose &&
        other.amount == amount;
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
        purpose.hashCode ^
        amount.hashCode;
  }
}
