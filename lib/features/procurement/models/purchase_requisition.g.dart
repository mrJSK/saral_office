// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase_requisition.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPurchaseRequisitionCollection on Isar {
  IsarCollection<PurchaseRequisition> get purchaseRequisitions =>
      this.collection();
}

const PurchaseRequisitionSchema = CollectionSchema(
  name: r'PurchaseRequisition',
  id: -5117236789491704955,
  properties: {
    r'approvedAt': PropertySchema(
      id: 0,
      name: r'approvedAt',
      type: IsarType.dateTime,
    ),
    r'approvedBy': PropertySchema(
      id: 1,
      name: r'approvedBy',
      type: IsarType.string,
    ),
    r'contractNumber': PropertySchema(
      id: 2,
      name: r'contractNumber',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 3,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'createdBy': PropertySchema(
      id: 4,
      name: r'createdBy',
      type: IsarType.string,
    ),
    r'currentStage': PropertySchema(
      id: 5,
      name: r'currentStage',
      type: IsarType.byte,
      enumMap: _PurchaseRequisitioncurrentStageEnumValueMap,
    ),
    r'displayNumber': PropertySchema(
      id: 6,
      name: r'displayNumber',
      type: IsarType.string,
    ),
    r'documentDate': PropertySchema(
      id: 7,
      name: r'documentDate',
      type: IsarType.dateTime,
    ),
    r'documentType': PropertySchema(
      id: 8,
      name: r'documentType',
      type: IsarType.string,
    ),
    r'documentTypeDescription': PropertySchema(
      id: 9,
      name: r'documentTypeDescription',
      type: IsarType.string,
    ),
    r'exportFilePath': PropertySchema(
      id: 10,
      name: r'exportFilePath',
      type: IsarType.string,
    ),
    r'exportedAt': PropertySchema(
      id: 11,
      name: r'exportedAt',
      type: IsarType.dateTime,
    ),
    r'isExported': PropertySchema(
      id: 12,
      name: r'isExported',
      type: IsarType.bool,
    ),
    r'isSynced': PropertySchema(
      id: 13,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'natureOfTender': PropertySchema(
      id: 14,
      name: r'natureOfTender',
      type: IsarType.string,
    ),
    r'nitNumber': PropertySchema(
      id: 15,
      name: r'nitNumber',
      type: IsarType.string,
    ),
    r'poNumber': PropertySchema(
      id: 16,
      name: r'poNumber',
      type: IsarType.string,
    ),
    r'prNumber': PropertySchema(
      id: 17,
      name: r'prNumber',
      type: IsarType.string,
    ),
    r'purchaseOrganization': PropertySchema(
      id: 18,
      name: r'purchaseOrganization',
      type: IsarType.string,
    ),
    r'purchasingGroup': PropertySchema(
      id: 19,
      name: r'purchasingGroup',
      type: IsarType.string,
    ),
    r'requisitioner': PropertySchema(
      id: 20,
      name: r'requisitioner',
      type: IsarType.string,
    ),
    r'rfqNumber': PropertySchema(
      id: 21,
      name: r'rfqNumber',
      type: IsarType.string,
    ),
    r'sapPrNumber': PropertySchema(
      id: 22,
      name: r'sapPrNumber',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 23,
      name: r'status',
      type: IsarType.byte,
      enumMap: _PurchaseRequisitionstatusEnumValueMap,
    ),
    r'statusOfTender': PropertySchema(
      id: 24,
      name: r'statusOfTender',
      type: IsarType.string,
    ),
    r'tenderDate': PropertySchema(
      id: 25,
      name: r'tenderDate',
      type: IsarType.dateTime,
    ),
    r'tenderNumber': PropertySchema(
      id: 26,
      name: r'tenderNumber',
      type: IsarType.string,
    ),
    r'trackingNumber': PropertySchema(
      id: 27,
      name: r'trackingNumber',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 28,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _purchaseRequisitionEstimateSize,
  serialize: _purchaseRequisitionSerialize,
  deserialize: _purchaseRequisitionDeserialize,
  deserializeProp: _purchaseRequisitionDeserializeProp,
  idName: r'id',
  indexes: {
    r'prNumber': IndexSchema(
      id: 7883500502137973978,
      name: r'prNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'prNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'documentType': IndexSchema(
      id: -7718089256159393876,
      name: r'documentType',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'documentType',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _purchaseRequisitionGetId,
  getLinks: _purchaseRequisitionGetLinks,
  attach: _purchaseRequisitionAttach,
  version: '3.1.0+1',
);

int _purchaseRequisitionEstimateSize(
  PurchaseRequisition object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.approvedBy;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contractNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.createdBy.length * 3;
  bytesCount += 3 + object.displayNumber.length * 3;
  bytesCount += 3 + object.documentType.length * 3;
  bytesCount += 3 + object.documentTypeDescription.length * 3;
  {
    final value = object.exportFilePath;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.natureOfTender;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.nitNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.poNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.prNumber.length * 3;
  bytesCount += 3 + object.purchaseOrganization.length * 3;
  bytesCount += 3 + object.purchasingGroup.length * 3;
  {
    final value = object.requisitioner;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.rfqNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.sapPrNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.statusOfTender;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tenderNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.trackingNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _purchaseRequisitionSerialize(
  PurchaseRequisition object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.approvedAt);
  writer.writeString(offsets[1], object.approvedBy);
  writer.writeString(offsets[2], object.contractNumber);
  writer.writeDateTime(offsets[3], object.createdAt);
  writer.writeString(offsets[4], object.createdBy);
  writer.writeByte(offsets[5], object.currentStage.index);
  writer.writeString(offsets[6], object.displayNumber);
  writer.writeDateTime(offsets[7], object.documentDate);
  writer.writeString(offsets[8], object.documentType);
  writer.writeString(offsets[9], object.documentTypeDescription);
  writer.writeString(offsets[10], object.exportFilePath);
  writer.writeDateTime(offsets[11], object.exportedAt);
  writer.writeBool(offsets[12], object.isExported);
  writer.writeBool(offsets[13], object.isSynced);
  writer.writeString(offsets[14], object.natureOfTender);
  writer.writeString(offsets[15], object.nitNumber);
  writer.writeString(offsets[16], object.poNumber);
  writer.writeString(offsets[17], object.prNumber);
  writer.writeString(offsets[18], object.purchaseOrganization);
  writer.writeString(offsets[19], object.purchasingGroup);
  writer.writeString(offsets[20], object.requisitioner);
  writer.writeString(offsets[21], object.rfqNumber);
  writer.writeString(offsets[22], object.sapPrNumber);
  writer.writeByte(offsets[23], object.status.index);
  writer.writeString(offsets[24], object.statusOfTender);
  writer.writeDateTime(offsets[25], object.tenderDate);
  writer.writeString(offsets[26], object.tenderNumber);
  writer.writeString(offsets[27], object.trackingNumber);
  writer.writeDateTime(offsets[28], object.updatedAt);
}

PurchaseRequisition _purchaseRequisitionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PurchaseRequisition(
    approvedAt: reader.readDateTimeOrNull(offsets[0]),
    approvedBy: reader.readStringOrNull(offsets[1]),
    contractNumber: reader.readStringOrNull(offsets[2]),
    createdAt: reader.readDateTimeOrNull(offsets[3]),
    createdBy: reader.readStringOrNull(offsets[4]) ?? '',
    currentStage: _PurchaseRequisitioncurrentStageValueEnumMap[
            reader.readByteOrNull(offsets[5])] ??
        WorkflowStage.prCreation,
    documentDate: reader.readDateTimeOrNull(offsets[7]),
    documentType: reader.readStringOrNull(offsets[8]) ?? 'ZFLD',
    exportFilePath: reader.readStringOrNull(offsets[10]),
    exportedAt: reader.readDateTimeOrNull(offsets[11]),
    isExported: reader.readBoolOrNull(offsets[12]) ?? false,
    isSynced: reader.readBoolOrNull(offsets[13]) ?? false,
    natureOfTender: reader.readStringOrNull(offsets[14]),
    nitNumber: reader.readStringOrNull(offsets[15]),
    poNumber: reader.readStringOrNull(offsets[16]),
    prNumber: reader.readStringOrNull(offsets[17]) ?? '',
    purchaseOrganization: reader.readStringOrNull(offsets[18]) ?? '1000',
    purchasingGroup: reader.readStringOrNull(offsets[19]) ?? '',
    requisitioner: reader.readStringOrNull(offsets[20]),
    rfqNumber: reader.readStringOrNull(offsets[21]),
    sapPrNumber: reader.readStringOrNull(offsets[22]),
    status: _PurchaseRequisitionstatusValueEnumMap[
            reader.readByteOrNull(offsets[23])] ??
        PRStatus.draft,
    statusOfTender: reader.readStringOrNull(offsets[24]),
    tenderDate: reader.readDateTimeOrNull(offsets[25]),
    tenderNumber: reader.readStringOrNull(offsets[26]),
    trackingNumber: reader.readStringOrNull(offsets[27]),
    updatedAt: reader.readDateTimeOrNull(offsets[28]),
  );
  object.id = id;
  return object;
}

P _purchaseRequisitionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (_PurchaseRequisitioncurrentStageValueEnumMap[
              reader.readByteOrNull(offset)] ??
          WorkflowStage.prCreation) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? 'ZFLD') as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 13:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 18:
      return (reader.readStringOrNull(offset) ?? '1000') as P;
    case 19:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    case 21:
      return (reader.readStringOrNull(offset)) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (_PurchaseRequisitionstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PRStatus.draft) as P;
    case 24:
      return (reader.readStringOrNull(offset)) as P;
    case 25:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PurchaseRequisitioncurrentStageEnumValueMap = {
  'prCreation': 0,
  'prApproval': 1,
  'rfqParentCreation': 2,
  'rfqChildCreation': 3,
  'quotationEntry': 4,
  'comparativeStatement': 5,
  'contractCreation': 6,
  'deliveryInspection': 7,
  'completed': 8,
};
const _PurchaseRequisitioncurrentStageValueEnumMap = {
  0: WorkflowStage.prCreation,
  1: WorkflowStage.prApproval,
  2: WorkflowStage.rfqParentCreation,
  3: WorkflowStage.rfqChildCreation,
  4: WorkflowStage.quotationEntry,
  5: WorkflowStage.comparativeStatement,
  6: WorkflowStage.contractCreation,
  7: WorkflowStage.deliveryInspection,
  8: WorkflowStage.completed,
};
const _PurchaseRequisitionstatusEnumValueMap = {
  'draft': 0,
  'submitted': 1,
  'pendingApproval': 2,
  'approved': 3,
  'rejected': 4,
  'rfqCreated': 5,
  'contractCreated': 6,
  'completed': 7,
  'cancelled': 8,
};
const _PurchaseRequisitionstatusValueEnumMap = {
  0: PRStatus.draft,
  1: PRStatus.submitted,
  2: PRStatus.pendingApproval,
  3: PRStatus.approved,
  4: PRStatus.rejected,
  5: PRStatus.rfqCreated,
  6: PRStatus.contractCreated,
  7: PRStatus.completed,
  8: PRStatus.cancelled,
};

Id _purchaseRequisitionGetId(PurchaseRequisition object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _purchaseRequisitionGetLinks(
    PurchaseRequisition object) {
  return [];
}

void _purchaseRequisitionAttach(
    IsarCollection<dynamic> col, Id id, PurchaseRequisition object) {
  object.id = id;
}

extension PurchaseRequisitionQueryWhereSort
    on QueryBuilder<PurchaseRequisition, PurchaseRequisition, QWhere> {
  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PurchaseRequisitionQueryWhere
    on QueryBuilder<PurchaseRequisition, PurchaseRequisition, QWhereClause> {
  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      prNumberEqualTo(String prNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'prNumber',
        value: [prNumber],
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      prNumberNotEqualTo(String prNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [],
              upper: [prNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [prNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [prNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [],
              upper: [prNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      documentTypeEqualTo(String documentType) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'documentType',
        value: [documentType],
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterWhereClause>
      documentTypeNotEqualTo(String documentType) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentType',
              lower: [],
              upper: [documentType],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentType',
              lower: [documentType],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentType',
              lower: [documentType],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'documentType',
              lower: [],
              upper: [documentType],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PurchaseRequisitionQueryFilter on QueryBuilder<PurchaseRequisition,
    PurchaseRequisition, QFilterCondition> {
  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'approvedAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'approvedAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'approvedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'approvedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'approvedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'approvedBy',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'approvedBy',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'approvedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'approvedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'approvedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'approvedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'approvedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'approvedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'approvedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'approvedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      approvedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'approvedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contractNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contractNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contractNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contractNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contractNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contractNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contractNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contractNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contractNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contractNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contractNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      contractNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contractNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      createdByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdBy',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      currentStageEqualTo(WorkflowStage value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStage',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      currentStageGreaterThan(
    WorkflowStage value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStage',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      currentStageLessThan(
    WorkflowStage value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStage',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      currentStageBetween(
    WorkflowStage lower,
    WorkflowStage upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      displayNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'documentDate',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'documentDate',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentType',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentType',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentTypeDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentTypeDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentTypeDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentTypeDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentTypeDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentTypeDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentTypeDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentTypeDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentTypeDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      documentTypeDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentTypeDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exportFilePath',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exportFilePath',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exportFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exportFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exportFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exportFilePath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'exportFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'exportFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'exportFilePath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'exportFilePath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exportFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportFilePathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'exportFilePath',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'exportedAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'exportedAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exportedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exportedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exportedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      exportedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exportedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      isExportedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isExported',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      isSyncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'natureOfTender',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'natureOfTender',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'natureOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'natureOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'natureOfTender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'natureOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'natureOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'natureOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'natureOfTender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'natureOfTender',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      natureOfTenderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'natureOfTender',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nitNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nitNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nitNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nitNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nitNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nitNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nitNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nitNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nitNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nitNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nitNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      nitNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nitNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'poNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'poNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'poNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'poNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'poNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'poNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'poNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'poNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'poNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'poNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      poNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'poNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      prNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseOrganization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchaseOrganization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchaseOrganization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchaseOrganization',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'purchaseOrganization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'purchaseOrganization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'purchaseOrganization',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'purchaseOrganization',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchaseOrganization',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchaseOrganizationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'purchaseOrganization',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchasingGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'purchasingGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'purchasingGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'purchasingGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'purchasingGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'purchasingGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'purchasingGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'purchasingGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'purchasingGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      purchasingGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'purchasingGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requisitioner',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requisitioner',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requisitioner',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requisitioner',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requisitioner',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      requisitionerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requisitioner',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'rfqNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'rfqNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rfqNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'rfqNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'rfqNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'rfqNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'rfqNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'rfqNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'rfqNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'rfqNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'rfqNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      rfqNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'rfqNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sapPrNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sapPrNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sapPrNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sapPrNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sapPrNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sapPrNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sapPrNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sapPrNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sapPrNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sapPrNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sapPrNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      sapPrNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sapPrNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusEqualTo(PRStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusGreaterThan(
    PRStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusLessThan(
    PRStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusBetween(
    PRStatus lower,
    PRStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'statusOfTender',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'statusOfTender',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'statusOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'statusOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'statusOfTender',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'statusOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'statusOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'statusOfTender',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'statusOfTender',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'statusOfTender',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      statusOfTenderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'statusOfTender',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tenderDate',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tenderDate',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tenderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tenderDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tenderDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tenderNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tenderNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tenderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tenderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tenderNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tenderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tenderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tenderNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tenderNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenderNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      tenderNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tenderNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackingNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackingNumber',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackingNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackingNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      trackingNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackingNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      updatedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime? value, {
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

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterFilterCondition>
      updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
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

extension PurchaseRequisitionQueryObject on QueryBuilder<PurchaseRequisition,
    PurchaseRequisition, QFilterCondition> {}

extension PurchaseRequisitionQueryLinks on QueryBuilder<PurchaseRequisition,
    PurchaseRequisition, QFilterCondition> {}

extension PurchaseRequisitionQuerySortBy
    on QueryBuilder<PurchaseRequisition, PurchaseRequisition, QSortBy> {
  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByApprovedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByApprovedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedAt', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByApprovedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedBy', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByApprovedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedBy', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByContractNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByContractNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByCreatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByCreatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByCurrentStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStage', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByCurrentStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStage', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDisplayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDisplayNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDocumentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDate', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDocumentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDate', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDocumentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDocumentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDocumentTypeDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTypeDescription', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByDocumentTypeDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTypeDescription', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByExportFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportFilePath', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByExportFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportFilePath', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByExportedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByExportedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedAt', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByIsExported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExported', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByIsExportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExported', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByNatureOfTender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfTender', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByNatureOfTenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfTender', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByNitNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nitNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByNitNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nitNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPoNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPoNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPrNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPrNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPurchaseOrganization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrganization', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPurchaseOrganizationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrganization', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPurchasingGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasingGroup', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByPurchasingGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasingGroup', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByRequisitioner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByRequisitionerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByRfqNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rfqNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByRfqNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rfqNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortBySapPrNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapPrNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortBySapPrNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapPrNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByStatusOfTender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusOfTender', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByStatusOfTenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusOfTender', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByTenderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderDate', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByTenderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderDate', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByTenderNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByTenderNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByTrackingNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByTrackingNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension PurchaseRequisitionQuerySortThenBy
    on QueryBuilder<PurchaseRequisition, PurchaseRequisition, QSortThenBy> {
  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByApprovedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByApprovedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedAt', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByApprovedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedBy', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByApprovedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'approvedBy', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByContractNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByContractNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByCreatedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByCreatedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdBy', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByCurrentStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStage', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByCurrentStageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStage', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDisplayNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDisplayNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDocumentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDate', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDocumentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentDate', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDocumentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDocumentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentType', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDocumentTypeDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTypeDescription', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByDocumentTypeDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'documentTypeDescription', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByExportFilePath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportFilePath', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByExportFilePathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportFilePath', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByExportedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByExportedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exportedAt', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByIsExported() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExported', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByIsExportedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isExported', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByNatureOfTender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfTender', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByNatureOfTenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'natureOfTender', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByNitNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nitNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByNitNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nitNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPoNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPoNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'poNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPrNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPrNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPurchaseOrganization() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrganization', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPurchaseOrganizationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchaseOrganization', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPurchasingGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasingGroup', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByPurchasingGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'purchasingGroup', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByRequisitioner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByRequisitionerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByRfqNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rfqNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByRfqNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rfqNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenBySapPrNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapPrNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenBySapPrNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sapPrNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByStatusOfTender() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusOfTender', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByStatusOfTenderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'statusOfTender', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByTenderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderDate', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByTenderDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderDate', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByTenderNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByTenderNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenderNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByTrackingNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByTrackingNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.desc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QAfterSortBy>
      thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension PurchaseRequisitionQueryWhereDistinct
    on QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct> {
  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByApprovedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approvedAt');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByApprovedBy({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'approvedBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByContractNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contractNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByCreatedBy({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByCurrentStage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStage');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByDisplayNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByDocumentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentDate');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByDocumentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByDocumentTypeDescription({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentTypeDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByExportFilePath({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exportFilePath',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByExportedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exportedAt');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByIsExported() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isExported');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByNatureOfTender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'natureOfTender',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByNitNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nitNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByPoNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'poNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByPrNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByPurchaseOrganization({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchaseOrganization',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByPurchasingGroup({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'purchasingGroup',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByRequisitioner({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requisitioner',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByRfqNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rfqNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctBySapPrNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sapPrNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByStatusOfTender({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'statusOfTender',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByTenderDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tenderDate');
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByTenderNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tenderNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByTrackingNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackingNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseRequisition, PurchaseRequisition, QDistinct>
      distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension PurchaseRequisitionQueryProperty
    on QueryBuilder<PurchaseRequisition, PurchaseRequisition, QQueryProperty> {
  QueryBuilder<PurchaseRequisition, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PurchaseRequisition, DateTime?, QQueryOperations>
      approvedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approvedAt');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      approvedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'approvedBy');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      contractNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contractNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<PurchaseRequisition, String, QQueryOperations>
      createdByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdBy');
    });
  }

  QueryBuilder<PurchaseRequisition, WorkflowStage, QQueryOperations>
      currentStageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStage');
    });
  }

  QueryBuilder<PurchaseRequisition, String, QQueryOperations>
      displayNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, DateTime?, QQueryOperations>
      documentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentDate');
    });
  }

  QueryBuilder<PurchaseRequisition, String, QQueryOperations>
      documentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentType');
    });
  }

  QueryBuilder<PurchaseRequisition, String, QQueryOperations>
      documentTypeDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentTypeDescription');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      exportFilePathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exportFilePath');
    });
  }

  QueryBuilder<PurchaseRequisition, DateTime?, QQueryOperations>
      exportedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exportedAt');
    });
  }

  QueryBuilder<PurchaseRequisition, bool, QQueryOperations>
      isExportedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isExported');
    });
  }

  QueryBuilder<PurchaseRequisition, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      natureOfTenderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'natureOfTender');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      nitNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nitNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      poNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'poNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, String, QQueryOperations>
      prNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, String, QQueryOperations>
      purchaseOrganizationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchaseOrganization');
    });
  }

  QueryBuilder<PurchaseRequisition, String, QQueryOperations>
      purchasingGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'purchasingGroup');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      requisitionerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requisitioner');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      rfqNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rfqNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      sapPrNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sapPrNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, PRStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      statusOfTenderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'statusOfTender');
    });
  }

  QueryBuilder<PurchaseRequisition, DateTime?, QQueryOperations>
      tenderDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tenderDate');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      tenderNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tenderNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, String?, QQueryOperations>
      trackingNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackingNumber');
    });
  }

  QueryBuilder<PurchaseRequisition, DateTime?, QQueryOperations>
      updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPRLineItemCollection on Isar {
  IsarCollection<PRLineItem> get pRLineItems => this.collection();
}

