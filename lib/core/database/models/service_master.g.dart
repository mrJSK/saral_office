// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_master.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetServiceMasterCollection on Isar {
  IsarCollection<ServiceMaster> get serviceMasters => this.collection();
}

const ServiceMasterSchema = CollectionSchema(
  name: r'ServiceMaster',
  id: -2837145407003465046,
  properties: {
    r'activityNumber': PropertySchema(
      id: 0,
      name: r'activityNumber',
      type: IsarType.string,
    ),
    r'baseUnit': PropertySchema(
      id: 1,
      name: r'baseUnit',
      type: IsarType.string,
    ),
    r'deletionIndicator': PropertySchema(
      id: 2,
      name: r'deletionIndicator',
      type: IsarType.string,
    ),
    r'displayText': PropertySchema(
      id: 3,
      name: r'displayText',
      type: IsarType.string,
    ),
    r'fullText': PropertySchema(
      id: 4,
      name: r'fullText',
      type: IsarType.string,
    ),
    r'glAccount': PropertySchema(
      id: 5,
      name: r'glAccount',
      type: IsarType.string,
    ),
    r'materialGroup': PropertySchema(
      id: 6,
      name: r'materialGroup',
      type: IsarType.string,
    ),
    r'materialGroupDesc': PropertySchema(
      id: 7,
      name: r'materialGroupDesc',
      type: IsarType.string,
    ),
    r'pdfText': PropertySchema(id: 8, name: r'pdfText', type: IsarType.string),
    r'serviceCategory': PropertySchema(
      id: 9,
      name: r'serviceCategory',
      type: IsarType.string,
    ),
    r'serviceCategoryDesc': PropertySchema(
      id: 10,
      name: r'serviceCategoryDesc',
      type: IsarType.string,
    ),
    r'serviceLongText': PropertySchema(
      id: 11,
      name: r'serviceLongText',
      type: IsarType.string,
    ),
    r'serviceShortText': PropertySchema(
      id: 12,
      name: r'serviceShortText',
      type: IsarType.string,
    ),
    r'valuationClass': PropertySchema(
      id: 13,
      name: r'valuationClass',
      type: IsarType.string,
    ),
    r'valuationClassDesc': PropertySchema(
      id: 14,
      name: r'valuationClassDesc',
      type: IsarType.string,
    ),
  },
  estimateSize: _serviceMasterEstimateSize,
  serialize: _serviceMasterSerialize,
  deserialize: _serviceMasterDeserialize,
  deserializeProp: _serviceMasterDeserializeProp,
  idName: r'id',
  indexes: {
    r'activityNumber': IndexSchema(
      id: -1939563535944674884,
      name: r'activityNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'activityNumber',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _serviceMasterGetId,
  getLinks: _serviceMasterGetLinks,
  attach: _serviceMasterAttach,
  version: '3.1.0+1',
);

int _serviceMasterEstimateSize(
  ServiceMaster object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activityNumber.length * 3;
  bytesCount += 3 + object.baseUnit.length * 3;
  {
    final value = object.deletionIndicator;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.displayText.length * 3;
  bytesCount += 3 + object.fullText.length * 3;
  {
    final value = object.glAccount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.materialGroup.length * 3;
  bytesCount += 3 + object.materialGroupDesc.length * 3;
  bytesCount += 3 + object.pdfText.length * 3;
  bytesCount += 3 + object.serviceCategory.length * 3;
  bytesCount += 3 + object.serviceCategoryDesc.length * 3;
  bytesCount += 3 + object.serviceLongText.length * 3;
  bytesCount += 3 + object.serviceShortText.length * 3;
  {
    final value = object.valuationClass;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.valuationClassDesc;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _serviceMasterSerialize(
  ServiceMaster object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityNumber);
  writer.writeString(offsets[1], object.baseUnit);
  writer.writeString(offsets[2], object.deletionIndicator);
  writer.writeString(offsets[3], object.displayText);
  writer.writeString(offsets[4], object.fullText);
  writer.writeString(offsets[5], object.glAccount);
  writer.writeString(offsets[6], object.materialGroup);
  writer.writeString(offsets[7], object.materialGroupDesc);
  writer.writeString(offsets[8], object.pdfText);
  writer.writeString(offsets[9], object.serviceCategory);
  writer.writeString(offsets[10], object.serviceCategoryDesc);
  writer.writeString(offsets[11], object.serviceLongText);
  writer.writeString(offsets[12], object.serviceShortText);
  writer.writeString(offsets[13], object.valuationClass);
  writer.writeString(offsets[14], object.valuationClassDesc);
}

ServiceMaster _serviceMasterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServiceMaster();
  object.activityNumber = reader.readString(offsets[0]);
  object.baseUnit = reader.readString(offsets[1]);
  object.deletionIndicator = reader.readStringOrNull(offsets[2]);
  object.glAccount = reader.readStringOrNull(offsets[5]);
  object.id = id;
  object.materialGroup = reader.readString(offsets[6]);
  object.materialGroupDesc = reader.readString(offsets[7]);
  object.serviceCategory = reader.readString(offsets[9]);
  object.serviceCategoryDesc = reader.readString(offsets[10]);
  object.serviceLongText = reader.readString(offsets[11]);
  object.serviceShortText = reader.readString(offsets[12]);
  object.valuationClass = reader.readStringOrNull(offsets[13]);
  object.valuationClassDesc = reader.readStringOrNull(offsets[14]);
  return object;
}

P _serviceMasterDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _serviceMasterGetId(ServiceMaster object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _serviceMasterGetLinks(ServiceMaster object) {
  return [];
}

void _serviceMasterAttach(
  IsarCollection<dynamic> col,
  Id id,
  ServiceMaster object,
) {
  object.id = id;
}

extension ServiceMasterQueryWhereSort
    on QueryBuilder<ServiceMaster, ServiceMaster, QWhere> {
  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ServiceMasterQueryWhere
    on QueryBuilder<ServiceMaster, ServiceMaster, QWhereClause> {
  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
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

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhereClause>
  activityNumberEqualTo(String activityNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(
          indexName: r'activityNumber',
          value: [activityNumber],
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterWhereClause>
  activityNumberNotEqualTo(String activityNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityNumber',
                lower: [],
                upper: [activityNumber],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityNumber',
                lower: [activityNumber],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityNumber',
                lower: [activityNumber],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'activityNumber',
                lower: [],
                upper: [activityNumber],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension ServiceMasterQueryFilter
    on QueryBuilder<ServiceMaster, ServiceMaster, QFilterCondition> {
  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'activityNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'activityNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'activityNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'activityNumber',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'activityNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'activityNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'activityNumber',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'activityNumber',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'activityNumber', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  activityNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'activityNumber', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'baseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'baseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'baseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'baseUnit',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'baseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'baseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'baseUnit',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'baseUnit',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'baseUnit', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  baseUnitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'baseUnit', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'deletionIndicator'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'deletionIndicator'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'deletionIndicator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'deletionIndicator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'deletionIndicator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'deletionIndicator',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'deletionIndicator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'deletionIndicator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'deletionIndicator',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'deletionIndicator',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'deletionIndicator', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  deletionIndicatorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'deletionIndicator', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'displayText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'displayText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'displayText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'displayText',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'displayText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'displayText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'displayText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'displayText',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'displayText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  displayTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'displayText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'fullText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'fullText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'fullText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'fullText',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'fullText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'fullText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'fullText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'fullText',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fullText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  fullTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fullText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'glAccount'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'glAccount'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'glAccount',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'glAccount',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'glAccount',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'glAccount',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'glAccount',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'glAccount',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'glAccount',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'glAccount',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'glAccount', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  glAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'glAccount', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'materialGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'materialGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'materialGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'materialGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'materialGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'materialGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'materialGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'materialGroup',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'materialGroup', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'materialGroup', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'materialGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'materialGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'materialGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'materialGroupDesc',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'materialGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'materialGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'materialGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'materialGroupDesc',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'materialGroupDesc', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  materialGroupDescIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'materialGroupDesc', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'pdfText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'pdfText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'pdfText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'pdfText',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'pdfText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'pdfText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'pdfText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'pdfText',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pdfText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  pdfTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pdfText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serviceCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serviceCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serviceCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serviceCategory',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serviceCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serviceCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serviceCategory',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serviceCategory',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serviceCategory', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'serviceCategory', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serviceCategoryDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serviceCategoryDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serviceCategoryDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serviceCategoryDesc',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serviceCategoryDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serviceCategoryDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serviceCategoryDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serviceCategoryDesc',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serviceCategoryDesc', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceCategoryDescIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'serviceCategoryDesc',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serviceLongText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serviceLongText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serviceLongText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serviceLongText',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serviceLongText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serviceLongText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serviceLongText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serviceLongText',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serviceLongText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceLongTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'serviceLongText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serviceShortText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serviceShortText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serviceShortText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serviceShortText',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serviceShortText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serviceShortText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serviceShortText',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serviceShortText',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serviceShortText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  serviceShortTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'serviceShortText', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valuationClass'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valuationClass'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valuationClass',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valuationClass',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valuationClass',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valuationClass',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'valuationClass',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'valuationClass',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'valuationClass',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'valuationClass',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'valuationClass', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'valuationClass', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'valuationClassDesc'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'valuationClassDesc'),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'valuationClassDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'valuationClassDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'valuationClassDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'valuationClassDesc',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'valuationClassDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'valuationClassDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'valuationClassDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'valuationClassDesc',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'valuationClassDesc', value: ''),
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterFilterCondition>
  valuationClassDescIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'valuationClassDesc', value: ''),
      );
    });
  }
}

extension ServiceMasterQueryObject
    on QueryBuilder<ServiceMaster, ServiceMaster, QFilterCondition> {}

extension ServiceMasterQueryLinks
    on QueryBuilder<ServiceMaster, ServiceMaster, QFilterCondition> {}

extension ServiceMasterQuerySortBy
    on QueryBuilder<ServiceMaster, ServiceMaster, QSortBy> {
  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByActivityNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByActivityNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> sortByBaseUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnit', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByBaseUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnit', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByDeletionIndicator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletionIndicator', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByDeletionIndicatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletionIndicator', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> sortByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> sortByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> sortByGlAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByGlAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByMaterialGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByMaterialGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByMaterialGroupDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroupDesc', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> sortByPdfText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> sortByPdfTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByServiceCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceCategory', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByServiceCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceCategory', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByServiceCategoryDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceCategoryDesc', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByServiceLongText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceLongText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByServiceLongTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceLongText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByServiceShortText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByServiceShortTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByValuationClass() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationClass', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByValuationClassDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationClass', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  sortByValuationClassDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationClassDesc', Sort.desc);
    });
  }
}

extension ServiceMasterQuerySortThenBy
    on QueryBuilder<ServiceMaster, ServiceMaster, QSortThenBy> {
  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByActivityNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByActivityNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenByBaseUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnit', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByBaseUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnit', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByDeletionIndicator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletionIndicator', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByDeletionIndicatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deletionIndicator', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenByGlAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByGlAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByMaterialGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByMaterialGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByMaterialGroupDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroupDesc', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenByPdfText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy> thenByPdfTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByServiceCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceCategory', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByServiceCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceCategory', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByServiceCategoryDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceCategoryDesc', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByServiceLongText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceLongText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByServiceLongTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceLongText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByServiceShortText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByServiceShortTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByValuationClass() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationClass', Sort.asc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByValuationClassDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationClass', Sort.desc);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QAfterSortBy>
  thenByValuationClassDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationClassDesc', Sort.desc);
    });
  }
}

