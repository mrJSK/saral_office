// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_authority.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSavedAuthorityCollection on Isar {
  IsarCollection<SavedAuthority> get savedAuthoritys => this.collection();
}

const SavedAuthoritySchema = CollectionSchema(
  name: r'SavedAuthority',
  id: 3837322938652291800,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.double,
    ),
    r'authorityOrderNo': PropertySchema(
      id: 1,
      name: r'authorityOrderNo',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'divisionCode': PropertySchema(
      id: 3,
      name: r'divisionCode',
      type: IsarType.string,
    ),
    r'divisionName': PropertySchema(
      id: 4,
      name: r'divisionName',
      type: IsarType.string,
    ),
    r'formattedDate': PropertySchema(
      id: 5,
      name: r'formattedDate',
      type: IsarType.string,
    ),
    r'fullJsonData': PropertySchema(
      id: 6,
      name: r'fullJsonData',
      type: IsarType.string,
    ),
    r'vendorName': PropertySchema(
      id: 7,
      name: r'vendorName',
      type: IsarType.string,
    )
  },
  estimateSize: _savedAuthorityEstimateSize,
  serialize: _savedAuthoritySerialize,
  deserialize: _savedAuthorityDeserialize,
  deserializeProp: _savedAuthorityDeserializeProp,
  idName: r'id',
  indexes: {
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _savedAuthorityGetId,
  getLinks: _savedAuthorityGetLinks,
  attach: _savedAuthorityAttach,
  version: '3.1.0+1',
);

int _savedAuthorityEstimateSize(
  SavedAuthority object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.authorityOrderNo.length * 3;
  bytesCount += 3 + object.divisionCode.length * 3;
  bytesCount += 3 + object.divisionName.length * 3;
  bytesCount += 3 + object.formattedDate.length * 3;
  bytesCount += 3 + object.fullJsonData.length * 3;
  bytesCount += 3 + object.vendorName.length * 3;
  return bytesCount;
}

void _savedAuthoritySerialize(
  SavedAuthority object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.amount);
  writer.writeString(offsets[1], object.authorityOrderNo);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeString(offsets[3], object.divisionCode);
  writer.writeString(offsets[4], object.divisionName);
  writer.writeString(offsets[5], object.formattedDate);
  writer.writeString(offsets[6], object.fullJsonData);
  writer.writeString(offsets[7], object.vendorName);
}

SavedAuthority _savedAuthorityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SavedAuthority();
  object.amount = reader.readDouble(offsets[0]);
  object.authorityOrderNo = reader.readString(offsets[1]);
  object.createdAt = reader.readDateTime(offsets[2]);
  object.divisionCode = reader.readString(offsets[3]);
  object.divisionName = reader.readString(offsets[4]);
  object.fullJsonData = reader.readString(offsets[6]);
  object.id = id;
  object.vendorName = reader.readString(offsets[7]);
  return object;
}

