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

  // Amount for the advance
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
    required this.amount,
  });
}
