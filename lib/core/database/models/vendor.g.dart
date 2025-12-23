// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetVendorCollection on Isar {
  IsarCollection<Vendor> get vendors => this.collection();
}

const VendorSchema = CollectionSchema(
  name: r'Vendor',
  id: -5715217668496658661,
  properties: {
    r'city': PropertySchema(
      id: 0,
      name: r'city',
      type: IsarType.string,
    ),
    r'district': PropertySchema(
      id: 1,
      name: r'district',
      type: IsarType.string,
    ),
    r'fullAddress': PropertySchema(
      id: 2,
      name: r'fullAddress',
      type: IsarType.string,
    ),
    r'fullName': PropertySchema(
      id: 3,
      name: r'fullName',
      type: IsarType.string,
    ),
    r'gst': PropertySchema(
      id: 4,
      name: r'gst',
      type: IsarType.string,
    ),
    r'name1': PropertySchema(
      id: 5,
      name: r'name1',
      type: IsarType.string,
    ),
    r'name2': PropertySchema(
      id: 6,
      name: r'name2',
      type: IsarType.string,
    ),
    r'pan': PropertySchema(
      id: 7,
      name: r'pan',
      type: IsarType.string,
    ),
    r'postalCode': PropertySchema(
      id: 8,
      name: r'postalCode',
      type: IsarType.string,
    ),
    r'region': PropertySchema(
      id: 9,
      name: r'region',
      type: IsarType.string,
    ),
    r'street1': PropertySchema(
      id: 10,
      name: r'street1',
      type: IsarType.string,
    ),
    r'street2': PropertySchema(
      id: 11,
      name: r'street2',
      type: IsarType.string,
    ),
    r'street3': PropertySchema(
      id: 12,
      name: r'street3',
      type: IsarType.string,
    ),
    r'street4': PropertySchema(
      id: 13,
      name: r'street4',
      type: IsarType.string,
    ),
    r'vendorCode': PropertySchema(
      id: 14,
      name: r'vendorCode',
      type: IsarType.string,
    )
  },
  estimateSize: _vendorEstimateSize,
  serialize: _vendorSerialize,
  deserialize: _vendorDeserialize,
  deserializeProp: _vendorDeserializeProp,
  idName: r'id',
  indexes: {
    r'vendorCode': IndexSchema(
      id: 8844223806076218016,
      name: r'vendorCode',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'vendorCode',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _vendorGetId,
  getLinks: _vendorGetLinks,
  attach: _vendorAttach,
  version: '3.1.0+1',
);

int _vendorEstimateSize(
  Vendor object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.city.length * 3;
  {
    final value = object.district;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.fullAddress.length * 3;
  bytesCount += 3 + object.fullName.length * 3;
  {
    final value = object.gst;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name1.length * 3;
  {
    final value = object.name2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.pan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.postalCode.length * 3;
  {
    final value = object.region;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.street1;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.street2;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.street3;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.street4;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.vendorCode.length * 3;
  return bytesCount;
}

void _vendorSerialize(
  Vendor object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.city);
  writer.writeString(offsets[1], object.district);
  writer.writeString(offsets[2], object.fullAddress);
  writer.writeString(offsets[3], object.fullName);
  writer.writeString(offsets[4], object.gst);
  writer.writeString(offsets[5], object.name1);
  writer.writeString(offsets[6], object.name2);
  writer.writeString(offsets[7], object.pan);
  writer.writeString(offsets[8], object.postalCode);
  writer.writeString(offsets[9], object.region);
  writer.writeString(offsets[10], object.street1);
  writer.writeString(offsets[11], object.street2);
  writer.writeString(offsets[12], object.street3);
  writer.writeString(offsets[13], object.street4);
  writer.writeString(offsets[14], object.vendorCode);
}

Vendor _vendorDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Vendor();
  object.city = reader.readString(offsets[0]);
  object.district = reader.readStringOrNull(offsets[1]);
  object.gst = reader.readStringOrNull(offsets[4]);
  object.id = id;
  object.name1 = reader.readString(offsets[5]);
  object.name2 = reader.readStringOrNull(offsets[6]);
  object.pan = reader.readStringOrNull(offsets[7]);
  object.postalCode = reader.readString(offsets[8]);
  object.region = reader.readStringOrNull(offsets[9]);
  object.street1 = reader.readStringOrNull(offsets[10]);
  object.street2 = reader.readStringOrNull(offsets[11]);
  object.street3 = reader.readStringOrNull(offsets[12]);
  object.street4 = reader.readStringOrNull(offsets[13]);
  object.vendorCode = reader.readString(offsets[14]);
  return object;
}

P _vendorDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _vendorGetId(Vendor object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _vendorGetLinks(Vendor object) {
  return [];
}

void _vendorAttach(IsarCollection<dynamic> col, Id id, Vendor object) {
  object.id = id;
}

extension VendorQueryWhereSort on QueryBuilder<Vendor, Vendor, QWhere> {
  QueryBuilder<Vendor, Vendor, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension VendorQueryWhere on QueryBuilder<Vendor, Vendor, QWhereClause> {
  QueryBuilder<Vendor, Vendor, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Vendor, Vendor, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterWhereClause> idBetween(
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

  QueryBuilder<Vendor, Vendor, QAfterWhereClause> vendorCodeEqualTo(
      String vendorCode) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'vendorCode',
        value: [vendorCode],
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterWhereClause> vendorCodeNotEqualTo(
      String vendorCode) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vendorCode',
              lower: [],
              upper: [vendorCode],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vendorCode',
              lower: [vendorCode],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vendorCode',
              lower: [vendorCode],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'vendorCode',
              lower: [],
              upper: [vendorCode],
              includeUpper: false,
            ));
      }
    });
  }
}

extension VendorQueryFilter on QueryBuilder<Vendor, Vendor, QFilterCondition> {
  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'district',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'district',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'district',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'district',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'district',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'district',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> districtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'district',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fullName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fullName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fullName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fullName',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> fullNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fullName',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'gst',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'gst',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gst',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gst',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gst',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gst',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> gstIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gst',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1EqualTo(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1GreaterThan(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1LessThan(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1Between(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1StartsWith(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1EndsWith(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1Contains(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1Matches(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name1',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name1',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name2',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name2',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name2',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> name2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name2',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'pan',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'pan',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'pan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'pan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'pan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'pan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pan',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> panIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'pan',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postalCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'postalCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'postalCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'postalCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'postalCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'postalCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'postalCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'postalCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'postalCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> postalCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'postalCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'region',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'region',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'region',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'region',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'region',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'region',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> regionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'region',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'street1',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'street1',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'street1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'street1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'street1',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'street1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'street1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'street1',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'street1',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street1',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street1IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'street1',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'street2',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'street2',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'street2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'street2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'street2',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'street2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'street2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'street2',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'street2',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street2',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street2IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'street2',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'street3',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'street3',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'street3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'street3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'street3',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'street3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'street3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'street3',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'street3',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street3',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street3IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'street3',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4IsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'street4',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4IsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'street4',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4EqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4GreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'street4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4LessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'street4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4Between(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'street4',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4StartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'street4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4EndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'street4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4Contains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'street4',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4Matches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'street4',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4IsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'street4',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> street4IsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'street4',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeEqualTo(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeGreaterThan(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeLessThan(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeBetween(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeStartsWith(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeEndsWith(
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

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vendorCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vendorCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vendorCode',
        value: '',
      ));
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterFilterCondition> vendorCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vendorCode',
        value: '',
      ));
    });
  }
}

extension VendorQueryObject on QueryBuilder<Vendor, Vendor, QFilterCondition> {}

extension VendorQueryLinks on QueryBuilder<Vendor, Vendor, QFilterCondition> {}

extension VendorQuerySortBy on QueryBuilder<Vendor, Vendor, QSortBy> {
  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByDistrict() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByDistrictDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByFullAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullAddress', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByFullAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullAddress', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByGst() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gst', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByGstDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gst', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByName1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByName1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByName2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name2', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByName2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name2', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByPan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pan', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByPanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pan', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByPostalCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postalCode', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByPostalCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postalCode', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street1', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street1', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street2', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street2', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street3', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street3', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street4', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByStreet4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street4', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByVendorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> sortByVendorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.desc);
    });
  }
}