P _savedAuthorityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
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
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _savedAuthorityGetId(SavedAuthority object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _savedAuthorityGetLinks(SavedAuthority object) {
  return [];
}

void _savedAuthorityAttach(
    IsarCollection<dynamic> col, Id id, SavedAuthority object) {
  object.id = id;
}

extension SavedAuthorityQueryWhereSort
    on QueryBuilder<SavedAuthority, SavedAuthority, QWhere> {
  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension SavedAuthorityQueryWhere
    on QueryBuilder<SavedAuthority, SavedAuthority, QWhereClause> {
  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause> idBetween(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause>
      createdAtEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause>
      createdAtNotEqualTo(DateTime createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause>
      createdAtLessThan(
    DateTime createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterWhereClause>
      createdAtBetween(
    DateTime lowerCreatedAt,
    DateTime upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SavedAuthorityQueryFilter
    on QueryBuilder<SavedAuthority, SavedAuthority, QFilterCondition> {
  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      amountEqualTo(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      amountGreaterThan(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      amountLessThan(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      amountBetween(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authorityOrderNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'authorityOrderNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'authorityOrderNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'authorityOrderNo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'authorityOrderNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'authorityOrderNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'authorityOrderNo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'authorityOrderNo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authorityOrderNo',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      authorityOrderNoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'authorityOrderNo',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      createdAtLessThan(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      createdAtBetween(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divisionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'divisionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'divisionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'divisionCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'divisionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'divisionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'divisionCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'divisionCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divisionCode',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'divisionCode',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'divisionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'divisionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'divisionName',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      divisionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'divisionName',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'formattedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'formattedDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'formattedDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'formattedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      formattedDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'formattedDate',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataEqualTo(
    String value, {
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataGreaterThan(
    String value, {
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataLessThan(
    String value, {
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataBetween(
    String lower,
    String upper, {
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullJsonData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullJsonData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullJsonData',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      fullJsonDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullJsonData',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vendorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vendorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vendorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vendorName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vendorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vendorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vendorName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vendorName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vendorName',
        value: '',
      ));
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterFilterCondition>
      vendorNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vendorName',
        value: '',
      ));
    });
  }
}

extension SavedAuthorityQueryObject
    on QueryBuilder<SavedAuthority, SavedAuthority, QFilterCondition> {}

extension SavedAuthorityQueryLinks
    on QueryBuilder<SavedAuthority, SavedAuthority, QFilterCondition> {}

extension SavedAuthorityQuerySortBy
    on QueryBuilder<SavedAuthority, SavedAuthority, QSortBy> {
  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByAuthorityOrderNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorityOrderNo', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByAuthorityOrderNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorityOrderNo', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByDivisionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionCode', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByDivisionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionCode', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByDivisionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByDivisionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByFormattedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByFormattedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByFullJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByFullJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByVendorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorName', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      sortByVendorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorName', Sort.desc);
    });
  }
}

extension SavedAuthorityQuerySortThenBy
    on QueryBuilder<SavedAuthority, SavedAuthority, QSortThenBy> {
  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByAuthorityOrderNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorityOrderNo', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByAuthorityOrderNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authorityOrderNo', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByDivisionCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionCode', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByDivisionCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionCode', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByDivisionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByDivisionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'divisionName', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByFormattedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByFormattedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'formattedDate', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByFullJsonData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByFullJsonDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullJsonData', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByVendorName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorName', Sort.asc);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QAfterSortBy>
      thenByVendorNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorName', Sort.desc);
    });
  }
}

extension SavedAuthorityQueryWhereDistinct
    on QueryBuilder<SavedAuthority, SavedAuthority, QDistinct> {
  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct>
      distinctByAuthorityOrderNo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authorityOrderNo',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct>
      distinctByDivisionCode({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'divisionCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct>
      distinctByDivisionName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'divisionName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct>
      distinctByFormattedDate({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'formattedDate',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct>
      distinctByFullJsonData({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullJsonData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SavedAuthority, SavedAuthority, QDistinct> distinctByVendorName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vendorName', caseSensitive: caseSensitive);
    });
  }
}

extension SavedAuthorityQueryProperty
    on QueryBuilder<SavedAuthority, SavedAuthority, QQueryProperty> {
  QueryBuilder<SavedAuthority, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SavedAuthority, double, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<SavedAuthority, String, QQueryOperations>
      authorityOrderNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authorityOrderNo');
    });
  }

  QueryBuilder<SavedAuthority, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<SavedAuthority, String, QQueryOperations>
      divisionCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'divisionCode');
    });
  }

  QueryBuilder<SavedAuthority, String, QQueryOperations>
      divisionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'divisionName');
    });
  }

  QueryBuilder<SavedAuthority, String, QQueryOperations>
      formattedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'formattedDate');
    });
  }

  QueryBuilder<SavedAuthority, String, QQueryOperations>
      fullJsonDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullJsonData');
    });
  }

  QueryBuilder<SavedAuthority, String, QQueryOperations> vendorNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vendorName');
    });
  }
}
