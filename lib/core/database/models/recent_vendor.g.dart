// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_vendor.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetRecentVendorCollection on Isar {
  IsarCollection<RecentVendor> get recentVendors => this.collection();
}

const RecentVendorSchema = CollectionSchema(
  name: r'RecentVendor',
  id: 95578438524656291,
  properties: {
    r'lastUsedAt': PropertySchema(
      id: 0,
      name: r'lastUsedAt',
      type: IsarType.dateTime,
    ),
    r'name1': PropertySchema(
      id: 1,
      name: r'name1',
      type: IsarType.string,
    ),
    r'vendorCode': PropertySchema(
      id: 2,
      name: r'vendorCode',
      type: IsarType.string,
    )
  },
  estimateSize: _recentVendorEstimateSize,
  serialize: _recentVendorSerialize,
  deserialize: _recentVendorDeserialize,
  deserializeProp: _recentVendorDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _recentVendorGetId,
  getLinks: _recentVendorGetLinks,
  attach: _recentVendorAttach,
  version: '3.1.0+1',
);

int _recentVendorEstimateSize(
  RecentVendor object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name1.length * 3;
  bytesCount += 3 + object.vendorCode.length * 3;
  return bytesCount;
}

void _recentVendorSerialize(
  RecentVendor object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.lastUsedAt);
  writer.writeString(offsets[1], object.name1);
  writer.writeString(offsets[2], object.vendorCode);
}

RecentVendor _recentVendorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = RecentVendor();
  object.id = id;
  object.lastUsedAt = reader.readDateTimeOrNull(offsets[0]);
  object.name1 = reader.readString(offsets[1]);
  object.vendorCode = reader.readString(offsets[2]);
  return object;
}

P _recentVendorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _recentVendorGetId(RecentVendor object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _recentVendorGetLinks(RecentVendor object) {
  return [];
}

void _recentVendorAttach(
    IsarCollection<dynamic> col, Id id, RecentVendor object) {
  object.id = id;
}

extension RecentVendorQueryWhereSort
    on QueryBuilder<RecentVendor, RecentVendor, QWhere> {
  QueryBuilder<RecentVendor, RecentVendor, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension RecentVendorQueryWhere
    on QueryBuilder<RecentVendor, RecentVendor, QWhereClause> {
  QueryBuilder<RecentVendor, RecentVendor, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<RecentVendor, RecentVendor, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterWhereClause> idBetween(
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

extension RecentVendorQueryFilter
    on QueryBuilder<RecentVendor, RecentVendor, QFilterCondition> {
  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> idBetween(
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

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      lastUsedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastUsedAt',
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      lastUsedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastUsedAt',
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      lastUsedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastUsedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      lastUsedAtGreaterThan(
    DateTime? value, {
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

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      lastUsedAtLessThan(
    DateTime? value, {
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

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      lastUsedAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> name1EqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      name1GreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> name1LessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> name1Between(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      name1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> name1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> name1Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition> name1Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      name1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name1',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      name1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name1',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vendorCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vendorCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vendorCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vendorCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vendorCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vendorCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vendorCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vendorCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vendorCode',
        value: '',
      ));
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterFilterCondition>
      vendorCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vendorCode',
        value: '',
      ));
    });
  }
}

extension RecentVendorQueryObject
    on QueryBuilder<RecentVendor, RecentVendor, QFilterCondition> {}

extension RecentVendorQueryLinks
    on QueryBuilder<RecentVendor, RecentVendor, QFilterCondition> {}

extension RecentVendorQuerySortBy
    on QueryBuilder<RecentVendor, RecentVendor, QSortBy> {
  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> sortByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy>
      sortByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> sortByName1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.asc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> sortByName1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.desc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> sortByVendorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.asc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy>
      sortByVendorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.desc);
    });
  }
}

extension RecentVendorQuerySortThenBy
    on QueryBuilder<RecentVendor, RecentVendor, QSortThenBy> {
  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> thenByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.asc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy>
      thenByLastUsedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastUsedAt', Sort.desc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> thenByName1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.asc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> thenByName1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.desc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy> thenByVendorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.asc);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QAfterSortBy>
      thenByVendorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.desc);
    });
  }
}

extension RecentVendorQueryWhereDistinct
    on QueryBuilder<RecentVendor, RecentVendor, QDistinct> {
  QueryBuilder<RecentVendor, RecentVendor, QDistinct> distinctByLastUsedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QDistinct> distinctByName1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<RecentVendor, RecentVendor, QDistinct> distinctByVendorCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vendorCode', caseSensitive: caseSensitive);
    });
  }
}

extension RecentVendorQueryProperty
    on QueryBuilder<RecentVendor, RecentVendor, QQueryProperty> {
  QueryBuilder<RecentVendor, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<RecentVendor, DateTime?, QQueryOperations> lastUsedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastUsedAt');
    });
  }

  QueryBuilder<RecentVendor, String, QQueryOperations> name1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name1');
    });
  }

  QueryBuilder<RecentVendor, String, QQueryOperations> vendorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vendorCode');
    });
  }
}
