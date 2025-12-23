// lib/core/database/models/saved_authority.dart

import 'package:isar/isar.dart';

part 'saved_authority.g.dart';

@collection
class SavedAuthority {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime createdAt;

  late String authorityOrderNo;
  late String vendorName;
  late double amount;
  late String divisionCode;
  late String divisionName;

  // JSON blob for full restoration
  late String fullJsonData;

  // Getter for formatted date
  String get formattedDate {
    return '${createdAt.day.toString().padLeft(2, '0')}/${createdAt.month.toString().padLeft(2, '0')}/${createdAt.year}';
  }
}
