// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_master.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMaterialMasterCollection on Isar {
  IsarCollection<MaterialMaster> get materialMasters => this.collection();
}

const MaterialMasterSchema = CollectionSchema(
  name: r'MaterialMaster',
  id: 3827124068530720128,
  properties: {
    r'baseUnitOfMeasure': PropertySchema(
      id: 0,
      name: r'baseUnitOfMeasure',
      type: IsarType.string,
    ),
    r'displayText': PropertySchema(
      id: 1,
      name: r'displayText',
      type: IsarType.string,
    ),
    r'fullText': PropertySchema(
      id: 2,
      name: r'fullText',
      type: IsarType.string,
    ),
    r'material': PropertySchema(
      id: 3,
      name: r'material',
      type: IsarType.string,
    ),
    r'materialDesc': PropertySchema(
      id: 4,
      name: r'materialDesc',
      type: IsarType.string,
    ),
    r'materialGroup': PropertySchema(
      id: 5,
      name: r'materialGroup',
      type: IsarType.string,
    ),
    r'materialGroupDesc': PropertySchema(
      id: 6,
      name: r'materialGroupDesc',
      type: IsarType.string,
    ),
    r'materialType': PropertySchema(
      id: 7,
      name: r'materialType',
      type: IsarType.string,
    ),
    r'pdfText': PropertySchema(id: 8, name: r'pdfText', type: IsarType.string),
    r'plant': PropertySchema(id: 9, name: r'plant', type: IsarType.string),
    r'serialNumberStatus': PropertySchema(
      id: 10,
      name: r'serialNumberStatus',
      type: IsarType.string,
    ),
    r'splitValuationStatus': PropertySchema(
      id: 11,
      name: r'splitValuationStatus',
      type: IsarType.string,
    ),
    r'subGroup': PropertySchema(
      id: 12,
      name: r'subGroup',
      type: IsarType.string,
    ),
    r'subGroupDesc': PropertySchema(
      id: 13,
      name: r'subGroupDesc',
      type: IsarType.string,
    ),
  },
  estimateSize: _materialMasterEstimateSize,
  serialize: _materialMasterSerialize,
  deserialize: _materialMasterDeserialize,
  deserializeProp: _materialMasterDeserializeProp,
  idName: r'id',
  indexes: {
    r'material': IndexSchema(
      id: -5372905036179028125,
      name: r'material',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'material',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {},
  embeddedSchemas: {},
  getId: _materialMasterGetId,
  getLinks: _materialMasterGetLinks,
  attach: _materialMasterAttach,
  version: '3.1.0+1',
);

int _materialMasterEstimateSize(
  MaterialMaster object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.baseUnitOfMeasure.length * 3;
  bytesCount += 3 + object.displayText.length * 3;
  bytesCount += 3 + object.fullText.length * 3;
  bytesCount += 3 + object.material.length * 3;
  bytesCount += 3 + object.materialDesc.length * 3;
  bytesCount += 3 + object.materialGroup.length * 3;
  bytesCount += 3 + object.materialGroupDesc.length * 3;
  bytesCount += 3 + object.materialType.length * 3;
  bytesCount += 3 + object.pdfText.length * 3;
  bytesCount += 3 + object.plant.length * 3;
  bytesCount += 3 + object.serialNumberStatus.length * 3;
  bytesCount += 3 + object.splitValuationStatus.length * 3;
  bytesCount += 3 + object.subGroup.length * 3;
  bytesCount += 3 + object.subGroupDesc.length * 3;
  return bytesCount;
}

void _materialMasterSerialize(
  MaterialMaster object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.baseUnitOfMeasure);
  writer.writeString(offsets[1], object.displayText);
  writer.writeString(offsets[2], object.fullText);
  writer.writeString(offsets[3], object.material);
  writer.writeString(offsets[4], object.materialDesc);
  writer.writeString(offsets[5], object.materialGroup);
  writer.writeString(offsets[6], object.materialGroupDesc);
  writer.writeString(offsets[7], object.materialType);
  writer.writeString(offsets[8], object.pdfText);
  writer.writeString(offsets[9], object.plant);
  writer.writeString(offsets[10], object.serialNumberStatus);
  writer.writeString(offsets[11], object.splitValuationStatus);
  writer.writeString(offsets[12], object.subGroup);
  writer.writeString(offsets[13], object.subGroupDesc);
}

MaterialMaster _materialMasterDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MaterialMaster();
  object.baseUnitOfMeasure = reader.readString(offsets[0]);
  object.id = id;
  object.material = reader.readString(offsets[3]);
  object.materialDesc = reader.readString(offsets[4]);
  object.materialGroup = reader.readString(offsets[5]);
  object.materialGroupDesc = reader.readString(offsets[6]);
  object.materialType = reader.readString(offsets[7]);
  object.plant = reader.readString(offsets[9]);
  object.serialNumberStatus = reader.readString(offsets[10]);
  object.splitValuationStatus = reader.readString(offsets[11]);
  object.subGroup = reader.readString(offsets[12]);
  object.subGroupDesc = reader.readString(offsets[13]);
  return object;
}