const PRLineItemSchema = CollectionSchema(
  name: r'PRLineItem',
  id: -6137040917568921196,
  properties: {
    r'accountAssignmentCategory': PropertySchema(
      id: 0,
      name: r'accountAssignmentCategory',
      type: IsarType.string,
    ),
    r'assetNumber': PropertySchema(
      id: 1,
      name: r'assetNumber',
      type: IsarType.string,
    ),
    r'assetSubNumber': PropertySchema(
      id: 2,
      name: r'assetSubNumber',
      type: IsarType.string,
    ),
    r'costCenter': PropertySchema(
      id: 3,
      name: r'costCenter',
      type: IsarType.string,
    ),
    r'currency': PropertySchema(
      id: 4,
      name: r'currency',
      type: IsarType.string,
    ),
    r'deliveryDate': PropertySchema(
      id: 5,
      name: r'deliveryDate',
      type: IsarType.dateTime,
    ),
    r'glAccount': PropertySchema(
      id: 6,
      name: r'glAccount',
      type: IsarType.string,
    ),
    r'isDeleted': PropertySchema(
      id: 7,
      name: r'isDeleted',
      type: IsarType.bool,
    ),
    r'itemCategory': PropertySchema(
      id: 8,
      name: r'itemCategory',
      type: IsarType.string,
    ),
    r'itemNumber': PropertySchema(
      id: 9,
      name: r'itemNumber',
      type: IsarType.long,
    ),
    r'material': PropertySchema(
      id: 10,
      name: r'material',
      type: IsarType.string,
    ),
    r'materialGroup': PropertySchema(
      id: 11,
      name: r'materialGroup',
      type: IsarType.string,
    ),
    r'plant': PropertySchema(
      id: 12,
      name: r'plant',
      type: IsarType.string,
    ),
    r'prNumber': PropertySchema(
      id: 13,
      name: r'prNumber',
      type: IsarType.string,
    ),
    r'quantity': PropertySchema(
      id: 14,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'requisitioner': PropertySchema(
      id: 15,
      name: r'requisitioner',
      type: IsarType.string,
    ),
    r'serviceLines': PropertySchema(
      id: 16,
      name: r'serviceLines',
      type: IsarType.objectList,
      target: r'ServiceLine',
    ),
    r'shortText': PropertySchema(
      id: 17,
      name: r'shortText',
      type: IsarType.string,
    ),
    r'storageLocation': PropertySchema(
      id: 18,
      name: r'storageLocation',
      type: IsarType.string,
    ),
    r'trackingNumber': PropertySchema(
      id: 19,
      name: r'trackingNumber',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 20,
      name: r'unit',
      type: IsarType.string,
    ),
    r'valuationPrice': PropertySchema(
      id: 21,
      name: r'valuationPrice',
      type: IsarType.double,
    ),
    r'valuationType': PropertySchema(
      id: 22,
      name: r'valuationType',
      type: IsarType.string,
    ),
    r'wbsElement': PropertySchema(
      id: 23,
      name: r'wbsElement',
      type: IsarType.string,
    )
  },
  estimateSize: _pRLineItemEstimateSize,
  serialize: _pRLineItemSerialize,
  deserialize: _pRLineItemDeserialize,
  deserializeProp: _pRLineItemDeserializeProp,
  idName: r'id',
  indexes: {
    r'prNumber': IndexSchema(
      id: 7883500502137973978,
      name: r'prNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'prNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'ServiceLine': ServiceLineSchema},
  getId: _pRLineItemGetId,
  getLinks: _pRLineItemGetLinks,
  attach: _pRLineItemAttach,
  version: '3.1.0+1',
);

int _pRLineItemEstimateSize(
  PRLineItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.accountAssignmentCategory.length * 3;
  {
    final value = object.assetNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.assetSubNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.costCenter;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.currency.length * 3;
  {
    final value = object.glAccount;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.itemCategory;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.material;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.materialGroup.length * 3;
  bytesCount += 3 + object.plant.length * 3;
  bytesCount += 3 + object.prNumber.length * 3;
  {
    final value = object.requisitioner;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.serviceLines.length * 3;
  {
    final offsets = allOffsets[ServiceLine]!;
    for (var i = 0; i < object.serviceLines.length; i++) {
      final value = object.serviceLines[i];
      bytesCount += ServiceLineSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.shortText.length * 3;
  {
    final value = object.storageLocation;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.trackingNumber;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.unit.length * 3;
  {
    final value = object.valuationType;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.wbsElement;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _pRLineItemSerialize(
  PRLineItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountAssignmentCategory);
  writer.writeString(offsets[1], object.assetNumber);
  writer.writeString(offsets[2], object.assetSubNumber);
  writer.writeString(offsets[3], object.costCenter);
  writer.writeString(offsets[4], object.currency);
  writer.writeDateTime(offsets[5], object.deliveryDate);
  writer.writeString(offsets[6], object.glAccount);
  writer.writeBool(offsets[7], object.isDeleted);
  writer.writeString(offsets[8], object.itemCategory);
  writer.writeLong(offsets[9], object.itemNumber);
  writer.writeString(offsets[10], object.material);
  writer.writeString(offsets[11], object.materialGroup);
  writer.writeString(offsets[12], object.plant);
  writer.writeString(offsets[13], object.prNumber);
  writer.writeDouble(offsets[14], object.quantity);
  writer.writeString(offsets[15], object.requisitioner);
  writer.writeObjectList<ServiceLine>(
    offsets[16],
    allOffsets,
    ServiceLineSchema.serialize,
    object.serviceLines,
  );
  writer.writeString(offsets[17], object.shortText);
  writer.writeString(offsets[18], object.storageLocation);
  writer.writeString(offsets[19], object.trackingNumber);
  writer.writeString(offsets[20], object.unit);
  writer.writeDouble(offsets[21], object.valuationPrice);
  writer.writeString(offsets[22], object.valuationType);
  writer.writeString(offsets[23], object.wbsElement);
}

PRLineItem _pRLineItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PRLineItem(
    accountAssignmentCategory: reader.readStringOrNull(offsets[0]) ?? '',
    assetNumber: reader.readStringOrNull(offsets[1]),
    assetSubNumber: reader.readStringOrNull(offsets[2]),
    costCenter: reader.readStringOrNull(offsets[3]),
    currency: reader.readStringOrNull(offsets[4]) ?? 'INR',
    deliveryDate: reader.readDateTimeOrNull(offsets[5]),
    glAccount: reader.readStringOrNull(offsets[6]),
    isDeleted: reader.readBoolOrNull(offsets[7]) ?? false,
    itemCategory: reader.readStringOrNull(offsets[8]),
    itemNumber: reader.readLongOrNull(offsets[9]) ?? 10,
    material: reader.readStringOrNull(offsets[10]),
    materialGroup: reader.readStringOrNull(offsets[11]) ?? '',
    plant: reader.readStringOrNull(offsets[12]) ?? '',
    prNumber: reader.readStringOrNull(offsets[13]) ?? '',
    quantity: reader.readDoubleOrNull(offsets[14]) ?? 0.0,
    requisitioner: reader.readStringOrNull(offsets[15]),
    serviceLines: reader.readObjectList<ServiceLine>(
          offsets[16],
          ServiceLineSchema.deserialize,
          allOffsets,
          ServiceLine(),
        ) ??
        const [],
    shortText: reader.readStringOrNull(offsets[17]) ?? '',
    storageLocation: reader.readStringOrNull(offsets[18]),
    trackingNumber: reader.readStringOrNull(offsets[19]),
    unit: reader.readStringOrNull(offsets[20]) ?? 'EA',
    valuationPrice: reader.readDoubleOrNull(offsets[21]) ?? 0.0,
    valuationType: reader.readStringOrNull(offsets[22]),
    wbsElement: reader.readStringOrNull(offsets[23]),
  );
  object.id = id;
  return object;
}

P _pRLineItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? 'INR') as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 10) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 14:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readObjectList<ServiceLine>(
            offset,
            ServiceLineSchema.deserialize,
            allOffsets,
            ServiceLine(),
          ) ??
          const []) as P;
    case 17:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset) ?? 'EA') as P;
    case 21:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 22:
      return (reader.readStringOrNull(offset)) as P;
    case 23:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _pRLineItemGetId(PRLineItem object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pRLineItemGetLinks(PRLineItem object) {
  return [];
}

void _pRLineItemAttach(IsarCollection<dynamic> col, Id id, PRLineItem object) {
  object.id = id;
}

extension PRLineItemQueryWhereSort
    on QueryBuilder<PRLineItem, PRLineItem, QWhere> {
  QueryBuilder<PRLineItem, PRLineItem, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PRLineItemQueryWhere
    on QueryBuilder<PRLineItem, PRLineItem, QWhereClause> {
  QueryBuilder<PRLineItem, PRLineItem, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterWhereClause> idBetween(
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterWhereClause> prNumberEqualTo(
      String prNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'prNumber',
        value: [prNumber],
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterWhereClause> prNumberNotEqualTo(
      String prNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [],
              upper: [prNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [prNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [prNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'prNumber',
              lower: [],
              upper: [prNumber],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PRLineItemQueryFilter
    on QueryBuilder<PRLineItem, PRLineItem, QFilterCondition> {
  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountAssignmentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountAssignmentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountAssignmentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountAssignmentCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountAssignmentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountAssignmentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountAssignmentCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountAssignmentCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountAssignmentCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      accountAssignmentCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountAssignmentCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'assetNumber',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'assetNumber',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assetNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assetNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assetNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assetNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assetNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assetNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assetNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assetNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'assetSubNumber',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'assetSubNumber',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetSubNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assetSubNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assetSubNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assetSubNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assetSubNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assetSubNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assetSubNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assetSubNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assetSubNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      assetSubNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assetSubNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'costCenter',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'costCenter',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> costCenterEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> costCenterBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costCenter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> costCenterMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'costCenter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      costCenterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'costCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> currencyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> currencyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      deliveryDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deliveryDate',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      deliveryDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deliveryDate',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      deliveryDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      deliveryDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      deliveryDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      deliveryDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      glAccountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'glAccount',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      glAccountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'glAccount',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> glAccountEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      glAccountGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'glAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> glAccountLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'glAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> glAccountBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'glAccount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      glAccountStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'glAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> glAccountEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'glAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> glAccountContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'glAccount',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> glAccountMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'glAccount',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      glAccountIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'glAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      glAccountIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'glAccount',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> idBetween(
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> isDeletedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isDeleted',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'itemCategory',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'itemCategory',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemCategory',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'itemCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'itemCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'itemCategory',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'itemCategory',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemCategoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'itemCategory',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> itemNumberEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      itemNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> itemNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> materialIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'material',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'material',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> materialEqualTo(
    String? value, {
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGreaterThan(
    String? value, {
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> materialLessThan(
    String? value, {
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> materialBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> materialEndsWith(
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

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> materialContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'material',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> materialMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'material',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'material',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'material',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materialGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'materialGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'materialGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'materialGroup',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'materialGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'materialGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'materialGroup',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'materialGroup',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'materialGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      materialGroupIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'materialGroup',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plant',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'plant',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'plant',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> plantIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plant',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      plantIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'plant',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> prNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      prNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> prNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> prNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      prNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> prNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> prNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'prNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> prNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'prNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      prNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      prNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'prNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requisitioner',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requisitioner',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requisitioner',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requisitioner',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requisitioner',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requisitioner',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      requisitionerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requisitioner',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      serviceLinesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'serviceLines',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      serviceLinesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'serviceLines',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      serviceLinesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'serviceLines',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      serviceLinesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'serviceLines',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      serviceLinesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'serviceLines',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      serviceLinesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'serviceLines',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> shortTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      shortTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> shortTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> shortTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      shortTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> shortTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> shortTextContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> shortTextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      shortTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortText',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      shortTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortText',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'storageLocation',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'storageLocation',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storageLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'storageLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'storageLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'storageLocation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'storageLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'storageLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'storageLocation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'storageLocation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'storageLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      storageLocationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'storageLocation',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'trackingNumber',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'trackingNumber',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'trackingNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'trackingNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'trackingNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'trackingNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      trackingNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'trackingNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valuationPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valuationPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valuationPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valuationPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'valuationType',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'valuationType',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valuationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'valuationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'valuationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'valuationType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'valuationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'valuationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'valuationType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'valuationType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'valuationType',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      valuationTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'valuationType',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'wbsElement',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'wbsElement',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> wbsElementEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wbsElement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'wbsElement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'wbsElement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> wbsElementBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'wbsElement',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'wbsElement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'wbsElement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'wbsElement',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition> wbsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'wbsElement',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'wbsElement',
        value: '',
      ));
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      wbsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'wbsElement',
        value: '',
      ));
    });
  }
}

extension PRLineItemQueryObject
    on QueryBuilder<PRLineItem, PRLineItem, QFilterCondition> {
  QueryBuilder<PRLineItem, PRLineItem, QAfterFilterCondition>
      serviceLinesElement(FilterQuery<ServiceLine> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'serviceLines');
    });
  }
}

extension PRLineItemQueryLinks
    on QueryBuilder<PRLineItem, PRLineItem, QFilterCondition> {}

extension PRLineItemQuerySortBy
    on QueryBuilder<PRLineItem, PRLineItem, QSortBy> {
  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      sortByAccountAssignmentCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountAssignmentCategory', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      sortByAccountAssignmentCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountAssignmentCategory', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByAssetNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByAssetNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByAssetSubNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetSubNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      sortByAssetSubNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetSubNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByCostCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costCenter', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByCostCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costCenter', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByDeliveryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByGlAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByGlAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByItemCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemCategory', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByItemCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemCategory', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByItemNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByItemNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByMaterialGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByMaterialGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByPlant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByPlantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByPrNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByPrNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByRequisitioner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByRequisitionerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByShortText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortText', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByShortTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortText', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByStorageLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageLocation', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      sortByStorageLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageLocation', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByTrackingNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      sortByTrackingNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByValuationPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationPrice', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      sortByValuationPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationPrice', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByValuationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationType', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByValuationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationType', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByWbsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wbsElement', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> sortByWbsElementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wbsElement', Sort.desc);
    });
  }
}

extension PRLineItemQuerySortThenBy
    on QueryBuilder<PRLineItem, PRLineItem, QSortThenBy> {
  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      thenByAccountAssignmentCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountAssignmentCategory', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      thenByAccountAssignmentCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountAssignmentCategory', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByAssetNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByAssetNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByAssetSubNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetSubNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      thenByAssetSubNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assetSubNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByCostCenter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costCenter', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByCostCenterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'costCenter', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByCurrency() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByCurrencyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currency', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByDeliveryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByGlAccount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByGlAccountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'glAccount', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByIsDeletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isDeleted', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByItemCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemCategory', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByItemCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemCategory', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByItemNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByItemNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByMaterial() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByMaterialDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'material', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByMaterialGroup() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByMaterialGroupDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'materialGroup', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByPlant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByPlantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plant', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByPrNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByPrNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByRequisitioner() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByRequisitionerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requisitioner', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByShortText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortText', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByShortTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shortText', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByStorageLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageLocation', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      thenByStorageLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'storageLocation', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByTrackingNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      thenByTrackingNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'trackingNumber', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByUnit() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByUnitDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unit', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByValuationPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationPrice', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy>
      thenByValuationPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationPrice', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByValuationType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationType', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByValuationTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'valuationType', Sort.desc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByWbsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wbsElement', Sort.asc);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QAfterSortBy> thenByWbsElementDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wbsElement', Sort.desc);
    });
  }
}

extension PRLineItemQueryWhereDistinct
    on QueryBuilder<PRLineItem, PRLineItem, QDistinct> {
  QueryBuilder<PRLineItem, PRLineItem, QDistinct>
      distinctByAccountAssignmentCategory({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountAssignmentCategory',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByAssetNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assetNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByAssetSubNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assetSubNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByCostCenter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'costCenter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByCurrency(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currency', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryDate');
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByGlAccount(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'glAccount', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByIsDeleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isDeleted');
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByItemCategory(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemCategory', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByItemNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemNumber');
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByMaterial(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'material', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByMaterialGroup(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'materialGroup',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByPlant(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plant', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByPrNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByRequisitioner(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requisitioner',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByShortText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shortText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByStorageLocation(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'storageLocation',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByTrackingNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'trackingNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByUnit(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unit', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByValuationPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valuationPrice');
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByValuationType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'valuationType',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PRLineItem, PRLineItem, QDistinct> distinctByWbsElement(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wbsElement', caseSensitive: caseSensitive);
    });
  }
}

extension PRLineItemQueryProperty
    on QueryBuilder<PRLineItem, PRLineItem, QQueryProperty> {
  QueryBuilder<PRLineItem, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PRLineItem, String, QQueryOperations>
      accountAssignmentCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountAssignmentCategory');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> assetNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assetNumber');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> assetSubNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assetSubNumber');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> costCenterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'costCenter');
    });
  }

  QueryBuilder<PRLineItem, String, QQueryOperations> currencyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currency');
    });
  }

  QueryBuilder<PRLineItem, DateTime?, QQueryOperations> deliveryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryDate');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> glAccountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'glAccount');
    });
  }

  QueryBuilder<PRLineItem, bool, QQueryOperations> isDeletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isDeleted');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> itemCategoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemCategory');
    });
  }

  QueryBuilder<PRLineItem, int, QQueryOperations> itemNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemNumber');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> materialProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'material');
    });
  }

  QueryBuilder<PRLineItem, String, QQueryOperations> materialGroupProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'materialGroup');
    });
  }

  QueryBuilder<PRLineItem, String, QQueryOperations> plantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plant');
    });
  }

  QueryBuilder<PRLineItem, String, QQueryOperations> prNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prNumber');
    });
  }

  QueryBuilder<PRLineItem, double, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> requisitionerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requisitioner');
    });
  }

  QueryBuilder<PRLineItem, List<ServiceLine>, QQueryOperations>
      serviceLinesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serviceLines');
    });
  }

  QueryBuilder<PRLineItem, String, QQueryOperations> shortTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shortText');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations>
      storageLocationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'storageLocation');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> trackingNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'trackingNumber');
    });
  }

  QueryBuilder<PRLineItem, String, QQueryOperations> unitProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unit');
    });
  }

  QueryBuilder<PRLineItem, double, QQueryOperations> valuationPriceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valuationPrice');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> valuationTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'valuationType');
    });
  }

  QueryBuilder<PRLineItem, String?, QQueryOperations> wbsElementProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wbsElement');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ServiceLineSchema = Schema(
  name: r'ServiceLine',
  id: 5281211259577953302,
  properties: {
    r'costCenter': PropertySchema(
      id: 0,
      name: r'costCenter',
      type: IsarType.string,
    ),
    r'currency': PropertySchema(
      id: 1,
      name: r'currency',
      type: IsarType.string,
    ),
    r'grossPrice': PropertySchema(
      id: 2,
      name: r'grossPrice',
      type: IsarType.double,
    ),
    r'lineNumber': PropertySchema(
      id: 3,
      name: r'lineNumber',
      type: IsarType.long,
    ),
    r'quantity': PropertySchema(
      id: 4,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'scheduleDate': PropertySchema(
      id: 5,
      name: r'scheduleDate',
      type: IsarType.dateTime,
    ),
    r'serviceNumber': PropertySchema(
      id: 6,
      name: r'serviceNumber',
      type: IsarType.string,
    ),
    r'shortText': PropertySchema(
      id: 7,
      name: r'shortText',
      type: IsarType.string,
    ),
    r'unit': PropertySchema(
      id: 8,
      name: r'unit',
      type: IsarType.string,
    )
  },
  estimateSize: _serviceLineEstimateSize,
  serialize: _serviceLineSerialize,
  deserialize: _serviceLineDeserialize,
  deserializeProp: _serviceLineDeserializeProp,
);

