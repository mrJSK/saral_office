// lib/core/database/models/vendor.dart
import 'package:isar/isar.dart';

part 'vendor.g.dart';

@collection
class Vendor {
  Id id = Isar.autoIncrement;

  @Index()
  late String vendorCode;

  late String name1;
  String? name2;
  String? street1;
  String? street2;
  String? street3;
  String? street4;
  late String city;
  String? district;
  late String postalCode;
  String? region;
  String? pan;
  String? gst;

  // NEW FIELDS
  String? ifsc;
  String? bankAccount;
  String? email;

  String get fullName =>
      name2 != null && name2!.isNotEmpty ? '$name1 $name2' : name1;

  String get fullAddress {
    List<String> parts = [
      if (street1 != null && street1!.isNotEmpty) street1!,
      city,
      postalCode,
    ];
    return parts.join(', ');
  }
}