P _materialMasterDeserializeProp<P>(
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
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
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
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _materialMasterGetId(MaterialMaster object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _materialMasterGetLinks(MaterialMaster object) {
  return [];
}

void _materialMasterAttach(
  IsarCollection<dynamic> col,
  Id id,
  MaterialMaster object,
) {
  object.id = id;
}

extension MaterialMasterQueryWhereSort
    on QueryBuilder<MaterialMaster, MaterialMaster, QWhere> {
  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MaterialMasterQueryWhere
    on QueryBuilder<MaterialMaster, MaterialMaster, QWhereClause> {
  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhereClause> idBetween(
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhereClause>
  materialEqualTo(String material) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'material', value: [material]),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterWhereClause>
  materialNotEqualTo(String material) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'material',
                lower: [],
                upper: [material],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'material',
                lower: [material],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'material',
                lower: [material],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'material',
                lower: [],
                upper: [material],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension MaterialMasterQueryFilter
    on QueryBuilder<MaterialMaster, MaterialMaster, QFilterCondition> {
  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'baseUnitOfMeasure',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'baseUnitOfMeasure',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'baseUnitOfMeasure',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'baseUnitOfMeasure',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'baseUnitOfMeasure',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'baseUnitOfMeasure',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'baseUnitOfMeasure',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'baseUnitOfMeasure',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'baseUnitOfMeasure', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  baseUnitOfMeasureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'baseUnitOfMeasure', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  displayTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'displayText', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  displayTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'displayText', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  fullTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'fullText', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  fullTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'fullText', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  idLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition> idBetween(
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'material',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'material',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'material',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'material',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'material',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'material',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'material',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'material',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'material', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'material', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'materialDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'materialDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'materialDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'materialDesc',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'materialDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'materialDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'materialDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'materialDesc',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'materialDesc', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialDescIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'materialDesc', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'materialGroup', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'materialGroup', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialGroupDescIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'materialGroupDesc', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialGroupDescIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'materialGroupDesc', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'materialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'materialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'materialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'materialType',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'materialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'materialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'materialType',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'materialType',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'materialType', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  materialTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'materialType', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
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

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  pdfTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'pdfText', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  pdfTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'pdfText', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'plant',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'plant',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'plant',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'plant',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'plant',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'plant',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'plant',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'plant',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'plant', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  plantIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'plant', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'serialNumberStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'serialNumberStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'serialNumberStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'serialNumberStatus',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'serialNumberStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'serialNumberStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'serialNumberStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'serialNumberStatus',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'serialNumberStatus', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  serialNumberStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'serialNumberStatus', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'splitValuationStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'splitValuationStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'splitValuationStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'splitValuationStatus',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'splitValuationStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'splitValuationStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'splitValuationStatus',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'splitValuationStatus',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'splitValuationStatus', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  splitValuationStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          property: r'splitValuationStatus',
          value: '',
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subGroup',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'subGroup',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'subGroup',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subGroup', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'subGroup', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'subGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'subGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'subGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'subGroupDesc',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'subGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'subGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'subGroupDesc',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'subGroupDesc',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'subGroupDesc', value: ''),
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterFilterCondition>
  subGroupDescIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'subGroupDesc', value: ''),
      );
    });
  }
}