int _serviceLineEstimateSize(
  ServiceLine object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.costCenter.length * 3;
  bytesCount += 3 + object.currency.length * 3;
  bytesCount += 3 + object.serviceNumber.length * 3;
  bytesCount += 3 + object.shortText.length * 3;
  bytesCount += 3 + object.unit.length * 3;
  return bytesCount;
}

void _serviceLineSerialize(
  ServiceLine object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.costCenter);
  writer.writeString(offsets[1], object.currency);
  writer.writeDouble(offsets[2], object.grossPrice);
  writer.writeLong(offsets[3], object.lineNumber);
  writer.writeDouble(offsets[4], object.quantity);
  writer.writeDateTime(offsets[5], object.scheduleDate);
  writer.writeString(offsets[6], object.serviceNumber);
  writer.writeString(offsets[7], object.shortText);
  writer.writeString(offsets[8], object.unit);
}

ServiceLine _serviceLineDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ServiceLine(
    costCenter: reader.readStringOrNull(offsets[0]) ?? '',
    currency: reader.readStringOrNull(offsets[1]) ?? 'INR',
    grossPrice: reader.readDoubleOrNull(offsets[2]) ?? 0.0,
    lineNumber: reader.readLongOrNull(offsets[3]) ?? 10,
    quantity: reader.readDoubleOrNull(offsets[4]) ?? 1.0,
    scheduleDate: reader.readDateTimeOrNull(offsets[5]),
    serviceNumber: reader.readStringOrNull(offsets[6]) ?? '',
    shortText: reader.readStringOrNull(offsets[7]) ?? '',
    unit: reader.readStringOrNull(offsets[8]) ?? 'AU',
  );
  return object;
}

