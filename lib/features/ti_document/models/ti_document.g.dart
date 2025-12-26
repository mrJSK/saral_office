// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ti_document.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTIDocumentCollection on Isar {
  IsarCollection<TIDocument> get tIDocuments => this.collection();
}

const TIDocumentSchema = CollectionSchema(
  name: r'TIDocument',
  id: 5414531582560378530,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'divisionName': PropertySchema(
      id: 2,
      name: r'divisionName',
      type: IsarType.string,
    ),
    r'employeeDesignation': PropertySchema(
      id: 3,
      name: r'employeeDesignation',
      type: IsarType.string,
    ),
    r'employeeName': PropertySchema(
      id: 4,
      name: r'employeeName',
      type: IsarType.string,
    ),
    r'employeeSapId': PropertySchema(
      id: 5,
      name: r'employeeSapId',
      type: IsarType.string,
    ),
    r'fullJsonData': PropertySchema(
      id: 6,
      name: r'fullJsonData',
      type: IsarType.string,
    ),
    r'fundsCenter': PropertySchema(
      id: 7,
      name: r'fundsCenter',
      type: IsarType.string,
    ),
    r'letterDate': PropertySchema(
      id: 8,
      name: r'letterDate',
      type: IsarType.dateTime,
    ),
    r'letterNumber': PropertySchema(
      id: 9,
      name: r'letterNumber',
      type: IsarType.string,
    ),
    r'omDate': PropertySchema(
      id: 10,
      name: r'omDate',
      type: IsarType.dateTime,
    ),
    r'omNumber': PropertySchema(
      id: 11,
      name: r'omNumber',
      type: IsarType.string,
    ),
    r'pdfPath': PropertySchema(
      id: 12,
      name: r'pdfPath',
      type: IsarType.string,
    ),
    r'recommendingOffice': PropertySchema(
      id: 13,
      name: r'recommendingOffice',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 14,
      name: r'status',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 15,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _tIDocumentEstimateSize,
  serialize: _tIDocumentSerialize,
  deserialize: _tIDocumentDeserialize,
  deserializeProp: _tIDocumentDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _tIDocumentGetId,
  getLinks: _tIDocumentGetLinks,
  attach: _tIDocumentAttach,
  version: '3.1.0+1',
);

int _tIDocumentEstimateSize(
  TIDocument object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.divisionName.length * 3;
  bytesCount += 3 + object.employeeDesignation.length * 3;
  bytesCount += 3 + object.employeeName.length * 3;
  bytesCount += 3 + object.employeeSapId.length * 3;
  {
    final value = object.fullJsonData;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fundsCenter.length * 3;
  bytesCount += 3 + object.letterNumber.length * 3;
  bytesCount += 3 + object.omNumber.length * 3;
  {
    final value = object.pdfPath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.recommendingOffice.length * 3;
  bytesCount += 3 + object.status.length * 3;
  return bytesCount;
}

void _tIDocumentSerialize(
  TIDocument object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeString(offsets[2], object.divisionName);
  writer.writeString(offsets[3], object.employeeDesignation);
  writer.writeString(offsets[4], object.employeeName);
  writer.writeString(offsets[5], object.employeeSapId);
  writer.writeString(offsets[6], object.fullJsonData);
  writer.writeString(offsets[7], object.fundsCenter);
  writer.writeDateTime(offsets[8], object.letterDate);
  writer.writeString(offsets[9], object.letterNumber);
  writer.writeDateTime(offsets[10], object.omDate);
  writer.writeString(offsets[11], object.omNumber);
  writer.writeString(offsets[12], object.pdfPath);
  writer.writeString(offsets[13], object.recommendingOffice);
  writer.writeString(offsets[14], object.status);
  writer.writeDateTime(offsets[15], object.updatedAt);
}

TIDocument _tIDocumentDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TIDocument();
  object.amount = reader.readDouble(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.divisionName = reader.readString(offsets[2]);
  object.employeeDesignation = reader.readString(offsets[3]);
  object.employeeName = reader.readString(offsets[4]);
  object.employeeSapId = reader.readString(offsets[5]);
  object.fullJsonData = reader.readStringOrNull(offsets[6]);
  object.fundsCenter = reader.readString(offsets[7]);
  object.id = id;
  object.letterDate = reader.readDateTime(offsets[8]);
  object.letterNumber = reader.readString(offsets[9]);
  object.omDate = reader.readDateTime(offsets[10]);
  object.omNumber = reader.readString(offsets[11]);
  object.pdfPath = reader.readStringOrNull(offsets[12]);
  object.recommendingOffice = reader.readString(offsets[13]);
  object.status = reader.readString(offsets[14]);
  object.updatedAt = reader.readDateTime(offsets[15]);
  return object;
}

P _tIDocumentDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readDateTime(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    case 15:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tIDocumentGetId(TIDocument object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tIDocumentGetLinks(TIDocument object) {
  return [];
}

void _tIDocumentAttach(IsarCollection<dynamic> col, Id id, TIDocument object) {
  object.id = id;
}

extension TIDocumentQueryWhereSort
    on QueryBuilder<TIDocument, TIDocument, QWhere> {
  QueryBuilder<TIDocument, TIDocument, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TIDocumentQueryWhere
    on QueryBuilder<TIDocument, TIDocument, QWhereClause> {
  QueryBuilder<TIDocument, TIDocument, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TIDocumentQueryFilter
    on QueryBuilder<TIDocument, TIDocument, QFilterCondition> {
  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> amountEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> amountGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> amountLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> amountBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divisionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'divisionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'divisionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'divisionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'divisionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'divisionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'divisionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'divisionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divisionName',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      divisionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'divisionName',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeDesignation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeDesignation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeDesignation',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeDesignationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeDesignation',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeName',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeName',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeSapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeSapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeSapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeSapId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeSapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeSapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeSapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeSapId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeSapId',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      employeeSapIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeSapId',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fullJsonData',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fullJsonData',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullJsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullJsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullJsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullJsonData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullJsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullJsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullJsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullJsonData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullJsonData',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fullJsonDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullJsonData',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fundsCenter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fundsCenter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fundsCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      fundsCenterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fundsCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> letterDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'letterDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'letterDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> letterDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'letterDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'letterNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'letterNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'letterNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'letterNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'letterNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'letterNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'letterNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      letterNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'letterNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omDateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'omDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'omDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'omDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'omDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'omNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      omNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'omNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'omNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'omNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      omNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'omNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'omNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'omNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> omNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'omNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      omNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'omNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      omNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'omNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pdfPath',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      pdfPathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pdfPath',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      pdfPathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pdfPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pdfPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pdfPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> pdfPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdfPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      pdfPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pdfPath',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recommendingOffice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recommendingOffice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recommendingOffice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recommendingOffice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'recommendingOffice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'recommendingOffice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'recommendingOffice',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'recommendingOffice',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recommendingOffice',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      recommendingOfficeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'recommendingOffice',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TIDocumentQueryObject
    on QueryBuilder<TIDocument, TIDocument, QFilterCondition> {}

extension TIDocumentQueryLinks
    on QueryBuilder<TIDocument, TIDocument, QFilterCondition> {}

extension TIDocumentQuerySortBy
    on QueryBuilder<TIDocument, TIDocument, QSortBy> {
  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByDivisionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByDivisionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      sortByEmployeeDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeDesignation', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      sortByEmployeeDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeDesignation', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByEmployeeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByEmployeeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByEmployeeSapId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeSapId', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByEmployeeSapIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeSapId', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByFullJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByFullJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByFundsCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByFundsCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByLetterDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterDate', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByLetterDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterDate', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByLetterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterNumber', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByLetterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterNumber', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByOmDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omDate', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByOmDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omDate', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByOmNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omNumber', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByOmNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omNumber', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByPdfPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByPdfPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      sortByRecommendingOffice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendingOffice', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      sortByRecommendingOfficeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendingOffice', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension TIDocumentQuerySortThenBy
    on QueryBuilder<TIDocument, TIDocument, QSortThenBy> {
  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByDivisionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByDivisionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      thenByEmployeeDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeDesignation', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      thenByEmployeeDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeDesignation', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByEmployeeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByEmployeeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByEmployeeSapId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeSapId', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByEmployeeSapIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeSapId', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByFullJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByFullJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByFundsCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByFundsCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByLetterDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterDate', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByLetterDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterDate', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByLetterNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterNumber', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByLetterNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterNumber', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByOmDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omDate', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByOmDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omDate', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByOmNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omNumber', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByOmNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'omNumber', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByPdfPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByPdfPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfPath', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      thenByRecommendingOffice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendingOffice', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy>
      thenByRecommendingOfficeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recommendingOffice', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension TIDocumentQueryWhereDistinct
    on QueryBuilder<TIDocument, TIDocument, QDistinct> {
  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByDivisionName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'divisionName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByEmployeeDesignation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeDesignation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByEmployeeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByEmployeeSapId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeSapId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByFullJsonData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullJsonData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByFundsCenter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fundsCenter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByLetterDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'letterDate');
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByLetterNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'letterNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByOmDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'omDate');
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByOmNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'omNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByPdfPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdfPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByRecommendingOffice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recommendingOffice',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TIDocument, TIDocument, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension TIDocumentQueryProperty
    on QueryBuilder<TIDocument, TIDocument, QQueryProperty> {
  QueryBuilder<TIDocument, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TIDocument, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<TIDocument, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations> divisionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'divisionName');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations>
      employeeDesignationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeDesignation');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations> employeeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeName');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations> employeeSapIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeSapId');
    });
  }

  QueryBuilder<TIDocument, String?, QQueryOperations> fullJsonDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullJsonData');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations> fundsCenterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fundsCenter');
    });
  }

  QueryBuilder<TIDocument, DateTime, QQueryOperations> letterDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letterDate');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations> letterNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letterNumber');
    });
  }

  QueryBuilder<TIDocument, DateTime, QQueryOperations> omDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'omDate');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations> omNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'omNumber');
    });
  }

  QueryBuilder<TIDocument, String?, QQueryOperations> pdfPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdfPath');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations>
      recommendingOfficeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recommendingOffice');
    });
  }

  QueryBuilder<TIDocument, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<TIDocument, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
