// lib/features/procurement/models/purchase_requisition.dart

import 'package:isar/isar.dart';

part 'purchase_requisition.g.dart';

@collection
class PurchaseRequisition {
  Id id = Isar.autoIncrement;

  @Index()
  late String prNumber; // Generated locally, synced with SAP later

  @Index()
  late String documentType; // ZFLD, ZTPS, ZIND, etc.

  late DateTime? documentDate;
  late DateTime? createdAt;
  late DateTime? updatedAt;

  late String purchaseOrganization; // Always 1000 for UPPTCL
  late String purchasingGroup;

  String? requisitioner;
  String? trackingNumber;

  @enumerated
  late PRStatus status;

  late String createdBy;
  String? approvedBy;
  DateTime? approvedAt;

  // Workflow tracking
  @enumerated
  late WorkflowStage currentStage;

  String? rfqNumber; // ZP/ZC after RFQ creation
  String? contractNumber; // After contract creation
  String? poNumber; // Purchase order if applicable

  // Custom fields
  String? nitNumber;
  String? tenderNumber;
  DateTime? tenderDate;
  String? natureOfTender;
  String? statusOfTender;

  bool isSynced;
  String? sapPrNumber; // SAP PR number after sync

  // JSON export metadata
  bool isExported;
  DateTime? exportedAt;
  String? exportFilePath;

  // Header-level defaults for line items
  String? glAccount; // G/L Account (General Ledger)
  String? division; // Division (Fund Center)

  PurchaseRequisition({
    this.prNumber = '',
    this.documentType = 'ZFLD',
    DateTime? documentDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.purchaseOrganization = '1000',
    this.purchasingGroup = '',
    this.requisitioner,
    this.trackingNumber,
    this.status = PRStatus.draft,
    this.createdBy = '',
    this.approvedBy,
    this.approvedAt,
    this.currentStage = WorkflowStage.prCreation,
    this.rfqNumber,
    this.contractNumber,
    this.poNumber,
    this.nitNumber,
    this.tenderNumber,
    this.tenderDate,
    this.natureOfTender,
    this.statusOfTender,
    this.isSynced = false,
    this.sapPrNumber,
    this.isExported = false,
    this.exportedAt,
    this.exportFilePath,
    this.glAccount,
    this.division,
  }) : documentDate = documentDate ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  // Default constructor for Isar
  PurchaseRequisition.empty()
    : prNumber = '',
      documentType = 'ZFLD',
      documentDate = DateTime.now(),
      createdAt = DateTime.now(),
      updatedAt = DateTime.now(),
      purchaseOrganization = '1000',
      purchasingGroup = '',
      status = PRStatus.draft,
      createdBy = '',
      currentStage = WorkflowStage.prCreation,
      isSynced = false,
      isExported = false;

  String get displayNumber => sapPrNumber ?? prNumber;

  String get documentTypeDescription {
    switch (documentType) {
      case 'ZFLD':
        return 'Field Indent';
      case 'ZTPS':
        return 'Turnkey Indent';
      case 'ZIND':
        return 'Standard Indent';
      case 'ZCAE':
        return 'AE Consolidation';
      case 'ZCEE':
        return 'EE Consolidation';
      case 'ZCSE':
        return 'SE Consolidation';
      case 'ZCCE':
        return 'CE Consolidation';
      case 'ZCFR':
        return 'Final Consolidated PR';
      case 'ZHPR':
        return 'HQ/Zone/Circle Purchase PR';
      case 'ZSBI':
        return 'Subcontracting PR';
      case 'ZSTR':
        return 'Stock Transfer PR';
      default:
        return documentType;
    }
  }
}

enum PRStatus {
  draft,
  submitted,
  pendingApproval,
  approved,
  rejected,
  rfqCreated,
  contractCreated,
  completed,
  cancelled,
}

enum WorkflowStage {
  prCreation,
  prApproval,
  rfqParentCreation,
  rfqChildCreation,
  quotationEntry,
  comparativeStatement,
  contractCreation,
  deliveryInspection,
  completed,
}