extension MaterialMasterQueryObject
    on QueryBuilder<MaterialMaster, MaterialMaster, QFilterCondition> {}

extension MaterialMasterQueryLinks
    on QueryBuilder<MaterialMaster, MaterialMaster, QFilterCondition> {}

extension MaterialMasterQuerySortBy
    on QueryBuilder<MaterialMaster, MaterialMaster, QSortBy> {
  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByBaseUnitOfMeasure() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnitOfMeasure', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByBaseUnitOfMeasureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnitOfMeasure', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> sortByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> sortByMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByMaterialDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialDesc', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByMaterialGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByMaterialGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByMaterialGroupDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroupDesc', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByMaterialType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByMaterialTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> sortByPdfText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortByPdfTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> sortByPlant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> sortByPlantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortBySerialNumberStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumberStatus', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortBySerialNumberStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumberStatus', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortBySplitValuationStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitValuationStatus', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortBySplitValuationStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitValuationStatus', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> sortBySubGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortBySubGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  sortBySubGroupDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroupDesc', Sort.desc);
    });
  }
}

extension MaterialMasterQuerySortThenBy
    on QueryBuilder<MaterialMaster, MaterialMaster, QSortThenBy> {
  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByBaseUnitOfMeasure() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnitOfMeasure', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByBaseUnitOfMeasureDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'baseUnitOfMeasure', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenByFullText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByFullTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullText', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenByMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByMaterialDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialDesc', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByMaterialGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByMaterialGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByMaterialGroupDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroupDesc', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByMaterialType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByMaterialTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialType', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenByPdfText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenByPdfTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenByPlant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenByPlantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenBySerialNumberStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumberStatus', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenBySerialNumberStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumberStatus', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenBySplitValuationStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitValuationStatus', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenBySplitValuationStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'splitValuationStatus', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy> thenBySubGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.asc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenBySubGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroup', Sort.desc);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QAfterSortBy>
  thenBySubGroupDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subGroupDesc', Sort.desc);
    });
  }
}

extension MaterialMasterQueryWhereDistinct
    on QueryBuilder<MaterialMaster, MaterialMaster, QDistinct> {
  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctByBaseUnitOfMeasure({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'baseUnitOfMeasure',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctByDisplayText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct> distinctByFullText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct> distinctByMaterial({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'material', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctByMaterialDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materialDesc', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctByMaterialGroup({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'materialGroup',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctByMaterialGroupDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'materialGroupDesc',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctByMaterialType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materialType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct> distinctByPdfText({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdfText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct> distinctByPlant({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plant', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctBySerialNumberStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'serialNumberStatus',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctBySplitValuationStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'splitValuationStatus',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct> distinctBySubGroup({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subGroup', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MaterialMaster, MaterialMaster, QDistinct>
  distinctBySubGroupDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subGroupDesc', caseSensitive: caseSensitive);
    });
  }
}

extension MaterialMasterQueryProperty
    on QueryBuilder<MaterialMaster, MaterialMaster, QQueryProperty> {
  QueryBuilder<MaterialMaster, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  baseUnitOfMeasureProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'baseUnitOfMeasure');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations> displayTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayText');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations> fullTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullText');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations> materialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'material');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  materialDescProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialDesc');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  materialGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialGroup');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  materialGroupDescProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialGroupDesc');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  materialTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialType');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations> pdfTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdfText');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations> plantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plant');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  serialNumberStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serialNumberStatus');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  splitValuationStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'splitValuationStatus');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations> subGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subGroup');
    });
  }

  QueryBuilder<MaterialMaster, String, QQueryOperations>
  subGroupDescProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subGroupDesc');
    });
  }
}
