// lib/core/database/models/recent_gl.dart
import 'package:isar/isar.dart';

part 'recent_gl.g.dart';

@collection
class RecentGL {
  Id id = Isar.autoIncrement;

  late String glCode;
  late String glDescription;
  late DateTime lastUsedAt;
}
