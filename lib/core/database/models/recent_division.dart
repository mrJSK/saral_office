import 'package:isar/isar.dart';

part 'recent_division.g.dart';

@collection
class RecentDivision {
  Id id = Isar.autoIncrement;

  late String fundsCenter; // key
  late String name;

  DateTime lastUsedAt = DateTime.now();
}
