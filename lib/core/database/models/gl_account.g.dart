// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gl_account.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGLAccountCollection on Isar {
  IsarCollection<GLAccount> get gLAccounts => this.collection();
}

const GLAccountSchema = CollectionSchema(
  name: r'GLAccount',
  id: 1601725641361328355,
  properties: {
    r'agCode': PropertySchema(
      id: 0,
      name: r'agCode',
      type: IsarType.string,
    ),
    r'agDescription': PropertySchema(
      id: 1,
      name: r'agDescription',
      type: IsarType.string,
    ),
    r'displayText': PropertySchema(
      id: 2,
      name: r'displayText',
      type: IsarType.string,
    ),
    r'glCode': PropertySchema(
      id: 3,
      name: r'glCode',
      type: IsarType.string,
    ),
    r'glDescription': PropertySchema(
      id: 4,
      name: r'glDescription',
      type: IsarType.string,
    ),
    r'mainAccountCode': PropertySchema(
      id: 5,
      name: r'mainAccountCode',
      type: IsarType.string,
    ),
    r'mainAccountDescription': PropertySchema(
      id: 6,
      name: r'mainAccountDescription',
      type: IsarType.string,
    ),
    r'pdfText': PropertySchema(
      id: 7,
      name: r'pdfText',
      type: IsarType.string,
    )
  },
  estimateSize: _gLAccountEstimateSize,
  serialize: _gLAccountSerialize,
  deserialize: _gLAccountDeserialize,
  deserializeProp: _gLAccountDeserializeProp,
  idName: r'id',
  indexes: {
    r'glCode': IndexSchema(
      id: -6807405345774123300,
      name: r'glCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'glCode',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _gLAccountGetId,
  getLinks: _gLAccountGetLinks,
  attach: _gLAccountAttach,
  version: '3.1.0+1',
);

int _gLAccountEstimateSize(
  GLAccount object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.agCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.agDescription;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.displayText.length * 3;
  bytesCount += 3 + object.glCode.length * 3;
  bytesCount += 3 + object.glDescription.length * 3;
  {
    final value = object.mainAccountCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.mainAccountDescription;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.pdfText.length * 3;
  return bytesCount;
}

void _gLAccountSerialize(
  GLAccount object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.agCode);
  writer.writeString(offsets[1], object.agDescription);
  writer.writeString(offsets[2], object.displayText);
  writer.writeString(offsets[3], object.glCode);
  writer.writeString(offsets[4], object.glDescription);
  writer.writeString(offsets[5], object.mainAccountCode);
  writer.writeString(offsets[6], object.mainAccountDescription);
  writer.writeString(offsets[7], object.pdfText);
}

GLAccount _gLAccountDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GLAccount();
  object.agCode = reader.readStringOrNull(offsets[0]);
  object.agDescription = reader.readStringOrNull(offsets[1]);
  object.glCode = reader.readString(offsets[3]);
  object.glDescription = reader.readString(offsets[4]);
  object.id = id;
  object.mainAccountCode = reader.readStringOrNull(offsets[5]);
  object.mainAccountDescription = reader.readStringOrNull(offsets[6]);
  return object;
}

P _gLAccountDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _gLAccountGetId(GLAccount object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _gLAccountGetLinks(GLAccount object) {
  return [];
}

void _gLAccountAttach(IsarCollection<dynamic> col, Id id, GLAccount object) {
  object.id = id;
}

extension GLAccountQueryWhereSort
    on QueryBuilder<GLAccount, GLAccount, QWhere> {
  QueryBuilder<GLAccount, GLAccount, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension GLAccountQueryWhere
    on QueryBuilder<GLAccount, GLAccount, QWhereClause> {
  QueryBuilder<GLAccount, GLAccount, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<GLAccount, GLAccount, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterWhereClause> idBetween(
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

  QueryBuilder<GLAccount, GLAccount, QAfterWhereClause> glCodeEqualTo(
      String glCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'glCode',
        value: [glCode],
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterWhereClause> glCodeNotEqualTo(
      String glCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'glCode',
              lower: [],
              upper: [glCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'glCode',
              lower: [glCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'glCode',
              lower: [glCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'glCode',
              lower: [],
              upper: [glCode],
              includeUpper: false,
            ));
      }
    });
  }
}

extension GLAccountQueryFilter
    on QueryBuilder<GLAccount, GLAccount, QFilterCondition> {
  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'agCode',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'agCode',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'agCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'agCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'agCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'agCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'agCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> agCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'agDescription',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'agDescription',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'agDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'agDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'agDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'agDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'agDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'agDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'agDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'agDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      agDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'agDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> displayTextEqualTo(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> displayTextLessThan(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> displayTextBetween(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      displayTextStartsWith(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> displayTextEndsWith(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> displayTextContains(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> displayTextMatches(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      displayTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayText',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      displayTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayText',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeEqualTo(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeGreaterThan(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeLessThan(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeBetween(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeStartsWith(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeEndsWith(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeContains(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeMatches(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> glCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'glCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionEqualTo(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionLessThan(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionBetween(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionEndsWith(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'glDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'glDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      glDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'glDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> idBetween(
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

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mainAccountCode',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mainAccountCode',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccountCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainAccountCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainAccountCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainAccountCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainAccountCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainAccountCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainAccountCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainAccountCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccountCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainAccountCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mainAccountDescription',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mainAccountDescription',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccountDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mainAccountDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mainAccountDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mainAccountDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mainAccountDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mainAccountDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mainAccountDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mainAccountDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mainAccountDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      mainAccountDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mainAccountDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdfText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pdfText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pdfText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pdfText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pdfText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pdfText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pdfText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pdfText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition> pdfTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pdfText',
        value: '',
      ));
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterFilterCondition>
      pdfTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pdfText',
        value: '',
      ));
    });
  }
}

extension GLAccountQueryObject
    on QueryBuilder<GLAccount, GLAccount, QFilterCondition> {}

extension GLAccountQueryLinks
    on QueryBuilder<GLAccount, GLAccount, QFilterCondition> {}

extension GLAccountQuerySortBy on QueryBuilder<GLAccount, GLAccount, QSortBy> {
  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByAgCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agCode', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByAgCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agCode', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByAgDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agDescription', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByAgDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agDescription', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByGlCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByGlCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByGlDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByGlDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByMainAccountCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountCode', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByMainAccountCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountCode', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy>
      sortByMainAccountDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountDescription', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy>
      sortByMainAccountDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountDescription', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByPdfText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> sortByPdfTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.desc);
    });
  }
}

extension GLAccountQuerySortThenBy
    on QueryBuilder<GLAccount, GLAccount, QSortThenBy> {
  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByAgCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agCode', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByAgCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agCode', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByAgDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agDescription', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByAgDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'agDescription', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByDisplayText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByDisplayTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayText', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByGlCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByGlCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glCode', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByGlDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByGlDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glDescription', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByMainAccountCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountCode', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByMainAccountCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountCode', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy>
      thenByMainAccountDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountDescription', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy>
      thenByMainAccountDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mainAccountDescription', Sort.desc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByPdfText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.asc);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QAfterSortBy> thenByPdfTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pdfText', Sort.desc);
    });
  }
}

extension GLAccountQueryWhereDistinct
    on QueryBuilder<GLAccount, GLAccount, QDistinct> {
  QueryBuilder<GLAccount, GLAccount, QDistinct> distinctByAgCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QDistinct> distinctByAgDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'agDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QDistinct> distinctByDisplayText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QDistinct> distinctByGlCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QDistinct> distinctByGlDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QDistinct> distinctByMainAccountCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainAccountCode',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QDistinct>
      distinctByMainAccountDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mainAccountDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GLAccount, GLAccount, QDistinct> distinctByPdfText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pdfText', caseSensitive: caseSensitive);
    });
  }
}

extension GLAccountQueryProperty
    on QueryBuilder<GLAccount, GLAccount, QQueryProperty> {
  QueryBuilder<GLAccount, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GLAccount, String?, QQueryOperations> agCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agCode');
    });
  }

  QueryBuilder<GLAccount, String?, QQueryOperations> agDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'agDescription');
    });
  }

  QueryBuilder<GLAccount, String, QQueryOperations> displayTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayText');
    });
  }

  QueryBuilder<GLAccount, String, QQueryOperations> glCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glCode');
    });
  }

  QueryBuilder<GLAccount, String, QQueryOperations> glDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glDescription');
    });
  }

  QueryBuilder<GLAccount, String?, QQueryOperations> mainAccountCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainAccountCode');
    });
  }

  QueryBuilder<GLAccount, String?, QQueryOperations>
      mainAccountDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mainAccountDescription');
    });
  }

  QueryBuilder<GLAccount, String, QQueryOperations> pdfTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pdfText');
    });
  }
}
