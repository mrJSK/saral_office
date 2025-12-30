// lib/features/procurement/screens/pr_export_screen.dart

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saral_office/features/procurement/screens/pr_creation_screen.dart';
import '../../../core/theme/app_theme.dart';
import '../models/purchase_requisition.dart';
import '../services/pr_service.dart';

class PRExportScreen extends ConsumerStatefulWidget {
  final String prNumber;

  const PRExportScreen({super.key, required this.prNumber});

  @override
  ConsumerState<PRExportScreen> createState() => _PRExportScreenState();
}

class _PRExportScreenState extends ConsumerState<PRExportScreen> {
  PurchaseRequisition? _pr;
  List<PRLineItem> _items = [];
  bool _isLoading = true;
  bool _isExporting = false;
  File? _jsonFile;
  File? _csvFile;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prService = ref.read(prServiceProvider);
    final data = await prService.getPRWithItems(widget.prNumber);

    setState(() {
      _pr = data['pr'] as PurchaseRequisition?;
      _items = data['items'] as List<PRLineItem>;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Icon(CupertinoIcons.back),
        ),
        middle: const Text('Export PR'),
      ),
      child: _isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoCard(),
                    const SizedBox(height: AppTheme.spacingXL),
                    _buildSummarySection(),
                    const SizedBox(height: AppTheme.spacingXL),
                    _buildWorkflowPreview(),
                    const SizedBox(height: AppTheme.spacingXL),
                    _buildExportButtons(),
                    if (_jsonFile != null || _csvFile != null) ...[
                      const SizedBox(height: AppTheme.spacingXL),
                      _buildExportedFiles(),
                    ],
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryBlue.withOpacity(0.1),
            AppTheme.primaryBlue.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppTheme.primaryBlue.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  CupertinoIcons.arrow_down_doc,
                  color: AppTheme.surfaceWhite,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ready to Export',
                      style: AppTheme.headline3.copyWith(
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'PR ${_pr?.displayNumber ?? ''}',
                      style: AppTheme.body2.copyWith(
                        color: AppTheme.primaryBlue.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          const Divider(color: AppTheme.dividerColor),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'Export your Purchase Requisition as JSON workflow configuration and CSV data file for SAP automation.',
            style: AppTheme.body2.copyWith(
              color: AppTheme.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.chart_bar,
                color: AppTheme.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'PR SUMMARY',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryBlue,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          _buildSummaryRow(
            'Document Type',
            _pr?.documentTypeDescription ?? '',
            CupertinoIcons.doc_text,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildSummaryRow(
            'Line Items',
            '${_items.length} items',
            CupertinoIcons.square_list,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildSummaryRow(
            'Total Value',
            'INR ${_calculateTotalValue().toStringAsFixed(2)}',
            CupertinoIcons.money_dollar_circle,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildSummaryRow(
            'Purchase Group',
            _pr?.purchasingGroup ?? '',
            CupertinoIcons.person_2,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: AppTheme.primaryBlue),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.caption.copyWith(
                  color: AppTheme.textSecondary,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTheme.body1.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkflowPreview() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.arrow_branch,
                color: AppTheme.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'WORKFLOW STEPS',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryBlue,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          _buildWorkflowStep(1, 'Login to SAP', true),
          _buildWorkflowStep(2, 'Execute T-code ME51N', true),
          _buildWorkflowStep(3, 'Fill Header Data', true),
          _buildWorkflowStep(4, 'Add ${_items.length} Line Items', true),
          _buildWorkflowStep(5, 'Save Document', true),
          _buildWorkflowStep(6, 'Capture PR Number', false),
        ],
      ),
    );
  }

  Widget _buildWorkflowStep(int step, String description, bool showConnector) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppTheme.primaryBlue, width: 2),
              ),
              child: Center(
                child: Text(
                  '$step',
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                description,
                style: AppTheme.body2.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            Icon(
              CupertinoIcons.checkmark_circle_fill,
              size: 18,
              color: AppTheme.successGreen.withOpacity(0.6),
            ),
          ],
        ),
        if (showConnector)
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              width: 2,
              height: 24,
              color: AppTheme.primaryBlue.withOpacity(0.3),
            ),
          ),
      ],
    );
  }

  Widget _buildExportButtons() {
    return Column(
      children: [
        _buildExportButton(
          label: 'Export JSON Workflow',
          description: 'Workflow configuration for automation',
          icon: CupertinoIcons.doc_text_fill,
          color: AppTheme.primaryBlue,
          onPressed: _isExporting ? null : _exportJSON,
        ),
        const SizedBox(height: AppTheme.spacingM),
        _buildExportButton(
          label: 'Export CSV Data',
          description: 'Line item data for processing',
          icon: CupertinoIcons.table_fill,
          color: AppTheme.successGreen,
          onPressed: _isExporting ? null : _exportCSV,
        ),
        const SizedBox(height: AppTheme.spacingM),
        _buildExportButton(
          label: 'Export Both & Share',
          description: 'Share JSON + CSV files together',
          icon: CupertinoIcons.share,
          color: AppTheme.warningOrange,
          onPressed: _isExporting ? null : _exportAndShare,
        ),
      ],
    );
  }

  Widget _buildExportButton({
    required String label,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: onPressed == null
              ? AppTheme.dividerColor.withOpacity(0.3)
              : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: onPressed == null
                ? AppTheme.dividerColor
                : color.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: onPressed == null ? AppTheme.dividerColor : color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppTheme.surfaceWhite, size: 22),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: onPressed == null
                          ? AppTheme.textSecondary
                          : AppTheme.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      color: AppTheme.textSecondary.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 18,
              color: onPressed == null ? AppTheme.textSecondary : color,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExportedFiles() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: AppTheme.successGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppTheme.successGreen.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: AppTheme.successGreen,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'EXPORTED FILES',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.successGreen,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingM),
          if (_jsonFile != null) _buildFileRow(_jsonFile!, 'JSON Workflow'),
          if (_jsonFile != null && _csvFile != null)
            const SizedBox(height: AppTheme.spacingS),
          if (_csvFile != null) _buildFileRow(_csvFile!, 'CSV Data'),
        ],
      ),
    );
  }

  Widget _buildFileRow(File file, String type) {
    final fileName = file.path.split('/').last;
    final fileSize = file.lengthSync();
    final sizeKB = (fileSize / 1024).toStringAsFixed(2);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.doc_fill, color: AppTheme.successGreen, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$fileName ($sizeKB KB)',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 10,
                    color: AppTheme.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotalValue() {
    return _items.fold(0.0, (sum, item) => sum + item.totalValue);
  }

  Future<void> _exportJSON() async {
    setState(() => _isExporting = true);

    try {
      final prService = ref.read(prServiceProvider);
      final file = await prService.exportAsWorkflowJSON(widget.prNumber);

      setState(() {
        _jsonFile = file;
        _isExporting = false;
      });

      _showSuccess('JSON workflow exported successfully');
    } catch (e) {
      setState(() => _isExporting = false);
      _showError('Error exporting JSON: $e');
    }
  }

  Future<void> _exportCSV() async {
    setState(() => _isExporting = true);

    try {
      final prService = ref.read(prServiceProvider);
      final file = await prService.exportAsCSV(widget.prNumber);

      setState(() {
        _csvFile = file;
        _isExporting = false;
      });

      _showSuccess('CSV data exported successfully');
    } catch (e) {
      setState(() => _isExporting = false);
      _showError('Error exporting CSV: $e');
    }
  }

  Future<void> _exportAndShare() async {
    setState(() => _isExporting = true);

    try {
      final prService = ref.read(prServiceProvider);
      await prService.shareWorkflowFiles(widget.prNumber);

      setState(() => _isExporting = false);
    } catch (e) {
      setState(() => _isExporting = false);
      _showError('Error sharing files: $e');
    }
  }

  void _showSuccess(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.checkmark_circle_fill,
              color: AppTheme.successGreen,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text('Success'),
          ],
        ),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showError(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
