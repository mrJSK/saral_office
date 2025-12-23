// lib/core/database/models/gl_account.dart

import 'package:isar/isar.dart';

part 'gl_account.g.dart';

@collection
class GLAccount {
  Id id = Isar.autoIncrement;

  @Index()
  late String glCode;

  late String glDescription;

  String? agCode;
  String? agDescription;
  String? mainAccountCode;
  String? mainAccountDescription;

  String get displayText => '$glCode - $glDescription';

  String get pdfText => '$glCode\n$glDescription';
}
