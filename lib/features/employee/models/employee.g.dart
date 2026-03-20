// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetEmployeeCollection on Isar {
  IsarCollection<Employee> get employees => this.collection();
}

const EmployeeSchema = CollectionSchema(
  name: r'Employee',
  id: 3568472634033989540,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'designation': PropertySchema(
      id: 1,
      name: r'designation',
      type: IsarType.string,
    ),
    r'employeeName': PropertySchema(
      id: 2,
      name: r'employeeName',
      type: IsarType.string,
    ),
    r'office': PropertySchema(
      id: 3,
      name: r'office',
      type: IsarType.string,
    ),
    r'officeHead': PropertySchema(
      id: 4,
      name: r'officeHead',
      type: IsarType.string,
    ),
    r'officeHeadDesignation': PropertySchema(
      id: 5,
      name: r'officeHeadDesignation',
      type: IsarType.string,
    ),
    r'sapId': PropertySchema(
      id: 6,
      name: r'sapId',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 7,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _employeeEstimateSize,
  serialize: _employeeSerialize,
  deserialize: _employeeDeserialize,
  deserializeProp: _employeeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _employeeGetId,
  getLinks: _employeeGetLinks,
  attach: _employeeAttach,
  version: '3.1.0+1',
);

int _employeeEstimateSize(
  Employee object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.designation.length * 3;
  bytesCount += 3 + object.employeeName.length * 3;
  bytesCount += 3 + object.office.length * 3;
  bytesCount += 3 + object.officeHead.length * 3;
  bytesCount += 3 + object.officeHeadDesignation.length * 3;
  bytesCount += 3 + object.sapId.length * 3;
  return bytesCount;
}

void _employeeSerialize(
  Employee object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.designation);
  writer.writeString(offsets[2], object.employeeName);
  writer.writeString(offsets[3], object.office);
  writer.writeString(offsets[4], object.officeHead);
  writer.writeString(offsets[5], object.officeHeadDesignation);
  writer.writeString(offsets[6], object.sapId);
  writer.writeDateTime(offsets[7], object.updatedAt);
}

Employee _employeeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Employee();
  object.createdAt = reader.readDateTime(offsets[0]);
  object.designation = reader.readString(offsets[1]);
  object.employeeName = reader.readString(offsets[2]);
  object.id = id;
  object.office = reader.readString(offsets[3]);
  object.officeHead = reader.readString(offsets[4]);
  object.officeHeadDesignation = reader.readString(offsets[5]);
  object.sapId = reader.readString(offsets[6]);
  object.updatedAt = reader.readDateTime(offsets[7]);
  return object;
}

P _employeeDeserializeProp<P>(
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
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _employeeGetId(Employee object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _employeeGetLinks(Employee object) {
  return [];
}

void _employeeAttach(IsarCollection<dynamic> col, Id id, Employee object) {
  object.id = id;
}

extension EmployeeQueryWhereSort on QueryBuilder<Employee, Employee, QWhere> {
  QueryBuilder<Employee, Employee, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension EmployeeQueryWhere on QueryBuilder<Employee, Employee, QWhereClause> {
  QueryBuilder<Employee, Employee, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Employee, Employee, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Employee, Employee, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Employee, Employee, QAfterWhereClause> idBetween(
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

extension EmployeeQueryFilter
    on QueryBuilder<Employee, Employee, QFilterCondition> {
  QueryBuilder<Employee, Employee, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<Employee, Employee, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<Employee, Employee, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      designationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'designation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'designation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'designation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> designationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'designation',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      designationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'designation',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> employeeNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      employeeNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> employeeNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> employeeNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'employeeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      employeeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> employeeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> employeeNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'employeeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> employeeNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'employeeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      employeeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'employeeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      employeeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'employeeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Employee, Employee, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Employee, Employee, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'office',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'office',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'office',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'office',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'office',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'office',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'office',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'office',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'office',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'office',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officeHead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'officeHead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'officeHead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'officeHead',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'officeHead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'officeHead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'officeHead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'officeHead',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> officeHeadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officeHead',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'officeHead',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officeHeadDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'officeHeadDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'officeHeadDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'officeHeadDesignation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'officeHeadDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'officeHeadDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'officeHeadDesignation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'officeHeadDesignation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'officeHeadDesignation',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition>
      officeHeadDesignationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'officeHeadDesignation',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sapId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sapId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sapId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sapId',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> sapIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sapId',
        value: '',
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<Employee, Employee, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension EmployeeQueryObject
    on QueryBuilder<Employee, Employee, QFilterCondition> {}

extension EmployeeQueryLinks
    on QueryBuilder<Employee, Employee, QFilterCondition> {}

extension EmployeeQuerySortBy on QueryBuilder<Employee, Employee, QSortBy> {
  QueryBuilder<Employee, Employee, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByEmployeeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByEmployeeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByOffice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'office', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByOfficeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'office', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByOfficeHead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHead', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByOfficeHeadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHead', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByOfficeHeadDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHeadDesignation', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy>
      sortByOfficeHeadDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHeadDesignation', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortBySapId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapId', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortBySapIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapId', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmployeeQuerySortThenBy
    on QueryBuilder<Employee, Employee, QSortThenBy> {
  QueryBuilder<Employee, Employee, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'designation', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByEmployeeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByEmployeeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'employeeName', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByOffice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'office', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByOfficeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'office', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByOfficeHead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHead', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByOfficeHeadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHead', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByOfficeHeadDesignation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHeadDesignation', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy>
      thenByOfficeHeadDesignationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'officeHeadDesignation', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenBySapId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapId', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenBySapIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapId', Sort.desc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<Employee, Employee, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension EmployeeQueryWhereDistinct
    on QueryBuilder<Employee, Employee, QDistinct> {
  QueryBuilder<Employee, Employee, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<Employee, Employee, QDistinct> distinctByDesignation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'designation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Employee, Employee, QDistinct> distinctByEmployeeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'employeeName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Employee, Employee, QDistinct> distinctByOffice(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'office', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Employee, Employee, QDistinct> distinctByOfficeHead(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'officeHead', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Employee, Employee, QDistinct> distinctByOfficeHeadDesignation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'officeHeadDesignation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Employee, Employee, QDistinct> distinctBySapId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sapId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Employee, Employee, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension EmployeeQueryProperty
    on QueryBuilder<Employee, Employee, QQueryProperty> {
  QueryBuilder<Employee, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Employee, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<Employee, String, QQueryOperations> designationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'designation');
    });
  }

  QueryBuilder<Employee, String, QQueryOperations> employeeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'employeeName');
    });
  }

  QueryBuilder<Employee, String, QQueryOperations> officeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'office');
    });
  }

  QueryBuilder<Employee, String, QQueryOperations> officeHeadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'officeHead');
    });
  }

  QueryBuilder<Employee, String, QQueryOperations>
      officeHeadDesignationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'officeHeadDesignation');
    });
  }

  QueryBuilder<Employee, String, QQueryOperations> sapIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sapId');
    });
  }

  QueryBuilder<Employee, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
