import 'package:isar/isar.dart';

part 'division.g.dart';

@collection
class Division {
  Id id = Isar.autoIncrement;

  @Index()
  late String fundsCenter;

  late String name;

  String? personResponsible;
  DateTime? validFrom;
  DateTime? validTo;

  String get displayText => '$name ($fundsCenter)';
}
