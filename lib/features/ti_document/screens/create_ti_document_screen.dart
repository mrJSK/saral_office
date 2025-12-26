// lib/features/ti_document/screens/create_ti_document_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/division.dart';
import '../../employee/models/employee.dart';
import '../../employee/screens/employee_management_screen.dart'; // ✅ ADD THIS
import '../providers/ti_document_provider.dart';
import '../../payment_authority/widgets/ios_text_field.dart';
import '../../payment_authority/widgets/division_search_field.dart';

class CreateTIDocumentScreen extends ConsumerStatefulWidget {
  const CreateTIDocumentScreen({super.key});

  @override
  ConsumerState<CreateTIDocumentScreen> createState() =>
      _CreateTIDocumentScreenState();
}

class _CreateTIDocumentScreenState extends ConsumerState<CreateTIDocumentScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _scrollController = ScrollController();

  // Controllers
  final _omNumberController = TextEditingController();
  final _recommendingOfficeController = TextEditingController();
  final _letterNumberController = TextEditingController();

  DateTime _omDate = DateTime.now();
  DateTime _letterDate = DateTime.now();

  Division? _selectedDivision;
  Employee? _selectedEmployee;

  bool _isGeneratingPdf = false;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _omNumberController.dispose();
    _recommendingOfficeController.dispose();
    _letterNumberController.dispose();
    super.dispose();
  }

  void _syncToState() {
    final notifier = ref.read(tiDocumentProvider.notifier);
    notifier.updateOMDetails(
      number: _omNumberController.text.trim(),
      date: _omDate,
    );
    notifier.updateRecommendingOfficeDetails(
      office: _recommendingOfficeController.text.trim(),
      letterNo: _letterNumberController.text.trim(),
      letterDate: _letterDate,
    );
    if (_selectedDivision != null) {
      notifier.updateDivision(_selectedDivision!);
    }
    if (_selectedEmployee != null) {
      notifier.updateEmployee(_selectedEmployee!);
    }
  }

  Future<void> _generatePDF() async {
    // Validate all fields
    if (_omNumberController.text.trim().isEmpty) {
      _showErrorDialog('Please enter OM Number');
      return;
    }
    if (_recommendingOfficeController.text.trim().isEmpty) {
      _showErrorDialog('Please enter Recommending Office');
      return;
    }
    if (_letterNumberController.text.trim().isEmpty) {
      _showErrorDialog('Please enter Letter Number');
      return;
    }
    if (_selectedDivision == null) {
      _showErrorDialog('Please select a Division');
      return;
    }
    if (_selectedEmployee == null) {
      _showErrorDialog('Please select an Employee');
      return;
    }

    setState(() => _isGeneratingPdf = true);

    try {
      // Sync data to provider
      _syncToState();

      // Generate PDF (single PDF with 2 pages, auto-opens)
      await ref.read(tiDocumentProvider.notifier).generateAndSavePDF();

      if (mounted) {
        // ✅ UPDATED: Success dialog for single PDF
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
            content: const Text(
              'TI Document has been generated and opened successfully!',
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Return to home
                  ref.read(tiDocumentProvider.notifier).reset();
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog('Failed to generate PDF: ${e.toString()}');
      }
    } finally {
      if (mounted) {
        setState(() => _isGeneratingPdf = false);
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

  void _showDatePicker(DateTime initial, Function(DateTime) onChanged) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: AppTheme.surfaceWhite,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor, width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initial,
                maximumDate: DateTime.now().add(const Duration(days: 365)),
                minimumDate: DateTime.now().subtract(const Duration(days: 365)),
                onDateTimeChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ UPDATED: Use Employee Management Screen for selection
  void _showEmployeeSelector() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (_) => EmployeeManagementScreen(
          isSelectionMode: true,
          onEmployeeSelected: (employee) {
            setState(() => _selectedEmployee = employee);
          },
        ),
      ),
    );
  }

  void _handleBack() {
    // Check if any data has been entered
    final hasData =
        _omNumberController.text.isNotEmpty ||
        _recommendingOfficeController.text.isNotEmpty ||
        _letterNumberController.text.isNotEmpty ||
        _selectedDivision != null ||
        _selectedEmployee != null;

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
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Discard'),
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back
                ref.read(tiDocumentProvider.notifier).reset();
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
    final canGenerate =
        _omNumberController.text.trim().isNotEmpty &&
        _recommendingOfficeController.text.trim().isNotEmpty &&
        _letterNumberController.text.trim().isNotEmpty &&
        _selectedDivision != null &&
        _selectedEmployee != null;

    return Stack(
      children: [
        CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundLight,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
            border: null,
            middle: const Text(
              'Create TI Document',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.back),
              onPressed: _isGeneratingPdf ? null : _handleBack,
            ),
            trailing: _isGeneratingPdf
                ? const CupertinoActivityIndicator(radius: 10)
                : null,
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppTheme.spacingM),
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  // Section 1: Office Memorandum
                  _buildSectionHeader(
                    '1. Office Memorandum',
                    CupertinoIcons.doc_text,
                  ),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    IOSTextField(
                      controller: _omNumberController,
                      label: 'OM Number',
                      placeholder: 'e.g. 451',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(
                      'OM Date',
                      _omDate,
                      (d) => setState(() => _omDate = d),
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Section 2: Recommending Office
                  _buildSectionHeader(
                    '2. Recommending Office',
                    CupertinoIcons.building_2_fill,
                  ),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    IOSTextField(
                      controller: _recommendingOfficeController,
                      label: 'Recommending Office',
                      placeholder: 'e.g. A.E./BGE',
                      textCapitalization: TextCapitalization.characters,
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    IOSTextField(
                      controller: _letterNumberController,
                      label: 'Letter Number',
                      placeholder: 'e.g. O 4/16 GM',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(
                      'Letter Date',
                      _letterDate,
                      (d) => setState(() => _letterDate = d),
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Section 3: Division & Employee
                  _buildSectionHeader(
                    '3. Division & Employee',
                    CupertinoIcons.person_2_fill,
                  ),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    // Division Selection Field
                    DivisionSearchField(
                      selectedDivision: _selectedDivision,
                      onChanged: (division) {
                        setState(() => _selectedDivision = division);
                      },
                    ),
                    const Divider(height: 24, color: AppTheme.dividerColor),
                    // ✅ Employee Selection Field
                    _buildSelectionField(
                      label: 'Employee',
                      value: _selectedEmployee?.displayText,
                      placeholder: 'Select Employee',
                      icon: CupertinoIcons.person_fill,
                      onTap: _showEmployeeSelector,
                    ),
                  ]),
                  const SizedBox(height: 32),

                  // Generate Button
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: (canGenerate && !_isGeneratingPdf)
                        ? _generatePDF
                        : null,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: (canGenerate && !_isGeneratingPdf)
                            ? const LinearGradient(
                                colors: [
                                  AppTheme.primaryBlue,
                                  AppTheme.secondaryBlue,
                                ],
                              )
                            : null,
                        color: (canGenerate && !_isGeneratingPdf)
                            ? null
                            : AppTheme.dividerColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: (canGenerate && !_isGeneratingPdf)
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
                            CupertinoIcons.doc_text_fill,
                            color: (canGenerate && !_isGeneratingPdf)
                                ? Colors.white
                                : AppTheme.textSecondary,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Generate PDF',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              color: (canGenerate && !_isGeneratingPdf)
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

                  // Helper Text
                  if (!canGenerate)
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
                            CupertinoIcons.info_circle_fill,
                            color: AppTheme.warningOrange,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Please fill all required fields to generate PDF',
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

        // ✅ UPDATED: Loading Overlay
        if (_isGeneratingPdf)
          Container(
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoActivityIndicator(radius: 16),
                    SizedBox(height: 16),
                    Text(
                      'Generating PDF...',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Please wait',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: AppTheme.primaryBlue),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDateField(
    String label,
    DateTime date,
    Function(DateTime) onChanged,
  ) {
    return GestureDetector(
      onTap: () => _showDatePicker(date, onChanged),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.dividerColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  CupertinoIcons.calendar,
                  size: 16,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
            Text(
              DateFormat('dd MMM yyyy').format(date),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionField({
    required String label,
    required String? value,
    required String placeholder,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: AppTheme.primaryBlue),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 180),
                  child: Text(
                    value ?? placeholder,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      color: value == null
                          ? AppTheme.textSecondary
                          : AppTheme.primaryBlue,
                      fontSize: 14,
                      fontWeight: value == null
                          ? FontWeight.normal
                          : FontWeight.w500,
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  CupertinoIcons.chevron_right,
                  size: 14,
                  color: AppTheme.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
