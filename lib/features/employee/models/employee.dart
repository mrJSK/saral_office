import 'package:isar/isar.dart';

part 'employee.g.dart';

@collection
class Employee {
  Id id = Isar.autoIncrement;

  late String employeeName;
  late String designation;
  late String sapId;

  late DateTime createdAt;
  late DateTime updatedAt;

  @ignore
  String get displayText => '$employeeName ($designation)';
}
