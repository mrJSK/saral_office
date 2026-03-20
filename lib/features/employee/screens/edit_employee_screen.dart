// lib/features/employee/screens/edit_employee_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../models/employee.dart';
import '../providers/employee_provider.dart';
import '../../payment_authority/widgets/ios_text_field.dart';

class EditEmployeeScreen extends ConsumerStatefulWidget {
  final Employee employee;

  const EditEmployeeScreen({super.key, required this.employee});

  @override
  ConsumerState<EditEmployeeScreen> createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends ConsumerState<EditEmployeeScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _designationController;
  late final TextEditingController _sapIdController;
  late final TextEditingController _officeController;
  late final TextEditingController _officeHeadController;
  late final TextEditingController _officeHeadDesignationController;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.employee.employeeName);
    _designationController = TextEditingController(
      text: widget.employee.designation,
    );
    _sapIdController = TextEditingController(text: widget.employee.sapId);
    _officeController = TextEditingController(text: widget.employee.office);
    _officeHeadController = TextEditingController(
      text: widget.employee.officeHead,
    );
    _officeHeadDesignationController = TextEditingController(
      text: widget.employee.officeHeadDesignation,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _designationController.dispose();
    _sapIdController.dispose();
    _officeController.dispose();
    _officeHeadController.dispose();
    _officeHeadDesignationController.dispose();
    super.dispose();
  }

  void _saveEmployee() async {
    if (_nameController.text.trim().isEmpty ||
        _designationController.text.trim().isEmpty ||
        _sapIdController.text.trim().isEmpty ||
        _officeController.text.trim().isEmpty ||
        _officeHeadController.text.trim().isEmpty ||
        _officeHeadDesignationController.text.trim().isEmpty) {
      _showErrorDialog('All fields are required');
      return;
    }

    setState(() => _isSaving = true);

    try {
      final notifier = ref.read(employeeNotifierProvider.notifier);

      // Load existing employee data
      notifier.loadEmployee(widget.employee);

      // Update with new values
      notifier.updateName(_nameController.text.trim());
      notifier.updateDesignation(_designationController.text.trim());
      notifier.updateSapId(_sapIdController.text.trim());
      notifier.updateOffice(_officeController.text.trim());
      notifier.updateOfficeHead(_officeHeadController.text.trim());
      notifier.updateOfficeHeadDesignation(
        _officeHeadDesignationController.text.trim(),
      );

      await notifier.saveEmployee();

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showErrorDialog(e.toString());
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
        title: const Text('Error'),
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
          child: const Text('Cancel'),
        ),
        middle: const Text(
          'Edit Employee',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _isSaving ? null : _saveEmployee,
          child: _isSaving
              ? const CupertinoActivityIndicator(radius: 8)
              : const Text('Save'),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Column(
            children: [
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
                  children: [
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
                    ),
                    const SizedBox(height: AppTheme.spacingM),
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
                    ),
                    const SizedBox(height: AppTheme.spacingM),
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
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    IOSTextField(
                      controller: _officeController,
                      label: 'Office',
                      placeholder: 'e.g. ETD BSR',
                      textCapitalization: TextCapitalization.characters,
                      prefix: const Icon(
                        CupertinoIcons.building_2_fill,
                        size: 18,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    IOSTextField(
                      controller: _officeHeadController,
                      label: 'Office Head',
                      placeholder: 'e.g. John Doe',
                      textCapitalization: TextCapitalization.words,
                      prefix: const Icon(
                        CupertinoIcons.person_crop_square,
                        size: 18,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    IOSTextField(
                      controller: _officeHeadDesignationController,
                      label: 'Office Head Designation',
                      placeholder: 'e.g. Executive Engineer',
                      textCapitalization: TextCapitalization.words,
                      prefix: const Icon(
                        CupertinoIcons.star_fill,
                        size: 18,
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