P _serviceLineDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? 'INR') as P;
    case 2:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 10) as P;
    case 4:
      return (reader.readDoubleOrNull(offset) ?? 1.0) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? 'AU') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ServiceLineQueryFilter
    on QueryBuilder<ServiceLine, ServiceLine, QFilterCondition> {
  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'costCenter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'costCenter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'costCenter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'costCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      costCenterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'costCenter',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> currencyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      currencyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      currencyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> currencyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currency',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      currencyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      currencyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      currencyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'currency',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> currencyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'currency',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      currencyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      currencyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'currency',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      grossPriceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'grossPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      grossPriceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'grossPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      grossPriceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'grossPrice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      grossPriceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'grossPrice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      lineNumberEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      lineNumberGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      lineNumberLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lineNumber',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      lineNumberBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lineNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> quantityEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      quantityGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      quantityLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> quantityBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      scheduleDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'scheduleDate',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      scheduleDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'scheduleDate',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      scheduleDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      scheduleDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      scheduleDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduleDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      scheduleDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduleDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serviceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serviceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serviceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serviceNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serviceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serviceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serviceNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serviceNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serviceNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      serviceNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serviceNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shortText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'shortText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'shortText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shortText',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      shortTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'shortText',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unit',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unit',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unit',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition> unitIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unit',
        value: '',
      ));
    });
  }

  QueryBuilder<ServiceLine, ServiceLine, QAfterFilterCondition>
      unitIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unit',
        value: '',
      ));
    });
  }
}

extension ServiceLineQueryObject
    on QueryBuilder<ServiceLine, ServiceLine, QFilterCondition> {}
