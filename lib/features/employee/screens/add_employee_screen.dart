// lib/features/employee/screens/add_employee_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/employee_provider.dart';
import '../../payment_authority/widgets/ios_text_field.dart';

class AddEmployeeScreen extends ConsumerStatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  ConsumerState<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends ConsumerState<AddEmployeeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _nameController = TextEditingController();
  final _designationController = TextEditingController();
  final _sapIdController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _designationFocusNode = FocusNode();
  final _sapIdFocusNode = FocusNode();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animationController.forward();

    // Reset notifier state when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(employeeNotifierProvider.notifier).reset();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _designationController.dispose();
    _sapIdController.dispose();
    _nameFocusNode.dispose();
    _designationFocusNode.dispose();
    _sapIdFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveEmployee() async {
    // Validation
    if (_nameController.text.trim().isEmpty) {
      _showErrorDialog('Please enter employee name');
      _nameFocusNode.requestFocus();
      return;
    }

    if (_designationController.text.trim().isEmpty) {
      _showErrorDialog('Please enter designation');
      _designationFocusNode.requestFocus();
      return;
    }

    if (_sapIdController.text.trim().isEmpty) {
      _showErrorDialog('Please enter SAP ID');
      _sapIdFocusNode.requestFocus();
      return;
    }

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    setState(() => _isSaving = true);

    try {
      final notifier = ref.read(employeeNotifierProvider.notifier);

      // Update employee data
      notifier.updateName(_nameController.text.trim());
      notifier.updateDesignation(_designationController.text.trim());
      notifier.updateSapId(_sapIdController.text.trim());

      // Save to database
      await notifier.saveEmployee();

      if (mounted) {
        // Show success dialog
        showCupertinoDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => CupertinoAlertDialog(
            title: Row(
              children: [
                const Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: AppTheme.successGreen,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text('Success'),
              ],
            ),
            content: Text(
              'Employee "${_nameController.text.trim()}" has been added successfully!',
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Return to previous screen
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to save employee: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          children: [
            const Icon(
              CupertinoIcons.exclamationmark_triangle_fill,
              color: AppTheme.errorRed,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _handleBack() {
    // Check if any data has been entered
    final hasData =
        _nameController.text.isNotEmpty ||
        _designationController.text.isNotEmpty ||
        _sapIdController.text.isNotEmpty;

    if (hasData) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Discard Changes?'),
          content: const Text(
            'You have unsaved changes. Are you sure you want to go back?',
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Continue Editing'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Discard'),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back
                ref.read(employeeNotifierProvider.notifier).reset();
              },
            ),
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final canSave =
        _nameController.text.trim().isNotEmpty &&
        _designationController.text.trim().isNotEmpty &&
        _sapIdController.text.trim().isNotEmpty;

    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isSaving ? null : _handleBack,
          child: const Text('Cancel'),
        ),
        middle: const Text(
          'Add Employee',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: (canSave && !_isSaving) ? _saveEmployee : null,
          child: _isSaving
              ? const CupertinoActivityIndicator(radius: 8)
              : Text(
                  'Save',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: canSave
                        ? AppTheme.primaryBlue
                        : AppTheme.textSecondary,
                  ),
                ),
        ),
      ),
      child: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingL),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryBlue.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          CupertinoIcons.person_add_solid,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'New Employee',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.5,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Enter employee details below',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Form Section
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceWhite,
                    borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Employee Name
                      IOSTextField(
                        controller: _nameController,
                        label: 'Employee Name',
                        placeholder: 'Enter full name',
                        textCapitalization: TextCapitalization.words,
                        prefix: const Icon(
                          CupertinoIcons.person,
                          size: 18,
                          color: AppTheme.primaryBlue,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),

                      const SizedBox(height: AppTheme.spacingM),

                      // Designation
                      IOSTextField(
                        controller: _designationController,
                        label: 'Designation',
                        placeholder: 'e.g. Junior Engineer',
                        textCapitalization: TextCapitalization.words,
                        prefix: const Icon(
                          CupertinoIcons.briefcase,
                          size: 18,
                          color: AppTheme.primaryBlue,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),

                      const SizedBox(height: AppTheme.spacingM),

                      // SAP ID
                      IOSTextField(
                        controller: _sapIdController,
                        label: 'SAP ID',
                        placeholder: 'Enter SAP ID',
                        keyboardType: TextInputType.number,
                        prefix: const Icon(
                          CupertinoIcons.number,
                          size: 18,
                          color: AppTheme.primaryBlue,
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Helper Info Card
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.primaryBlue.withOpacity(0.2),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.info_circle,
                        size: 20,
                        color: AppTheme.primaryBlue.withOpacity(0.8),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Employee Information',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This employee will be available for selection when creating TI documents and other transactions.',
                              style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 13,
                                color: AppTheme.textSecondary,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Save Button
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: (canSave && !_isSaving) ? _saveEmployee : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: (canSave && !_isSaving)
                          ? const LinearGradient(
                              colors: [
                                AppTheme.primaryBlue,
                                AppTheme.secondaryBlue,
                              ],
                            )
                          : null,
                      color: (canSave && !_isSaving)
                          ? null
                          : AppTheme.dividerColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: (canSave && !_isSaving)
                          ? [
                              BoxShadow(
                                color: AppTheme.primaryBlue.withOpacity(0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_circle_fill,
                          color: (canSave && !_isSaving)
                              ? Colors.white
                              : AppTheme.textSecondary,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Save Employee',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            color: (canSave && !_isSaving)
                                ? Colors.white
                                : AppTheme.textSecondary,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Validation Helper
                if (!canSave)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.warningOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.warningOrange.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          CupertinoIcons.exclamationmark_circle_fill,
                          color: AppTheme.warningOrange,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Please fill all required fields',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.warningOrange.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: AppTheme.spacingXL),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
