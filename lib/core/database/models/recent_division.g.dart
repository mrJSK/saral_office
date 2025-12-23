// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_division.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecentDivisionCollection on Isar {
  IsarCollection<RecentDivision> get recentDivisions => this.collection();
}

const RecentDivisionSchema = CollectionSchema(
  name: r'RecentDivision',
  id: 2748774704118940342,
  properties: {
    r'fundsCenter': PropertySchema(
      id: 0,
      name: r'fundsCenter',
      type: IsarType.string,
    ),
    r'lastUsedAt': PropertySchema(
      id: 1,
      name: r'lastUsedAt',
      type: IsarType.dateTime,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _recentDivisionEstimateSize,
  serialize: _recentDivisionSerialize,
  deserialize: _recentDivisionDeserialize,
  deserializeProp: _recentDivisionDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recentDivisionGetId,
  getLinks: _recentDivisionGetLinks,
  attach: _recentDivisionAttach,
  version: '3.1.0+1',
);

int _recentDivisionEstimateSize(
  RecentDivision object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fundsCenter.length * 3;
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _recentDivisionSerialize(
  RecentDivision object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fundsCenter);
  writer.writeDateTime(offsets[1], object.lastUsedAt);
  writer.writeString(offsets[2], object.name);
}

RecentDivision _recentDivisionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentDivision();
  object.fundsCenter = reader.readString(offsets[0]);
  object.id = id;
  object.lastUsedAt = reader.readDateTime(offsets[1]);
  object.name = reader.readString(offsets[2]);
  return object;
}

P _recentDivisionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recentDivisionGetId(RecentDivision object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recentDivisionGetLinks(RecentDivision object) {
  return [];
}

void _recentDivisionAttach(
    IsarCollection<dynamic> col, Id id, RecentDivision object) {
  object.id = id;
}

extension RecentDivisionQueryWhereSort
    on QueryBuilder<RecentDivision, RecentDivision, QWhere> {
  QueryBuilder<RecentDivision, RecentDivision, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecentDivisionQueryWhere
    on QueryBuilder<RecentDivision, RecentDivision, QWhereClause> {
  QueryBuilder<RecentDivision, RecentDivision, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterWhereClause> idBetween(
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

extension RecentDivisionQueryFilter
    on QueryBuilder<RecentDivision, RecentDivision, QFilterCondition> {
  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      fundsCenterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      fundsCenterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fundsCenter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      fundsCenterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fundsCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      fundsCenterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fundsCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      lastUsedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
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

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension RecentDivisionQueryObject
    on QueryBuilder<RecentDivision, RecentDivision, QFilterCondition> {}

extension RecentDivisionQueryLinks
    on QueryBuilder<RecentDivision, RecentDivision, QFilterCondition> {}

extension RecentDivisionQuerySortBy
    on QueryBuilder<RecentDivision, RecentDivision, QSortBy> {
  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      sortByFundsCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.asc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      sortByFundsCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.desc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      sortByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      sortByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension RecentDivisionQuerySortThenBy
    on QueryBuilder<RecentDivision, RecentDivision, QSortThenBy> {
  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      thenByFundsCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.asc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      thenByFundsCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.desc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      thenByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy>
      thenByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension RecentDivisionQueryWhereDistinct
    on QueryBuilder<RecentDivision, RecentDivision, QDistinct> {
  QueryBuilder<RecentDivision, RecentDivision, QDistinct> distinctByFundsCenter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fundsCenter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QDistinct>
      distinctByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentDivision, RecentDivision, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }
}

extension RecentDivisionQueryProperty
    on QueryBuilder<RecentDivision, RecentDivision, QQueryProperty> {
  QueryBuilder<RecentDivision, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecentDivision, String, QQueryOperations> fundsCenterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fundsCenter');
    });
  }

  QueryBuilder<RecentDivision, DateTime, QQueryOperations>
      lastUsedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentDivision, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }
}
