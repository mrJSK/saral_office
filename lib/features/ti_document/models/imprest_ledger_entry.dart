// lib/features/ti_document/models/imprest_ledger_entry.dart
import 'dart:convert';

class ImprestLedgerEntry {
  final String date; // e.g. 26/12/2025
  final String vrNo; // voucher no
  final String transaction;
  final double payment; // amount payable
  final double total; // running total (optional if you want)
  final String head; // Head/GL code

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

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'vrNo': vrNo,
      'transaction': transaction,
      'payment': payment,
      'total': total,
      'head': head,
    };
  }

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
}