@collection
class PRLineItem {
  Id id = Isar.autoIncrement;

  @Index()
  late String prNumber;

  late int itemNumber; // 10, 20, 30, etc.

  String? material; // Material code
  late String shortText;

  late double quantity;
  late String unit; // M, EA, AU, etc.

  late double valuationPrice;
  late String currency;

  @ignore
  double get totalValue => quantity * valuationPrice;

  late String plant;
  String? storageLocation;
  late String materialGroup;

  // Account Assignment
  late String accountAssignmentCategory; // Blank, A (Asset), K (Cost Center)
  String? itemCategory; // Blank (Standard), D (Service)

  // For Account Assignment Category = A (Asset)
  String? assetNumber;
  String? assetSubNumber;

  // For Account Assignment Category = K (Cost Center)
  String? costCenter;
  String? glAccount;
  String? wbsElement;

  // For services (Item Category = D)
  List<ServiceLine> serviceLines;

  // Valuation
  String? valuationType; // NEW, DAMAGED, REFURBISHED, SCRAP

  late DateTime? deliveryDate;

  String? trackingNumber;
  String? requisitioner;

  bool isDeleted;

  PRLineItem({
    this.prNumber = '',
    this.itemNumber = 10,
    this.material,
    this.shortText = '',
    this.quantity = 0.0,
    this.unit = 'EA',
    this.valuationPrice = 0.0,
    this.currency = 'INR',
    this.plant = '',
    this.storageLocation,
    this.materialGroup = '',
    this.accountAssignmentCategory = '',
    this.itemCategory = '',
    this.assetNumber,
    this.assetSubNumber,
    this.costCenter,
    this.glAccount,
    this.wbsElement,
    this.serviceLines = const [],
    this.valuationType,
    DateTime? deliveryDate,
    this.trackingNumber,
    this.requisitioner,
    this.isDeleted = false,
  }) : deliveryDate =
           deliveryDate ?? DateTime.now().add(const Duration(days: 30));

  // Default constructor for Isar
  PRLineItem.empty()
    : prNumber = '',
      itemNumber = 10,
      shortText = '',
      quantity = 0.0,
      unit = 'EA',
      valuationPrice = 0.0,
      currency = 'INR',
      plant = '',
      materialGroup = '',
      accountAssignmentCategory = '',
      serviceLines = [],
      deliveryDate = DateTime.now(),
      isDeleted = false;

  @ignore
  bool get isService => itemCategory == 'D';

  @ignore
  bool get isAsset => accountAssignmentCategory == 'A';

  @ignore
  bool get isCostCenter => accountAssignmentCategory == 'K';
}

@embedded
class ServiceLine {
  late int lineNumber;
  late String serviceNumber;
  late String shortText;
  late double quantity;
  late String unit;
  late double grossPrice;
  late String currency;
  late String costCenter;

  DateTime? scheduleDate;

  @ignore
  double get totalValue => quantity * grossPrice;

  ServiceLine({
    this.lineNumber = 10,
    this.serviceNumber = '',
    this.shortText = '',
    this.quantity = 1.0,
    this.unit = 'AU',
    this.grossPrice = 0.0,
    this.currency = 'INR',
    this.costCenter = '',
    this.scheduleDate,
  });

  // Default constructor for Isar
  ServiceLine.empty()
    : lineNumber = 10,
      serviceNumber = '',
      shortText = '',
      quantity = 1.0,
      unit = 'AU',
      grossPrice = 0.0,
      currency = 'INR',
      costCenter = '';
}

// ============================================================================
// WORKFLOW CONFIGURATION MODELS (for JSON export - not stored in Isar)
// ============================================================================

class WorkflowConfiguration {
  final String workflowId;
  final String version;
  final String description;
  final SAPConnection sapConnection;
  final AutomationConfig configuration;
  final List<WorkflowStep> steps;
  final ErrorHandling errorHandling;

  WorkflowConfiguration({
    required this.workflowId,
    required this.version,
    required this.description,
    required this.sapConnection,
    required this.configuration,
    required this.steps,
    required this.errorHandling,
  });

