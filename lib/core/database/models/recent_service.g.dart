// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_service.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecentServiceCollection on Isar {
  IsarCollection<RecentService> get recentServices => this.collection();
}

const RecentServiceSchema = CollectionSchema(
  name: r'RecentService',
  id: -3892253447231742764,
  properties: {
    r'activityNumber': PropertySchema(
      id: 0,
      name: r'activityNumber',
      type: IsarType.string,
    ),
    r'lastUsedAt': PropertySchema(
      id: 1,
      name: r'lastUsedAt',
      type: IsarType.dateTime,
    ),
    r'serviceShortText': PropertySchema(
      id: 2,
      name: r'serviceShortText',
      type: IsarType.string,
    )
  },
  estimateSize: _recentServiceEstimateSize,
  serialize: _recentServiceSerialize,
  deserialize: _recentServiceDeserialize,
  deserializeProp: _recentServiceDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recentServiceGetId,
  getLinks: _recentServiceGetLinks,
  attach: _recentServiceAttach,
  version: '3.1.0+1',
);

int _recentServiceEstimateSize(
  RecentService object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activityNumber.length * 3;
  bytesCount += 3 + object.serviceShortText.length * 3;
  return bytesCount;
}

void _recentServiceSerialize(
  RecentService object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityNumber);
  writer.writeDateTime(offsets[1], object.lastUsedAt);
  writer.writeString(offsets[2], object.serviceShortText);
}

RecentService _recentServiceDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentService();
  object.activityNumber = reader.readString(offsets[0]);
  object.id = id;
  object.lastUsedAt = reader.readDateTime(offsets[1]);
  object.serviceShortText = reader.readString(offsets[2]);
  return object;
}

P _recentServiceDeserializeProp<P>(
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

Id _recentServiceGetId(RecentService object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recentServiceGetLinks(RecentService object) {
  return [];
}

void _recentServiceAttach(
    IsarCollection<dynamic> col, Id id, RecentService object) {
  object.id = id;
}

extension RecentServiceQueryWhereSort
    on QueryBuilder<RecentService, RecentService, QWhere> {
  QueryBuilder<RecentService, RecentService, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecentServiceQueryWhere
    on QueryBuilder<RecentService, RecentService, QWhereClause> {
  QueryBuilder<RecentService, RecentService, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RecentService, RecentService, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterWhereClause> idBetween(
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

extension RecentServiceQueryFilter
    on QueryBuilder<RecentService, RecentService, QFilterCondition> {
  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      activityNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
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

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      lastUsedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
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

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
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

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
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

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serviceShortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serviceShortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serviceShortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serviceShortText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serviceShortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serviceShortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serviceShortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serviceShortText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serviceShortText',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterFilterCondition>
      serviceShortTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serviceShortText',
        value: '',
      ));
    });
  }
}

extension RecentServiceQueryObject
    on QueryBuilder<RecentService, RecentService, QFilterCondition> {}

extension RecentServiceQueryLinks
    on QueryBuilder<RecentService, RecentService, QFilterCondition> {}

extension RecentServiceQuerySortBy
    on QueryBuilder<RecentService, RecentService, QSortBy> {
  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      sortByActivityNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.asc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      sortByActivityNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.desc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy> sortByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      sortByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      sortByServiceShortText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.asc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      sortByServiceShortTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.desc);
    });
  }
}

extension RecentServiceQuerySortThenBy
    on QueryBuilder<RecentService, RecentService, QSortThenBy> {
  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      thenByActivityNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.asc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      thenByActivityNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityNumber', Sort.desc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy> thenByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      thenByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      thenByServiceShortText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.asc);
    });
  }

  QueryBuilder<RecentService, RecentService, QAfterSortBy>
      thenByServiceShortTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serviceShortText', Sort.desc);
    });
  }
}

extension RecentServiceQueryWhereDistinct
    on QueryBuilder<RecentService, RecentService, QDistinct> {
  QueryBuilder<RecentService, RecentService, QDistinct>
      distinctByActivityNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentService, RecentService, QDistinct> distinctByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentService, RecentService, QDistinct>
      distinctByServiceShortText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serviceShortText',
          caseSensitive: caseSensitive);
    });
  }
}

extension RecentServiceQueryProperty
    on QueryBuilder<RecentService, RecentService, QQueryProperty> {
  QueryBuilder<RecentService, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecentService, String, QQueryOperations>
      activityNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityNumber');
    });
  }

  QueryBuilder<RecentService, DateTime, QQueryOperations> lastUsedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentService, String, QQueryOperations>
      serviceShortTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceShortText');
    });
  }
}
