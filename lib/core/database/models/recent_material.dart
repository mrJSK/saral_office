// lib/core/database/models/recent_material.dart

import 'package:isar/isar.dart';

part 'recent_material.g.dart';

@collection
class RecentMaterial {
  Id id = Isar.autoIncrement;

  late String material;
  late String materialDesc;
  late DateTime lastUsedAt;
}
