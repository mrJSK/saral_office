import 'package:isar/isar.dart';

part 'employee.g.dart';

@collection
class Employee {
  Id id = Isar.autoIncrement;

  late String employeeName;
  late String designation;
  late String sapId;

  // NEW FIELDS
  late String office;
  late String officeHead;
  late String officeHeadDesignation;

  late DateTime createdAt;
  late DateTime updatedAt;

  @ignore
  String get displayText => '$employeeName ($designation)';
}
