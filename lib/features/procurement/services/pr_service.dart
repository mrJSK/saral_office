// lib/features/procurement/services/pr_service.dart

import 'dart:convert';
import 'dart:io';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:saral_office/core/database/services/isar_service.dart';
import 'package:share_plus/share_plus.dart';
import '../models/purchase_requisition.dart';
import 'python_script_generator.dart';

class PRService {
  final IsarService _isarService;

  PRService(this._isarService);

  // Generate unique PR number
  String generatePRNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return 'PR${timestamp.toString().substring(7)}';
  }

  // Create new PR
  Future<PurchaseRequisition> createPR({
    required String documentType,
    required String purchasingGroup,
    String? requisitioner,
  }) async {
    final pr = PurchaseRequisition(
      prNumber: generatePRNumber(),
      documentType: documentType,
      purchasingGroup: purchasingGroup,
      requisitioner: requisitioner,
      createdBy: 'current_user', // Get from auth
    );

    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.purchaseRequisitions.put(pr);
    });

    return pr;
  }

  // Add line item
  Future<void> addLineItem(String prNumber, PRLineItem item) async {
    final isar = await _isarService.db;
    item.prNumber = prNumber;

    await isar.writeTxn(() async {
      await isar.pRLineItems.put(item);
    });
  }

  // Update line item
  Future<void> updateLineItem(PRLineItem item) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.pRLineItems.put(item);
    });
  }

  // Delete line item
  Future<void> deleteLineItem(int itemId) async {
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      final item = await isar.pRLineItems.get(itemId);
      if (item != null) {
        item.isDeleted = true;
        await isar.pRLineItems.put(item);
      }
    });
  }

  // Get PR with items
  Future<Map<String, dynamic>> getPRWithItems(String prNumber) async {
    final isar = await _isarService.db;

    final pr = await isar.purchaseRequisitions
        .filter()
        .prNumberEqualTo(prNumber)
        .findFirst();

    final items = await isar.pRLineItems
        .filter()
        .prNumberEqualTo(prNumber)
        .and()
        .isDeletedEqualTo(false)
        .sortByItemNumber()
        .findAll();

    return {'pr': pr, 'items': items};
  }

  // Export as JSON workflow
  Future<File> exportAsWorkflowJSON(String prNumber) async {
    final data = await getPRWithItems(prNumber);
    final pr = data['pr'] as PurchaseRequisition?;
    final items = data['items'] as List<PRLineItem>;

    if (pr == null) {
      throw Exception('PR not found');
    }

    final workflow = _buildPRWorkflow(pr, items);
    final jsonString = JsonEncoder.withIndent('  ').convert(workflow.toJson());

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/PR_${pr.prNumber}_workflow.json');
    await file.writeAsString(jsonString);

    // Update PR with export info
    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      pr.isExported = true;
      pr.exportedAt = DateTime.now();
      pr.exportFilePath = file.path;
      await isar.purchaseRequisitions.put(pr);
    });

    return file;
  }

  // Export as CSV for automation
  Future<File> exportAsCSV(String prNumber) async {
    final data = await getPRWithItems(prNumber);
    final pr = data['pr'] as PurchaseRequisition?;
    final items = data['items'] as List<PRLineItem>;

    if (pr == null) {
      throw Exception('PR not found');
    }

    final List<List<dynamic>> rows = [];

    // Header row
    rows.add([
      'PR_Number',
      'Document_Type',
      'Document_Date',
      'Purchase_Org',
      'Purchase_Group',
      'Item_Number',
      'Material',
      'Short_Text',
      'Quantity',
      'Unit',
      'Valuation_Price',
      'Currency',
      'Plant',
      'Storage_Location',
      'Material_Group',
      'Account_Assignment_Category',
      'Item_Category',
      'Asset_Number',
      'Cost_Center',
      'GL_Account',
      'Delivery_Date',
      'Valuation_Type',
    ]);

    // Data rows
    for (final item in items) {
      rows.add([
        pr.displayNumber,
        pr.documentType,
        _formatDate(pr.documentDate!),
        pr.purchaseOrganization,
        pr.purchasingGroup,
        item.itemNumber,
        item.material ?? '',
        item.shortText,
        item.quantity,
        item.unit,
        item.valuationPrice,
        item.currency,
        item.plant,
        item.storageLocation ?? '',
        item.materialGroup,
        item.accountAssignmentCategory,
        item.itemCategory,
        item.assetNumber ?? '',
        item.costCenter ?? '',
        item.glAccount ?? '',
        _formatDate(item.deliveryDate!),
        item.valuationType ?? '',
      ]);
    }

    final csv = const ListToCsvConverter().convert(rows);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/PR_${pr.prNumber}.csv');
    await file.writeAsString(csv);

    return file;
  }

  // Share workflow files
  Future<void> shareWorkflowFiles(String prNumber) async {
    final jsonFile = await exportAsWorkflowJSON(prNumber);
    final csvFile = await exportAsCSV(prNumber);

    await Share.shareXFiles(
      [XFile(jsonFile.path), XFile(csvFile.path)],
      subject: 'Purchase Requisition $prNumber - Automation Files',
      text: 'PR automation files for SAP workflow',
    );
  }

  // Generate complete automation package
  Future<Map<String, File>> generateCompleteAutomationPackage({
    required String prNumber,
    required String sapUsername,
    required String sapPassword,
  }) async {
    final data = await getPRWithItems(prNumber);
    final pr = data['pr'] as PurchaseRequisition?;
    final items = data['items'] as List<PRLineItem>;

    if (pr == null) {
      throw Exception('PR not found');
    }

    // Generate all files
    final files = <String, File>{};

    // 1. JSON Workflow
    files['json'] = await exportAsWorkflowJSON(prNumber);

    // 2. CSV Data
    files['csv'] = await exportAsCSV(prNumber);

    // 3. Python Script
    files['python'] = await PythonScriptGenerator.generatePRAutomationScript(
      pr: pr,
      items: items,
      sapUsername: sapUsername,
      sapPassword: sapPassword,
    );

    // 4. Batch File
    files['batch'] = await PythonScriptGenerator.generateBatchFile(prNumber);

    // 5. README
    // files['readme'] = await PythonScriptGenerator.generateReadme(prNumber);

    return files;
  }

  // Share complete package
  Future<void> shareCompletePackage({
    required String prNumber,
    required String sapUsername,
    required String sapPassword,
  }) async {
    final files = await generateCompleteAutomationPackage(
      prNumber: prNumber,
      sapUsername: sapUsername,
      sapPassword: sapPassword,
    );

    final xFiles = files.values.map((f) => XFile(f.path)).toList();

    await Share.shareXFiles(
      xFiles,
      subject: 'SAP PR $prNumber - Complete Automation Package',
      text:
          'Purchase Requisition automation files including Python script, data files, and documentation.',
    );
  }

  // Build workflow configuration
  WorkflowConfiguration _buildPRWorkflow(
    PurchaseRequisition pr,
    List<PRLineItem> items,
  ) {
    return WorkflowConfiguration(
      workflowId: 'MM_PR_Creation_${pr.documentType}',
      version: '1.0',
      description:
          'Purchase Requisition Creation - ${pr.documentTypeDescription}',
      sapConnection: SAPConnection(
        system: 'S4P',
        client: '300',
        language: 'EN',
      ),
      configuration: AutomationConfig(),
      steps: _buildWorkflowSteps(pr, items),
      errorHandling: ErrorHandling(),
    );
  }

  // Build workflow steps
  List<WorkflowStep> _buildWorkflowSteps(
    PurchaseRequisition pr,
    List<PRLineItem> items,
  ) {
    final steps = <WorkflowStep>[
      // Step 1: Login
      WorkflowStep(stepId: 1, action: 'login_sap', waitAfter: 12),

      // Step 2: Enter T-code ME51N
      WorkflowStep(
        stepId: 2,
        action: 'enter_tcode',
        tcode: 'ME51N',
        waitAfter: 2,
      ),

      // Step 3: Select document type
      WorkflowStep(
        stepId: 3,
        action: 'keyboard_navigation',
        screenName: 'Initial Screen',
        keys: [
          KeyboardAction(type: 'press', key: 'tab'),
          KeyboardAction(type: 'press', key: 'tab'),
        ],
        waitAfter: 1,
      ),

      // Step 4: Fill header data
      WorkflowStep(
        stepId: 4,
        action: 'fill_fields',
        screenName: 'Create Purchase Requisition',
        fields: [
          FieldMapping(
            fieldName: 'Document_Type',
            csvColumn: 'Document_Type',
            navigation: 'direct',
            required: true,
          ),
          FieldMapping(
            fieldName: 'Purchase_Organization',
            csvColumn: 'Purchase_Org',
            navigation: 'tab',
            tabCount: 1,
            required: true,
          ),
          FieldMapping(
            fieldName: 'Purchasing_Group',
            csvColumn: 'Purchase_Group',
            navigation: 'tab',
            tabCount: 1,
            required: true,
          ),
        ],
        waitAfter: 2,
      ),
    ];

    // Add steps for each line item
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      steps.addAll(_buildItemSteps(item, i + 5));
    }

    // Final step: Save PR
    steps.add(
      WorkflowStep(
        stepId: steps.length + 1,
        action: 'save_document',
        keys: [
          KeyboardAction(type: 'hotkey', keys: ['ctrl', 's']),
        ],
        waitAfter: 2,
        captureOutput: CaptureOutput(
          variable: 'pr_number',
          method: 'screen_text',
        ),
      ),
    );

    return steps;
  }

  // Build steps for individual line items
  List<WorkflowStep> _buildItemSteps(PRLineItem item, int startStepId) {
    final steps = <WorkflowStep>[];

    // Add item header
    steps.add(
      WorkflowStep(
        stepId: startStepId,
        action: 'add_line_item',
        screenName: 'Item ${item.itemNumber}',
        fields: [
          FieldMapping(
            fieldName: 'Material',
            csvColumn: 'Material',
            navigation: 'direct',
            required: item.material != null,
          ),
          FieldMapping(
            fieldName: 'Short_Text',
            csvColumn: 'Short_Text',
            navigation: 'tab',
            tabCount: 1,
            required: true,
          ),
          FieldMapping(
            fieldName: 'Quantity',
            csvColumn: 'Quantity',
            navigation: 'tab',
            tabCount: 1,
            required: true,
          ),
          FieldMapping(
            fieldName: 'Unit',
            csvColumn: 'Unit',
            navigation: 'tab',
            tabCount: 1,
            required: true,
          ),
          FieldMapping(
            fieldName: 'Plant',
            csvColumn: 'Plant',
            navigation: 'tab',
            tabCount: 1,
            required: true,
          ),
          FieldMapping(
            fieldName: 'Storage_Location',
            csvColumn: 'Storage_Location',
            navigation: 'tab',
            tabCount: 1,
            required: false,
          ),
          FieldMapping(
            fieldName: 'Delivery_Date',
            csvColumn: 'Delivery_Date',
            navigation: 'tab',
            tabCount: 1,
            required: true,
          ),
        ],
        waitAfter: 2,
      ),
    );

    return steps;
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  // Update PR status
  Future<void> updatePRStatus(String prNumber, PRStatus status) async {
    final isar = await _isarService.db;
    final pr = await isar.purchaseRequisitions
        .filter()
        .prNumberEqualTo(prNumber)
        .findFirst();

    if (pr != null) {
      await isar.writeTxn(() async {
        pr.status = status;
        pr.updatedAt = DateTime.now();
        await isar.purchaseRequisitions.put(pr);
      });
    }
  }

  // Move to next workflow stage
  Future<void> advanceWorkflowStage(
    String prNumber,
    WorkflowStage nextStage,
  ) async {
    final isar = await _isarService.db;
    final pr = await isar.purchaseRequisitions
        .filter()
        .prNumberEqualTo(prNumber)
        .findFirst();

    if (pr != null) {
      await isar.writeTxn(() async {
        pr.currentStage = nextStage;
        pr.updatedAt = DateTime.now();
        await isar.purchaseRequisitions.put(pr);
      });
    }
  }

  // Get all PRs
  Future<List<PurchaseRequisition>> getAllPRs() async {
    final isar = await _isarService.db;
    return await isar.purchaseRequisitions
        .where()
        .sortByCreatedAtDesc()
        .findAll();
  }

  // Get PRs by status
  Future<List<PurchaseRequisition>> getPRsByStatus(PRStatus status) async {
    final isar = await _isarService.db;
    return await isar.purchaseRequisitions
        .filter()
        .statusEqualTo(status)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // Get PRs by workflow stage
  Future<List<PurchaseRequisition>> getPRsByStage(WorkflowStage stage) async {
    final isar = await _isarService.db;
    return await isar.purchaseRequisitions
        .filter()
        .currentStageEqualTo(stage)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // Search PRs
  Future<List<PurchaseRequisition>> searchPRs(String query) async {
    final isar = await _isarService.db;
    return await isar.purchaseRequisitions
        .filter()
        .prNumberContains(query, caseSensitive: false)
        .or()
        .documentTypeContains(query, caseSensitive: false)
        .or()
        .requisitionerContains(query, caseSensitive: false)
        .sortByCreatedAtDesc()
        .findAll();
  }

  // Get PR statistics
  Future<Map<String, int>> getPRStatistics() async {
    final isar = await _isarService.db;
    final allPRs = await isar.purchaseRequisitions.where().findAll();

    final stats = <String, int>{
      'total': allPRs.length,
      'draft': 0,
      'submitted': 0,
      'approved': 0,
      'rejected': 0,
      'completed': 0,
      'exported': 0,
    };

    for (final pr in allPRs) {
      switch (pr.status) {
        case PRStatus.draft:
          stats['draft'] = (stats['draft'] ?? 0) + 1;
          break;
        case PRStatus.submitted:
          stats['submitted'] = (stats['submitted'] ?? 0) + 1;
          break;
        case PRStatus.approved:
          stats['approved'] = (stats['approved'] ?? 0) + 1;
          break;
        case PRStatus.rejected:
          stats['rejected'] = (stats['rejected'] ?? 0) + 1;
          break;
        case PRStatus.completed:
          stats['completed'] = (stats['completed'] ?? 0) + 1;
          break;
        default:
          break;
      }

      if (pr.isExported) {
        stats['exported'] = (stats['exported'] ?? 0) + 1;
      }
    }

    return stats;
  }

  // Delete PR
  Future<void> deletePR(String prNumber) async {
    final isar = await _isarService.db;

    await isar.writeTxn(() async {
      // Delete PR
      final pr = await isar.purchaseRequisitions
          .filter()
          .prNumberEqualTo(prNumber)
          .findFirst();

      if (pr != null) {
        await isar.purchaseRequisitions.delete(pr.id);
      }

      // Delete all line items
      final items = await isar.pRLineItems
          .filter()
          .prNumberEqualTo(prNumber)
          .findAll();

      for (final item in items) {
        await isar.pRLineItems.delete(item.id);
      }
    });
  }

  // Duplicate PR
  Future<PurchaseRequisition> duplicatePR(String prNumber) async {
    final data = await getPRWithItems(prNumber);
    final originalPR = data['pr'] as PurchaseRequisition?;
    final originalItems = data['items'] as List<PRLineItem>;

    if (originalPR == null) {
      throw Exception('PR not found');
    }

    // Create new PR with same data
    final newPR = PurchaseRequisition(
      prNumber: generatePRNumber(),
      documentType: originalPR.documentType,
      purchasingGroup: originalPR.purchasingGroup,
      requisitioner: originalPR.requisitioner,
      createdBy: 'current_user',
    );

    final isar = await _isarService.db;
    await isar.writeTxn(() async {
      await isar.purchaseRequisitions.put(newPR);

      // Duplicate line items
      for (final originalItem in originalItems) {
        final newItem = PRLineItem(
          prNumber: newPR.prNumber,
          itemNumber: originalItem.itemNumber,
          material: originalItem.material,
          shortText: originalItem.shortText,
          quantity: originalItem.quantity,
          unit: originalItem.unit,
          valuationPrice: originalItem.valuationPrice,
          currency: originalItem.currency,
          plant: originalItem.plant,
          storageLocation: originalItem.storageLocation,
          materialGroup: originalItem.materialGroup,
          accountAssignmentCategory: originalItem.accountAssignmentCategory,
          itemCategory: originalItem.itemCategory,
          assetNumber: originalItem.assetNumber,
          costCenter: originalItem.costCenter,
          glAccount: originalItem.glAccount,
          valuationType: originalItem.valuationType,
          deliveryDate: originalItem.deliveryDate,
        );

        await isar.pRLineItems.put(newItem);
      }
    });

    return newPR;
  }

  // Get recent PRs
  Future<List<PurchaseRequisition>> getRecentPRs({int limit = 10}) async {
    final isar = await _isarService.db;
    return await isar.purchaseRequisitions
        .where()
        .sortByCreatedAtDesc()
        .limit(limit)
        .findAll();
  }

  // Export PR summary as text
  Future<String> exportPRSummary(String prNumber) async {
    final data = await getPRWithItems(prNumber);
    final pr = data['pr'] as PurchaseRequisition?;
    final items = data['items'] as List<PRLineItem>;

    if (pr == null) {
      throw Exception('PR not found');
    }

    final buffer = StringBuffer();
    buffer.writeln('=' * 80);
    buffer.writeln('PURCHASE REQUISITION SUMMARY');
    buffer.writeln('=' * 80);
    buffer.writeln();
    buffer.writeln('PR Number: ${pr.displayNumber}');
    buffer.writeln(
      'Document Type: ${pr.documentType} - ${pr.documentTypeDescription}',
    );
    buffer.writeln('Purchase Organization: ${pr.purchaseOrganization}');
    buffer.writeln('Purchasing Group: ${pr.purchasingGroup}');
    if (pr.requisitioner != null) {
      buffer.writeln('Requisitioner: ${pr.requisitioner}');
    }
    buffer.writeln('Status: ${pr.status.name}');
    buffer.writeln('Workflow Stage: ${pr.currentStage.name}');
    buffer.writeln('Created: ${_formatDate(pr.createdAt!)}');
    buffer.writeln();
    buffer.writeln('-' * 80);
    buffer.writeln('LINE ITEMS (${items.length})');
    buffer.writeln('-' * 80);
    buffer.writeln();

    double totalValue = 0.0;

    for (final item in items) {
      buffer.writeln('Item ${item.itemNumber}:');
      if (item.material != null) {
        buffer.writeln('  Material: ${item.material}');
      }
      buffer.writeln('  Description: ${item.shortText}');
      buffer.writeln('  Quantity: ${item.quantity} ${item.unit}');
      buffer.writeln('  Price: ${item.currency} ${item.valuationPrice}');
      buffer.writeln(
        '  Total: ${item.currency} ${item.totalValue.toStringAsFixed(2)}',
      );
      buffer.writeln('  Plant: ${item.plant}');
      buffer.writeln('  Delivery Date: ${_formatDate(item.deliveryDate!)}');
      buffer.writeln();

      totalValue += item.totalValue;
    }

    buffer.writeln('-' * 80);
    buffer.writeln('TOTAL VALUE: INR ${totalValue.toStringAsFixed(2)}');
    buffer.writeln('=' * 80);

    return buffer.toString();
  }
}
