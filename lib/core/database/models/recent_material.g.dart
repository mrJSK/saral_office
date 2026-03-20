// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_material.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecentMaterialCollection on Isar {
  IsarCollection<RecentMaterial> get recentMaterials => this.collection();
}

const RecentMaterialSchema = CollectionSchema(
  name: r'RecentMaterial',
  id: -5934374242076984485,
  properties: {
    r'lastUsedAt': PropertySchema(
      id: 0,
      name: r'lastUsedAt',
      type: IsarType.dateTime,
    ),
    r'material': PropertySchema(
      id: 1,
      name: r'material',
      type: IsarType.string,
    ),
    r'materialDesc': PropertySchema(
      id: 2,
      name: r'materialDesc',
      type: IsarType.string,
    )
  },
  estimateSize: _recentMaterialEstimateSize,
  serialize: _recentMaterialSerialize,
  deserialize: _recentMaterialDeserialize,
  deserializeProp: _recentMaterialDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recentMaterialGetId,
  getLinks: _recentMaterialGetLinks,
  attach: _recentMaterialAttach,
  version: '3.1.0+1',
);

int _recentMaterialEstimateSize(
  RecentMaterial object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.material.length * 3;
  bytesCount += 3 + object.materialDesc.length * 3;
  return bytesCount;
}

void _recentMaterialSerialize(
  RecentMaterial object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastUsedAt);
  writer.writeString(offsets[1], object.material);
  writer.writeString(offsets[2], object.materialDesc);
}

RecentMaterial _recentMaterialDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentMaterial();
  object.id = id;
  object.lastUsedAt = reader.readDateTime(offsets[0]);
  object.material = reader.readString(offsets[1]);
  object.materialDesc = reader.readString(offsets[2]);
  return object;
}

P _recentMaterialDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recentMaterialGetId(RecentMaterial object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recentMaterialGetLinks(RecentMaterial object) {
  return [];
}

void _recentMaterialAttach(
    IsarCollection<dynamic> col, Id id, RecentMaterial object) {
  object.id = id;
}

extension RecentMaterialQueryWhereSort
    on QueryBuilder<RecentMaterial, RecentMaterial, QWhere> {
  QueryBuilder<RecentMaterial, RecentMaterial, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecentMaterialQueryWhere
    on QueryBuilder<RecentMaterial, RecentMaterial, QWhereClause> {
  QueryBuilder<RecentMaterial, RecentMaterial, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterWhereClause> idBetween(
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

extension RecentMaterialQueryFilter
    on QueryBuilder<RecentMaterial, RecentMaterial, QFilterCondition> {
  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      lastUsedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      lastUsedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      lastUsedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      lastUsedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastUsedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'material',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'material',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'material',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'material',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'material',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'material',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'material',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'material',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'material',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'material',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materialDesc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'materialDesc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'materialDesc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'materialDesc',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'materialDesc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'materialDesc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'materialDesc',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'materialDesc',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materialDesc',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterFilterCondition>
      materialDescIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'materialDesc',
        value: '',
      ));
    });
  }
}

extension RecentMaterialQueryObject
    on QueryBuilder<RecentMaterial, RecentMaterial, QFilterCondition> {}

extension RecentMaterialQueryLinks
    on QueryBuilder<RecentMaterial, RecentMaterial, QFilterCondition> {}

extension RecentMaterialQuerySortBy
    on QueryBuilder<RecentMaterial, RecentMaterial, QSortBy> {
  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      sortByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      sortByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy> sortByMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.asc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      sortByMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.desc);
    });
  }


  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      sortByMaterialDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialDesc', Sort.desc);
    });
  }
}

extension RecentMaterialQuerySortThenBy
    on QueryBuilder<RecentMaterial, RecentMaterial, QSortThenBy> {
  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      thenByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      thenByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy> thenByMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.asc);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      thenByMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.desc);
    });
  }


  QueryBuilder<RecentMaterial, RecentMaterial, QAfterSortBy>
      thenByMaterialDescDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialDesc', Sort.desc);
    });
  }
}

extension RecentMaterialQueryWhereDistinct
    on QueryBuilder<RecentMaterial, RecentMaterial, QDistinct> {
  QueryBuilder<RecentMaterial, RecentMaterial, QDistinct>
      distinctByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QDistinct> distinctByMaterial(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'material', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentMaterial, RecentMaterial, QDistinct>
      distinctByMaterialDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materialDesc', caseSensitive: caseSensitive);
    });
  }
}

extension RecentMaterialQueryProperty
    on QueryBuilder<RecentMaterial, RecentMaterial, QQueryProperty> {
  QueryBuilder<RecentMaterial, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecentMaterial, DateTime, QQueryOperations>
      lastUsedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentMaterial, String, QQueryOperations> materialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'material');
    });
  }

  QueryBuilder<RecentMaterial, String, QQueryOperations>
      materialDescProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialDesc');
    });
  }
}
