// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_gl.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecentGLCollection on Isar {
  IsarCollection<RecentGL> get recentGLs => this.collection();
}

const RecentGLSchema = CollectionSchema(
  name: r'RecentGL',
  id: 2946602239487369652,
  properties: {
    r'glCode': PropertySchema(
      id: 0,
      name: r'glCode',
      type: IsarType.string,
    ),
    r'glDescription': PropertySchema(
      id: 1,
      name: r'glDescription',
      type: IsarType.string,
    ),
    r'lastUsedAt': PropertySchema(
      id: 2,
      name: r'lastUsedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _recentGLEstimateSize,
  serialize: _recentGLSerialize,
  deserialize: _recentGLDeserialize,
  deserializeProp: _recentGLDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recentGLGetId,
  getLinks: _recentGLGetLinks,
  attach: _recentGLAttach,
  version: '3.1.0+1',
);

int _recentGLEstimateSize(
  RecentGL object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.glCode.length * 3;
  bytesCount += 3 + object.glDescription.length * 3;
  return bytesCount;
}

void _recentGLSerialize(
  RecentGL object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.glCode);
  writer.writeString(offsets[1], object.glDescription);
  writer.writeDateTime(offsets[2], object.lastUsedAt);
}

RecentGL _recentGLDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentGL();
  object.glCode = reader.readString(offsets[0]);
  object.glDescription = reader.readString(offsets[1]);
  object.id = id;
  object.lastUsedAt = reader.readDateTime(offsets[2]);
  return object;
}

P _recentGLDeserializeProp<P>(
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
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recentGLGetId(RecentGL object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recentGLGetLinks(RecentGL object) {
  return [];
}

void _recentGLAttach(IsarCollection<dynamic> col, Id id, RecentGL object) {
  object.id = id;
}

extension RecentGLQueryWhereSort on QueryBuilder<RecentGL, RecentGL, QWhere> {
  QueryBuilder<RecentGL, RecentGL, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecentGLQueryWhere on QueryBuilder<RecentGL, RecentGL, QWhereClause> {
  QueryBuilder<RecentGL, RecentGL, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<RecentGL, RecentGL, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterWhereClause> idBetween(
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

extension RecentGLQueryFilter
    on QueryBuilder<RecentGL, RecentGL, QFilterCondition> {
  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'glCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'glCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'glCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'glCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'glCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'glCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'glCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glCode',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'glCode',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glDescriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition>
      glDescriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'glDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glDescriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'glDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glDescriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'glDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition>
      glDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'glDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'glDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glDescriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'glDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> glDescriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'glDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition>
      glDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition>
      glDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'glDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> lastUsedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> lastUsedAtGreaterThan(
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

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> lastUsedAtLessThan(
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

  QueryBuilder<RecentGL, RecentGL, QAfterFilterCondition> lastUsedAtBetween(
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
}

extension RecentGLQueryObject
    on QueryBuilder<RecentGL, RecentGL, QFilterCondition> {}

extension RecentGLQueryLinks
    on QueryBuilder<RecentGL, RecentGL, QFilterCondition> {}

extension RecentGLQuerySortBy on QueryBuilder<RecentGL, RecentGL, QSortBy> {
  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> sortByGlCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.asc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> sortByGlCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.desc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> sortByGlDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.asc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> sortByGlDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.desc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> sortByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> sortByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }
}

extension RecentGLQuerySortThenBy
    on QueryBuilder<RecentGL, RecentGL, QSortThenBy> {
  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenByGlCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.asc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenByGlCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.desc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenByGlDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.asc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenByGlDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.desc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QAfterSortBy> thenByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }
}

extension RecentGLQueryWhereDistinct
    on QueryBuilder<RecentGL, RecentGL, QDistinct> {
  QueryBuilder<RecentGL, RecentGL, QDistinct> distinctByGlCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QDistinct> distinctByGlDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentGL, RecentGL, QDistinct> distinctByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUsedAt');
    });
  }
}

extension RecentGLQueryProperty
    on QueryBuilder<RecentGL, RecentGL, QQueryProperty> {
  QueryBuilder<RecentGL, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecentGL, String, QQueryOperations> glCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glCode');
    });
  }

  QueryBuilder<RecentGL, String, QQueryOperations> glDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glDescription');
    });
  }

  QueryBuilder<RecentGL, DateTime, QQueryOperations> lastUsedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUsedAt');
    });
  }
}
