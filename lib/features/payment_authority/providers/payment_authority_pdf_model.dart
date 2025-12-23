// lib/features/payment_authority/services/payment_authority_pdf_model.dart

class AuthorityLine {
  final String description;
  final String glCode; // Numerical Head / GL code
  final double amount;

  AuthorityLine({
    required this.description,
    required this.glCode,
    required this.amount,
  });
}

class PaymentAuthorityPdfModel {
  final String divisionName;
  final String divisionCode;
  final DateTime date;
  final String payeeName;
  final String payeeAddress;
  final String paymentParticulars;
  final String authorityOrderNo;
  final DateTime authorityOrderDate;
  final String billNo;
  final DateTime billDate;
  final double netAmount;
  final List<AuthorityLine> debitLines;
  final List<AuthorityLine> creditLines;

  PaymentAuthorityPdfModel({
    required this.divisionName,
    required this.divisionCode,
    required this.date,
    required this.payeeName,
    required this.payeeAddress,
    required this.paymentParticulars,
    required this.authorityOrderNo,
    required this.authorityOrderDate,
    required this.billNo,
    required this.billDate,
    required this.netAmount,
    required this.debitLines,
    required this.creditLines,
  });
}
