// lib/core/database/models/material_master.dart

import 'package:isar/isar.dart';

part 'material_master.g.dart';

@collection
class MaterialMaster {
  Id id = Isar.autoIncrement;

  late String materialType;

  @Index()
  late String material;

  late String baseUnitOfMeasure;
  late String materialDesc;
  late String plant;
  late String materialGroup;
  late String materialGroupDesc;
  late String subGroup;
  late String subGroupDesc;
  late String splitValuationStatus;
  late String serialNumberStatus;

  // Computed properties for display
  String get displayText => '$material - $materialDesc';
  String get pdfText => '$material\n$materialDesc';
  String get fullText =>
      '$material - $materialDesc\nPlant: $plant | Group: $materialGroupDesc';
}