extension VendorQuerySortThenBy on QueryBuilder<Vendor, Vendor, QSortThenBy> {
  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByDistrict() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByDistrictDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'district', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByFullAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullAddress', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByFullAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullAddress', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByFullName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByFullNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fullName', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByGst() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gst', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByGstDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gst', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByName1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByName1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name1', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByName2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name2', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByName2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name2', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByPan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pan', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByPanDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pan', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByPostalCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postalCode', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByPostalCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'postalCode', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByRegion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByRegionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'region', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet1() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street1', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet1Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street1', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet2() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street2', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet2Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street2', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet3() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street3', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet3Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street3', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet4() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street4', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByStreet4Desc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'street4', Sort.desc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByVendorCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.asc);
    });
  }

  QueryBuilder<Vendor, Vendor, QAfterSortBy> thenByVendorCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vendorCode', Sort.desc);
    });
  }
}

extension VendorQueryWhereDistinct on QueryBuilder<Vendor, Vendor, QDistinct> {
  QueryBuilder<Vendor, Vendor, QDistinct> distinctByCity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByDistrict(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'district', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByFullAddress(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByFullName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fullName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByGst(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gst', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByName1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByName2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByPan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByPostalCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'postalCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByRegion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'region', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByStreet1(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'street1', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByStreet2(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'street2', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByStreet3(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'street3', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByStreet4(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'street4', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Vendor, Vendor, QDistinct> distinctByVendorCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vendorCode', caseSensitive: caseSensitive);
    });
  }
}

extension VendorQueryProperty on QueryBuilder<Vendor, Vendor, QQueryProperty> {
  QueryBuilder<Vendor, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Vendor, String, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> districtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'district');
    });
  }

  QueryBuilder<Vendor, String, QQueryOperations> fullAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullAddress');
    });
  }

  QueryBuilder<Vendor, String, QQueryOperations> fullNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fullName');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> gstProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gst');
    });
  }

  QueryBuilder<Vendor, String, QQueryOperations> name1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name1');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> name2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name2');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> panProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pan');
    });
  }

  QueryBuilder<Vendor, String, QQueryOperations> postalCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'postalCode');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> regionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'region');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> street1Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'street1');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> street2Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'street2');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> street3Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'street3');
    });
  }

  QueryBuilder<Vendor, String?, QQueryOperations> street4Property() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'street4');
    });
  }

  QueryBuilder<Vendor, String, QQueryOperations> vendorCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vendorCode');
    });
  }
}
