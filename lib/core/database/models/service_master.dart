// lib/core/database/models/service_master.dart

import 'package:isar/isar.dart';

part 'service_master.g.dart';

@collection
class ServiceMaster {
  Id id = Isar.autoIncrement;

  @Index()
  late String activityNumber;

  late String materialGroup;
  late String materialGroupDesc;
  late String baseUnit;
  late String serviceCategory;
  late String serviceCategoryDesc;

  String? valuationClass;
  String? valuationClassDesc;
  String? glAccount;

  late String serviceShortText;
  late String serviceLongText;

  String? deletionIndicator;

  // Computed properties for display
  String get displayText => '$activityNumber - $serviceShortText';
  String get pdfText => '$activityNumber\n$serviceShortText';
  String get fullText =>
      '$activityNumber - $serviceShortText\n$serviceLongText';
}
