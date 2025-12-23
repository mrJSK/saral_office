// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'division.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDivisionCollection on Isar {
  IsarCollection<Division> get divisions => this.collection();
}

const DivisionSchema = CollectionSchema(
  name: r'Division',
  id: -4483310401711143725,
  properties: {
    r'displayText': PropertySchema(
      id: 0,
      name: r'displayText',
      type: IsarType.string,
    ),
    r'fundsCenter': PropertySchema(
      id: 1,
      name: r'fundsCenter',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'personResponsible': PropertySchema(
      id: 3,
      name: r'personResponsible',
      type: IsarType.string,
    ),
    r'validFrom': PropertySchema(
      id: 4,
      name: r'validFrom',
      type: IsarType.dateTime,
    ),
    r'validTo': PropertySchema(
      id: 5,
      name: r'validTo',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _divisionEstimateSize,
  serialize: _divisionSerialize,
  deserialize: _divisionDeserialize,
  deserializeProp: _divisionDeserializeProp,
  idName: r'id',
  indexes: {
    r'fundsCenter': IndexSchema(
      id: 7087991654772875730,
      name: r'fundsCenter',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'fundsCenter',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _divisionGetId,
  getLinks: _divisionGetLinks,
  attach: _divisionAttach,
  version: '3.1.0+1',
);

int _divisionEstimateSize(
  Division object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.displayText.length * 3;
  bytesCount += 3 + object.fundsCenter.length * 3;
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.personResponsible;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _divisionSerialize(
  Division object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.displayText);
  writer.writeString(offsets[1], object.fundsCenter);
  writer.writeString(offsets[2], object.name);
  writer.writeString(offsets[3], object.personResponsible);
  writer.writeDateTime(offsets[4], object.validFrom);
  writer.writeDateTime(offsets[5], object.validTo);
}

Division _divisionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Division();
  object.fundsCenter = reader.readString(offsets[1]);
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.personResponsible = reader.readStringOrNull(offsets[3]);
  object.validFrom = reader.readDateTimeOrNull(offsets[4]);
  object.validTo = reader.readDateTimeOrNull(offsets[5]);
  return object;
}

P _divisionDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _divisionGetId(Division object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _divisionGetLinks(Division object) {
  return [];
}

void _divisionAttach(IsarCollection<dynamic> col, Id id, Division object) {
  object.id = id;
}

extension DivisionQueryWhereSort on QueryBuilder<Division, Division, QWhere> {
  QueryBuilder<Division, Division, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DivisionQueryWhere on QueryBuilder<Division, Division, QWhereClause> {
  QueryBuilder<Division, Division, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Division, Division, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Division, Division, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Division, Division, QAfterWhereClause> idBetween(
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

  QueryBuilder<Division, Division, QAfterWhereClause> fundsCenterEqualTo(
      String fundsCenter) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fundsCenter',
        value: [fundsCenter],
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterWhereClause> fundsCenterNotEqualTo(
      String fundsCenter) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fundsCenter',
              lower: [],
              upper: [fundsCenter],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fundsCenter',
              lower: [fundsCenter],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fundsCenter',
              lower: [fundsCenter],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fundsCenter',
              lower: [],
              upper: [fundsCenter],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DivisionQueryFilter
    on QueryBuilder<Division, Division, QFilterCondition> {
  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      displayTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> displayTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayText',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      displayTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayText',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterEqualTo(
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

  QueryBuilder<Division, Division, QAfterFilterCondition>
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

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterLessThan(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterBetween(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterStartsWith(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterEndsWith(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fundsCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fundsCenter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> fundsCenterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fundsCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      fundsCenterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fundsCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Division, Division, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'personResponsible',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'personResponsible',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personResponsible',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'personResponsible',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'personResponsible',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'personResponsible',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'personResponsible',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'personResponsible',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'personResponsible',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'personResponsible',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'personResponsible',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition>
      personResponsibleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'personResponsible',
        value: '',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validFromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'validFrom',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validFromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'validFrom',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validFromEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'validFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validFromGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'validFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validFromLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'validFrom',
        value: value,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validFromBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'validFrom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validToIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'validTo',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validToIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'validTo',
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validToEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'validTo',
        value: value,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validToGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'validTo',
        value: value,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validToLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'validTo',
        value: value,
      ));
    });
  }

  QueryBuilder<Division, Division, QAfterFilterCondition> validToBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'validTo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension DivisionQueryObject
    on QueryBuilder<Division, Division, QFilterCondition> {}

extension DivisionQueryLinks
    on QueryBuilder<Division, Division, QFilterCondition> {}

extension DivisionQuerySortBy on QueryBuilder<Division, Division, QSortBy> {
  QueryBuilder<Division, Division, QAfterSortBy> sortByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByFundsCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByFundsCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByPersonResponsible() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personResponsible', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByPersonResponsibleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personResponsible', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByValidFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validFrom', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByValidFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validFrom', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByValidTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validTo', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> sortByValidToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validTo', Sort.desc);
    });
  }
}

extension DivisionQuerySortThenBy
    on QueryBuilder<Division, Division, QSortThenBy> {
  QueryBuilder<Division, Division, QAfterSortBy> thenByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByFundsCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByFundsCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fundsCenter', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByPersonResponsible() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personResponsible', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByPersonResponsibleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'personResponsible', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByValidFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validFrom', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByValidFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validFrom', Sort.desc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByValidTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validTo', Sort.asc);
    });
  }

  QueryBuilder<Division, Division, QAfterSortBy> thenByValidToDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'validTo', Sort.desc);
    });
  }
}

extension DivisionQueryWhereDistinct
    on QueryBuilder<Division, Division, QDistinct> {
  QueryBuilder<Division, Division, QDistinct> distinctByDisplayText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Division, Division, QDistinct> distinctByFundsCenter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fundsCenter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Division, Division, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Division, Division, QDistinct> distinctByPersonResponsible(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'personResponsible',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Division, Division, QDistinct> distinctByValidFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'validFrom');
    });
  }

  QueryBuilder<Division, Division, QDistinct> distinctByValidTo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'validTo');
    });
  }
}

extension DivisionQueryProperty
    on QueryBuilder<Division, Division, QQueryProperty> {
  QueryBuilder<Division, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Division, String, QQueryOperations> displayTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayText');
    });
  }

  QueryBuilder<Division, String, QQueryOperations> fundsCenterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fundsCenter');
    });
  }

  QueryBuilder<Division, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Division, String?, QQueryOperations>
      personResponsibleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personResponsible');
    });
  }

  QueryBuilder<Division, DateTime?, QQueryOperations> validFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'validFrom');
    });
  }

  QueryBuilder<Division, DateTime?, QQueryOperations> validToProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'validTo');
    });
  }
}