extension ServiceMasterQueryWhereDistinct
    on QueryBuilder<ServiceMaster, ServiceMaster, QDistinct> {
  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByActivityNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'activityNumber',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct> distinctByBaseUnit({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'baseUnit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByDeletionIndicator({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'deletionIndicator',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct> distinctByDisplayText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct> distinctByFullText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct> distinctByGlAccount({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glAccount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByMaterialGroup({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'materialGroup',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByMaterialGroupDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'materialGroupDesc',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct> distinctByPdfText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdfText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByServiceCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'serviceCategory',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByServiceCategoryDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'serviceCategoryDesc',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByServiceLongText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'serviceLongText',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByServiceShortText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'serviceShortText',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByValuationClass({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'valuationClass',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ServiceMaster, ServiceMaster, QDistinct>
  distinctByValuationClassDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'valuationClassDesc',
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension ServiceMasterQueryProperty
    on QueryBuilder<ServiceMaster, ServiceMaster, QQueryProperty> {
  QueryBuilder<ServiceMaster, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations>
  activityNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityNumber');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations> baseUnitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'baseUnit');
    });
  }

  QueryBuilder<ServiceMaster, String?, QQueryOperations>
  deletionIndicatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deletionIndicator');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations> displayTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayText');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations> fullTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullText');
    });
  }

  QueryBuilder<ServiceMaster, String?, QQueryOperations> glAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glAccount');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations>
  materialGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialGroup');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations>
  materialGroupDescProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialGroupDesc');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations> pdfTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdfText');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations>
  serviceCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceCategory');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations>
  serviceCategoryDescProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceCategoryDesc');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations>
  serviceLongTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceLongText');
    });
  }

  QueryBuilder<ServiceMaster, String, QQueryOperations>
  serviceShortTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceShortText');
    });
  }

  QueryBuilder<ServiceMaster, String?, QQueryOperations>
  valuationClassProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valuationClass');
    });
  }

  QueryBuilder<ServiceMaster, String?, QQueryOperations>
  valuationClassDescProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valuationClassDesc');
    });
  }
}
