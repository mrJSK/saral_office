// lib/core/database/models/recent_service.dart

import 'package:isar/isar.dart';

part 'recent_service.g.dart';

@collection
class RecentService {
  Id id = Isar.autoIncrement;

  late String activityNumber;
  late String serviceShortText;
  late DateTime lastUsedAt;
}
