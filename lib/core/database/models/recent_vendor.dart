// lib/core/database/models/recent_vendor.dart
import 'package:isar/isar.dart';

part 'recent_vendor.g.dart';

@collection
class RecentVendor {
  Id id = Isar.autoIncrement;

  late String vendorCode;
  late String name1;
  DateTime? lastUsedAt;
}
