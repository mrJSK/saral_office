// lib/features/procurement/screens/pr_creation_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saral_office/core/di/injection.dart';
import 'package:saral_office/features/procurement/screens/pr_line_items_screen.dart';
import '../../../core/theme/app_theme.dart';
import '../models/purchase_requisition.dart';
import '../services/pr_service.dart';

class PRCreationScreen extends ConsumerStatefulWidget {
  const PRCreationScreen({super.key});

  @override
  ConsumerState<PRCreationScreen> createState() => _PRCreationScreenState();
}

class _PRCreationScreenState extends ConsumerState<PRCreationScreen> {
  String _selectedDocType = 'ZFLD';
  final _purchasingGroupController = TextEditingController();
  final _requisitionerController = TextEditingController();
  final _glAccountController = TextEditingController();
  final _divisionController = TextEditingController();
  DateTime _documentDate = DateTime.now();

  final List<String> _documentTypes = [
    'ZFLD',
    'ZTPS',
    'ZIND',
    'ZCAE',
    'ZCEE',
    'ZCSE',
    'ZCCE',
    'ZCFR',
    'ZHPR',
    'ZSBI',
    'ZSTR',
  ];

  final Map<String, String> _docTypeDescriptions = {
    'ZFLD': 'Field Indent',
    'ZTPS': 'Turnkey Indent',
    'ZIND': 'Standard Indent',
    'ZCAE': 'AE Consolidation',
    'ZCEE': 'EE Consolidation',
    'ZCSE': 'SE Consolidation',
    'ZCCE': 'CE Consolidation',
    'ZCFR': 'Final Consolidated PR',
    'ZHPR': 'HQ/Zone/Circle Purchase PR',
    'ZSBI': 'Subcontracting PR',
    'ZSTR': 'Stock Transfer PR',
  };

  @override
  void dispose() {
    _purchasingGroupController.dispose();
    _requisitionerController.dispose();
    _glAccountController.dispose();
    _divisionController.dispose();
    super.dispose();
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
        middle: const Text('Create Purchase Requisition'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(),
              const SizedBox(height: AppTheme.spacingL),
              _buildDocumentTypeSection(),
              const SizedBox(height: AppTheme.spacingL),
              _buildHeaderDataSection(),
              const SizedBox(height: AppTheme.spacingXL),
              _buildCreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppTheme.primaryBlue.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.info_circle_fill,
            color: AppTheme.primaryBlue,
            size: 24,
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Text(
              'Create PR offline and export as JSON/CSV for SAP automation',
              style: AppTheme.body2.copyWith(
                color: AppTheme.primaryBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentTypeSection() {
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
                CupertinoIcons.doc_text,
                color: AppTheme.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'DOCUMENT TYPE',
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
          const SizedBox(height: AppTheme.spacingM),
          GestureDetector(
            onTap: _showDocumentTypePicker,
            child: Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: AppTheme.backgroundLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppTheme.dividerColor),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _selectedDocType,
                          style: AppTheme.body1.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _docTypeDescriptions[_selectedDocType] ?? '',
                          style: AppTheme.caption.copyWith(
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: AppTheme.textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderDataSection() {
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
                CupertinoIcons.folder,
                color: AppTheme.primaryBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              const Text(
                'HEADER DATA',
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
          _buildDateField(),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Purchase Organization',
            value: '1000',
            enabled: false,
            hint: 'UPPTCL',
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Purchasing Group *',
            controller: _purchasingGroupController,
            hint: 'e.g., 159',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Requisitioner',
            controller: _requisitionerController,
            hint: 'Your name',
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'G/L Account',
            controller: _glAccountController,
            hint: 'General Ledger account',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _buildTextField(
            label: 'Division (Fund Center)',
            controller: _divisionController,
            hint: 'e.g., 1511415999',
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Document Date',
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _showDatePicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.dividerColor),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.calendar,
                  size: 18,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _formatDate(_documentDate),
                    style: AppTheme.body1.copyWith(fontSize: 15),
                  ),
                ),
                const Icon(
                  CupertinoIcons.chevron_right,
                  size: 18,
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    TextEditingController? controller,
    String? value,
    String? hint,
    bool enabled = true,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        CupertinoTextField(
          controller: controller,
          enabled: enabled,
          placeholder: hint,
          keyboardType: keyboardType,
          style: AppTheme.body1.copyWith(fontSize: 15),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: enabled
                ? AppTheme.backgroundLight
                : AppTheme.dividerColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.dividerColor),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: AppTheme.primaryBlue,
        borderRadius: BorderRadius.circular(12),
        onPressed: _createPR,
        child: const Text(
          'Create PR',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppTheme.surfaceWhite,
          ),
        ),
      ),
    );
  }

  void _showDocumentTypePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const Text(
                    'Select Document Type',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 50,
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedDocType = _documentTypes[index];
                  });
                },
                children: _documentTypes.map((type) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          _docTypeDescriptions[type] ?? '',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const Text(
                    'Select Date',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _documentDate,
                onDateTimeChanged: (date) {
                  setState(() {
                    _documentDate = date;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createPR() async {
    if (_purchasingGroupController.text.isEmpty) {
      _showError('Please enter Purchasing Group');
      return;
    }

    try {
      final prService = ref.read(prServiceProvider);
      final pr = await prService.createPR(
        documentType: _selectedDocType,
        purchasingGroup: _purchasingGroupController.text,
        requisitioner: _requisitionerController.text.isEmpty
            ? null
            : _requisitionerController.text,
        glAccount: _glAccountController.text.isEmpty
            ? null
            : _glAccountController.text,
        division: _divisionController.text.isEmpty
            ? null
            : _divisionController.text,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) => PRLineItemsScreen(prNumber: pr.prNumber),
          ),
        );
      }
    } catch (e) {
      _showError('Error creating PR: $e');
    }
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

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}

// Provider for PRService
final prServiceProvider = Provider<PRService>((ref) {
  final isarService = ref.watch(isarServiceProvider);
  return PRService(isarService);
});