  Map<String, dynamic> toJson() {
    return {
      'workflow_id': workflowId,
      'version': version,
      'description': description,
      'sap_connection': sapConnection.toJson(),
      'configuration': configuration.toJson(),
      'steps': steps.map((step) => step.toJson()).toList(),
      'error_handling': errorHandling.toJson(),
    };
  }
}

class SAPConnection {
  final String system;
  final String client;
  final String language;

  SAPConnection({
    required this.system,
    required this.client,
    required this.language,
  });

  Map<String, dynamic> toJson() {
    return {'system': system, 'client': client, 'language': language};
  }
}

class AutomationConfig {
  final double typingSpeed;
  final int screenWait;
  final int retryCount;

  AutomationConfig({
    this.typingSpeed = 0.01,
    this.screenWait = 2,
    this.retryCount = 3,
  });

  Map<String, dynamic> toJson() {
    return {
      'typing_speed': typingSpeed,
      'screen_wait': screenWait,
      'retry_count': retryCount,
    };
  }
}

class WorkflowStep {
  final int stepId;
  final String action;
  final String? tcode;
  final String? screenName;
  final List<FieldMapping>? fields;
  final ScreenTransition? screenTransition;
  final List<KeyboardAction>? keys;
  final int waitAfter;
  final CaptureOutput? captureOutput;

  WorkflowStep({
    required this.stepId,
    required this.action,
    this.tcode,
    this.screenName,
    this.fields,
    this.screenTransition,
    this.keys,
    this.waitAfter = 2,
    this.captureOutput,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'step_id': stepId,
      'action': action,
      'wait_after': waitAfter,
    };

    if (tcode != null) json['tcode'] = tcode;
    if (screenName != null) json['screen_name'] = screenName;
    if (fields != null) {
      json['fields'] = fields!.map((f) => f.toJson()).toList();
    }
    if (screenTransition != null) {
      json['screen_transition'] = screenTransition!.toJson();
    }
    if (keys != null) {
      json['keys'] = keys!.map((k) => k.toJson()).toList();
    }
    if (captureOutput != null) {
      json['capture_output'] = captureOutput!.toJson();
    }

    return json;
  }
}

class FieldMapping {
  final String fieldName;
  final String csvColumn;
  final String navigation;
  final int? tabCount;
  final bool required;
  final int waitAfter;

  FieldMapping({
    required this.fieldName,
    required this.csvColumn,
    this.navigation = 'direct',
    this.tabCount,
    this.required = false,
    this.waitAfter = 2,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'field_name': fieldName,
      'csv_column': csvColumn,
      'navigation': navigation,
      'required': required,
      'wait_after': waitAfter,
    };

    if (tabCount != null) json['tab_count'] = tabCount;

    return json;
  }
}

class ScreenTransition {
  final String type;
  final String key;
  final int waitAfter;

  ScreenTransition({required this.type, required this.key, this.waitAfter = 2});

  Map<String, dynamic> toJson() {
    return {'type': type, 'key': key, 'wait_after': waitAfter};
  }
}

class KeyboardAction {
  final String type; // 'hotkey' or 'press'
  final List<String>? keys; // for hotkey
  final String? key; // for press

  KeyboardAction({required this.type, this.keys, this.key});

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{'type': type};
    if (keys != null) json['keys'] = keys;
    if (key != null) json['key'] = key;
    return json;
  }
}

class CaptureOutput {
  final String variable;
  final String method;

  CaptureOutput({required this.variable, required this.method});

  Map<String, dynamic> toJson() {
    return {'variable': variable, 'method': method};
  }
}

class ErrorHandling {
  final bool screenshotOnError;
  final String logFile;
  final bool retryOnFailure;

  ErrorHandling({
    this.screenshotOnError = true,
    this.logFile = 'automation_log.txt',
    this.retryOnFailure = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'screenshot_on_error': screenshotOnError,
      'log_file': logFile,
      'retry_on_failure': retryOnFailure,
    };
  }
}
