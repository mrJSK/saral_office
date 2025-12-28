// lib/features/ti_document/screens/create_ti_document_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:saral_office/features/payment_authority/screens/create_authority_screen.dart';

// --- Adjust imports to match your project structure ---
import '../../../core/database/models/gl_account.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/division.dart';

import '../../employee/models/employee.dart';
import '../../employee/screens/employee_management_screen.dart';

import '../models/imprest_ledger_entry.dart';
import '../providers/ti_document_provider.dart';
import '../widgets/imprest_entry_card.dart';

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
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  final _scrollController = ScrollController();

  // 1. Division & OM Details
  Division? _selectedDivision;
  final _omNumberController = TextEditingController();
  DateTime _omDate = DateTime.now();

  // 2. Employee & Recommending Office
  Employee? _selectedEmployee;
  final _recommendingOfficeController = TextEditingController(); // READ-ONLY
  final _letterNumberController = TextEditingController();
  DateTime _letterDate = DateTime.now();

  // 3. Purpose
  final _purposeController = TextEditingController();

  // 4. Amount & Vouchers (Computed from Entries - READ ONLY)
  final _amountController = TextEditingController();
  final _vouchersCountController = TextEditingController();

  // Hidden Office Details (Synced for PDF)
  final _officeNameController = TextEditingController();
  final _officeHeadController = TextEditingController();
  final _officeHeadDesignationController = TextEditingController();

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

    WidgetsBinding.instance.addPostFrameCallback((_) => _loadFromProvider());
  }

  Future<void> _loadFromProvider() async {
    final document = ref.read(tiDocumentProvider);

    if (document.omNumber != null)
      _omNumberController.text = document.omNumber!;
    if (document.purpose != null) _purposeController.text = document.purpose!;

    // Recommending Office (Read-only load)
    if (document.recommendingOffice != null) {
      _recommendingOfficeController.text = document.recommendingOffice!;
    }

    if (document.letterNumber != null) {
      _letterNumberController.text = document.letterNumber!;
    }

    // Dates
    if (document.omDate != null) setState(() => _omDate = document.omDate!);
    if (document.letterDate != null)
      setState(() => _letterDate = document.letterDate!);

    // Office Details (Hidden)
    if (document.employeeOffice != null)
      _officeNameController.text = document.employeeOffice!;
    if (document.employeeOfficeHead != null)
      _officeHeadController.text = document.employeeOfficeHead!;
    if (document.employeeOfficeHeadDesignation != null) {
      _officeHeadDesignationController.text =
          document.employeeOfficeHeadDesignation!;
    }

    // Division Lookup
    if (document.divisionName != null &&
        document.divisionName!.trim().isNotEmpty) {
      try {
        final isar = ref.read(isarProvider);
        final division = await isar.divisions
            .filter()
            .nameEqualTo(document.divisionName!)
            .findFirst();
        if (division != null && mounted)
          setState(() => _selectedDivision = division);
      } catch (e) {
        debugPrint('Error loading division: $e');
      }
    }

    // Employee Lookup
    if (document.employeeSapId != null &&
        document.employeeSapId!.trim().isNotEmpty) {
      try {
        final isar = ref.read(isarProvider);
        final employee = await isar.employees
            .filter()
            .sapIdEqualTo(document.employeeSapId!)
            .findFirst();
        if (employee != null && mounted)
          setState(() => _selectedEmployee = employee);
      } catch (e) {
        debugPrint('Error loading employee: $e');
      }
    }

    // Recalculate Totals
    _recalculateTotals();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _omNumberController.dispose();
    _amountController.dispose();
    _purposeController.dispose();
    _recommendingOfficeController.dispose();
    _letterNumberController.dispose();
    _vouchersCountController.dispose();
    _officeNameController.dispose();
    _officeHeadController.dispose();
    _officeHeadDesignationController.dispose();
    super.dispose();
  }

  // --- Auto-Calculation Logic ---
  void _recalculateTotals() {
    final entries = ref.read(tiDocumentProvider).imprestEntries;

    final totalAmount = entries.fold(0.0, (sum, e) => sum + e.payment);
    final count = entries.length;

    _amountController.text = totalAmount.toStringAsFixed(0);
    _vouchersCountController.text = count.toString();

    // Sync to provider immediately
    final notifier = ref.read(tiDocumentProvider.notifier);
    notifier.updateAmount(totalAmount);
    notifier.updateVouchersCount(count);
  }

  // --- Sync UI changes to Provider ---
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
    notifier.updatePurpose(_purposeController.text.trim());

    if (_selectedDivision != null) {
      notifier.updateDivision(_selectedDivision!);
    }
    if (_selectedEmployee != null) {
      notifier.updateEmployee(_selectedEmployee!);
    }

    notifier.updateEmployeeOfficeDetails(
      office: _officeNameController.text.trim(),
      head: _officeHeadController.text.trim(),
      headDesignation: _officeHeadDesignationController.text.trim(),
    );
  }

  Future<void> _generatePDF() async {
    // Basic checks
    if (_selectedDivision == null) {
      _showErrorDialog('Please select a Division');
      return;
    }
    if (_omNumberController.text.trim().isEmpty) {
      _showErrorDialog('Please enter OM Number');
      return;
    }
    if (_selectedEmployee == null) {
      _showErrorDialog('Please select an Employee');
      return;
    }
    if (_recommendingOfficeController.text.trim().isEmpty) {
      _showErrorDialog(
        'Recommending Office is missing. Please re-select the Employee.',
      );
      return;
    }
    if (_letterNumberController.text.trim().isEmpty) {
      _showErrorDialog('Please enter Letter Number');
      return;
    }
    if (_purposeController.text.trim().isEmpty) {
      _showErrorDialog('Please enter Purpose');
      return;
    }
    // Amount/Vouchers come from entries, so check entries
    if (ref.read(tiDocumentProvider).imprestEntries.isEmpty) {
      _showErrorDialog('Please add at least one Imprest Entry.');
      return;
    }

    setState(() => _isGeneratingPdf = true);

    try {
      _syncToState();

      // Pass true to include Page 3
      await ref
          .read(tiDocumentProvider.notifier)
          .generateAndSavePDF(includeImprestPage: true);

      if (!mounted) return;
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: Row(
            children: const [
              Icon(
                CupertinoIcons.check_mark_circled_solid,
                color: AppTheme.successGreen,
                size: 24,
              ),
              SizedBox(width: 8),
              Text('Success'),
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
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // go back
                ref.read(tiDocumentProvider.notifier).reset();
              },
            ),
          ],
        ),
      );
    } catch (e) {
      if (mounted) _showErrorDialog('Failed to generate PDF: $e');
    } finally {
      if (mounted) setState(() => _isGeneratingPdf = false);
    }
  }

  void _showErrorDialog(String message) {
    if (!mounted) return;
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Row(
          children: const [
            Icon(
              CupertinoIcons.exclamationmark_triangle_fill,
              color: AppTheme.errorRed,
              size: 24,
            ),
            SizedBox(width: 8),
            Text('Error'),
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

  // --- Date Picker ---
  void _showDatePicker(DateTime initial, ValueChanged<DateTime> onChanged) {
    final normalized = DateTime(initial.year, initial.month, initial.day);
    showCupertinoModalPopup(
      context: context,
      builder: (_) => Container(
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
                    padding: EdgeInsets.zero,
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Done'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: normalized,
                onDateTimeChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Employee Selector (Updates Read-Only Fields) ---
  void _showEmployeeSelector() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => EmployeeManagementScreen(
          isSelectionMode: true,
          onEmployeeSelected: (employee) {
            setState(() {
              _selectedEmployee = employee;
            });

            ref.read(tiDocumentProvider.notifier).updateEmployee(employee);

            final office = employee.office?.trim() ?? '';
            final headName = employee.officeHead?.trim() ?? '';
            final headDesig = employee.officeHeadDesignation?.trim() ?? '';

            // Auto-Fill Recommending Office (Read-Only)
            String autoVal = '';
            if (headDesig.isNotEmpty && office.isNotEmpty) {
              autoVal = '$headDesig, $office';
            } else if (headDesig.isNotEmpty) {
              autoVal = headDesig;
            } else if (office.isNotEmpty) {
              autoVal = office;
            }
            _recommendingOfficeController.text = autoVal;

            // Fill hidden fields
            _officeNameController.text = office;
            _officeHeadController.text = headName;
            _officeHeadDesignationController.text = headDesig;

            ref
                .read(tiDocumentProvider.notifier)
                .updateEmployeeOfficeDetails(
                  office: office,
                  head: headName,
                  headDesignation: headDesig,
                );
          },
        ),
      ),
    );
  }

  void _handleBack() {
    // Simple check
    final hasData =
        _omNumberController.text.isNotEmpty || _selectedEmployee != null;

    if (!hasData) {
      Navigator.pop(context);
      return;
    }

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
              Navigator.pop(context);
              Navigator.pop(context);
              ref.read(tiDocumentProvider.notifier).reset();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _openImprestEntryEditor({
    ImprestLedgerEntry? existing,
    int? index,
  }) async {
    final df = DateFormat('dd/MM/yyyy');
    final dateCtrl = TextEditingController(text: existing?.date.trim() ?? '');
    final vrCtrl = TextEditingController(text: existing?.vrNo ?? '');
    final headCtrl = TextEditingController(text: existing?.head ?? '');
    final txnCtrl = TextEditingController(text: existing?.transaction ?? '');
    final payCtrl = TextEditingController(
      text: existing != null ? existing.payment.toStringAsFixed(0) : '',
    );

    GLAccount? selectedGL; // Track selected GL account

    Future<void> close() async {
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      Navigator.pop(context);
    }

    void save() {
      final date = dateCtrl.text.trim();
      final vrNo = vrCtrl.text.trim();
      final head = headCtrl.text.trim();
      final txn = txnCtrl.text.trim();
      final pay = double.tryParse(payCtrl.text.trim()) ?? 0.0;

      if (date.isEmpty ||
          vrNo.isEmpty ||
          head.isEmpty ||
          txn.isEmpty ||
          pay <= 0) {
        _showErrorDialog('Please fill all entry fields (Amount > 0).');
        return;
      }

      final entry = ImprestLedgerEntry(
        date: date,
        vrNo: vrNo,
        transaction: txn,
        payment: pay,
        total: existing?.total ?? 0.0,
        head: head,
      );

      final notifier = ref.read(tiDocumentProvider.notifier);
      if (existing == null) {
        notifier.addImprestEntry(entry);
      } else {
        if (index == null) return;
        notifier.updateImprestEntry(index, entry);
      }

      // RECALCULATE AFTER SAVE
      _recalculateTotals();

      close();
    }

    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Material(
        color: Colors.transparent,
        child: SafeArea(
          top: false,
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              final sp = EdgeInsets.only(bottom: bottomInset + 120);

              Future<void> pickDate(
                void Function(void Function()) setSheetState,
              ) async {
                FocusScope.of(context).unfocus();
                DateTime temp;
                try {
                  final txt = dateCtrl.text.trim();
                  temp = txt.isEmpty ? DateTime.now() : df.parse(txt);
                } catch (_) {
                  temp = DateTime.now();
                }

                await showCupertinoModalPopup(
                  context: context,
                  builder: (_) => Container(
                    height: 300,
                    color: AppTheme.surfaceWhite,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppTheme.dividerColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Text('Cancel'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                child: const Text('Done'),
                                onPressed: () {
                                  setSheetState(() {
                                    dateCtrl.text = df.format(temp);
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            initialDateTime: temp,
                            onDateTimeChanged: (d) => temp = d,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // Helper to show GL picker
              void showGLPicker(void Function(void Function()) setSheetState) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => GLAccountPickerScreen(
                      onSelected: (gl) {
                        selectedGL = gl;
                        setSheetState(() {
                          headCtrl.text = '${gl.glCode} - ${gl.glDescription}';
                        });
                      },
                    ),
                  ),
                );
              }

              return StatefulBuilder(
                builder: (context, setSheetState) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                      AppTheme.spacingM,
                      AppTheme.spacingM,
                      AppTheme.spacingM,
                      AppTheme.spacingM + bottomInset,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(AppTheme.spacingM),
                          decoration: const BoxDecoration(
                            color: AppTheme.surfaceWhite,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    existing == null
                                        ? 'Add Imprest Entry'
                                        : 'Edit Imprest Entry',
                                    style: AppTheme.headline3.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const Spacer(),
                                  CupertinoButton(
                                    padding: EdgeInsets.zero,
                                    minSize: 0,
                                    onPressed: close,
                                    child: const Icon(
                                      CupertinoIcons.xmark_circle_fill,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // Date Picker
                              GestureDetector(
                                onTap: () => pickDate(setSheetState),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppTheme.backgroundLight,
                                    border: Border.all(
                                      color: AppTheme.dividerColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    dateCtrl.text.isEmpty
                                        ? 'Select Date'
                                        : dateCtrl.text,
                                    style: TextStyle(
                                      color: dateCtrl.text.isEmpty
                                          ? AppTheme.textSecondary
                                          : AppTheme.textPrimary,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),
                              IOSTextField(
                                controller: vrCtrl,
                                label: 'Vr. No',
                                placeholder: 'e.g. 15',
                                scrollPadding: sp,
                              ),

                              const SizedBox(height: 10),

                              // GL Code Selection (Same pattern as payment authority)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 4,
                                      bottom: 6,
                                    ),
                                    child: Text(
                                      'Head/GL Code',
                                      style: AppTheme.caption.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: AppTheme.textSecondary,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => showGLPicker(setSheetState),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppTheme.backgroundLight,
                                        border: Border.all(
                                          color: AppTheme.dividerColor,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            CupertinoIcons.search,
                                            size: 16,
                                            color: AppTheme.primaryBlue,
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              headCtrl.text.isEmpty
                                                  ? 'Select GL Account'
                                                  : headCtrl.text,
                                              style: TextStyle(
                                                color: headCtrl.text.isEmpty
                                                    ? AppTheme.textSecondary
                                                    : AppTheme.textPrimary,
                                                fontSize: 15,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (headCtrl.text.isNotEmpty)
                                            CupertinoButton(
                                              padding: EdgeInsets.zero,
                                              minSize: 0,
                                              onPressed: () {
                                                setSheetState(() {
                                                  headCtrl.clear();
                                                  selectedGL = null;
                                                });
                                              },
                                              child: const Icon(
                                                CupertinoIcons
                                                    .clear_circled_solid,
                                                size: 18,
                                                color: AppTheme.textSecondary,
                                              ),
                                            ),
                                          const Icon(
                                            CupertinoIcons.chevron_right,
                                            size: 16,
                                            color: AppTheme.textSecondary,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),
                              IOSTextField(
                                controller: txnCtrl,
                                label: 'Transaction',
                                placeholder: 'e.g. Stationery purchase',
                                textCapitalization:
                                    TextCapitalization.sentences,
                                maxLines: 2,
                                scrollPadding: sp,
                              ),
                              const SizedBox(height: 10),
                              IOSTextField(
                                controller: payCtrl,
                                label: 'Amount payable',
                                placeholder: 'e.g. 2500',
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                scrollPadding: sp,
                              ),

                              const SizedBox(height: 16),
                              CupertinoButton.filled(
                                onPressed: save,
                                child: Text(
                                  existing == null
                                      ? 'Add Entry'
                                      : 'Save Changes',
                                ),
                              ),
                              const SizedBox(height: 8),
                              CupertinoButton(
                                onPressed: close,
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImprestEntriesSection() {
    final doc = ref.watch(tiDocumentProvider);
    final entries = doc.imprestEntries;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          '5. Imprest Entries (Page-3)',
          CupertinoIcons.list_bullet_below_rectangle,
        ),
        const SizedBox(height: 10),
        _buildSectionCard([
          Row(
            children: [
              Text('Entries: ${entries.length}', style: AppTheme.caption),
              const Spacer(),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _openImprestEntryEditor(),
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.add_circled_solid, size: 18),
                    SizedBox(width: 6),
                    Text('Add Entry'),
                  ],
                ),
              ),
            ],
          ),

          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'No entries added yet. Tap "Add Entry".',
                style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
              ),
            ),

          if (entries.isNotEmpty) ...[
            const SizedBox(height: 10),
            ...List.generate(entries.length, (i) {
              final e = entries[i];

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ImprestEntryCard(
                  entry: e,
                  index: i,
                  onDelete: () {
                    // Delete from provider
                    ref.read(tiDocumentProvider.notifier).removeImprestEntry(i);

                    // Recalculate totals
                    _recalculateTotals();

                    // Force rebuild to reflect deletion immediately
                    if (mounted) setState(() {});
                  },
                  onEdit: () => _openImprestEntryEditor(existing: e, index: i),
                ),
              );
            }),
          ],
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch state
    ref.watch(tiDocumentProvider);

    final entries = ref.read(tiDocumentProvider).imprestEntries;
    final canGenerate =
        _omNumberController.text.trim().isNotEmpty &&
        entries.isNotEmpty && // Must have entries
        _purposeController.text.trim().isNotEmpty &&
        _recommendingOfficeController.text.trim().isNotEmpty &&
        _selectedEmployee != null &&
        _selectedDivision != null;

    return Stack(
      children: [
        CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundLight,
          navigationBar: CupertinoNavigationBar(
            middle: const Text('Create TI Document'),
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _isGeneratingPdf ? null : _handleBack,
              child: const Icon(CupertinoIcons.back),
            ),
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppTheme.spacingM),
                children: [
                  // ==========================================================
                  // 1. Division & OM Details
                  // ==========================================================
                  _buildSectionHeader(
                    '1. Division & OM Details',
                    CupertinoIcons.doc_text,
                  ),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    // Division First
                    DivisionSearchField(
                      selectedDivision: _selectedDivision,
                      onChanged: (division) =>
                          setState(() => _selectedDivision = division),
                    ),
                    const Divider(height: 24, color: AppTheme.dividerColor),

                    // OM Number
                    IOSTextField(
                      controller: _omNumberController,
                      label: 'OM Number',
                      placeholder: 'e.g. 451',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),

                    // OM Date
                    _buildDateField(
                      'OM Date',
                      _omDate,
                      (d) => setState(() => _omDate = d),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ==========================================================
                  // 2. Employee & Recommending Details
                  // ==========================================================
                  _buildSectionHeader(
                    '2. Employee & Recommending Office',
                    CupertinoIcons.person_2_fill,
                  ),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    // Employee Selection
                    _buildSelectionField(
                      label: 'Employee',
                      value: _selectedEmployee?.displayText,
                      placeholder: 'Select Employee',
                      icon: CupertinoIcons.person_fill,
                      onTap: _showEmployeeSelector,
                    ),
                    const Divider(height: 24, color: AppTheme.dividerColor),

                    // Recommending Office (Read-Only)
                    IOSTextField(
                      controller: _recommendingOfficeController,
                      label: 'Recommending Office',
                      placeholder: 'Auto-filled from Employee',
                      readOnly: true, // READ ONLY
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 12),

                    // Letter Number
                    IOSTextField(
                      controller: _letterNumberController,
                      label: 'Letter Number',
                      placeholder: 'e.g. O 416 GM',
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 12),

                    // Letter Date
                    _buildDateField(
                      'Letter Date',
                      _letterDate,
                      (d) => setState(() => _letterDate = d),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ==========================================================
                  // 3. Purpose
                  // ==========================================================
                  _buildSectionHeader('3. Purpose', CupertinoIcons.text_quote),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    IOSTextField(
                      controller: _purposeController,
                      label: 'Purpose',
                      placeholder: 'e.g. For official travel',
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (_) => setState(() {}),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ==========================================================
                  // 4. Amount & Vouchers (Calculated)
                  // ==========================================================
                  _buildSectionHeader(
                    '4. Amount (Calculated)',
                    CupertinoIcons.money_dollar_circle,
                  ),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    IOSTextField(
                      controller: _amountController,
                      label: 'Total Amount (Rs.)',
                      placeholder: '0',
                      readOnly: true, // READ ONLY
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 12),
                    IOSTextField(
                      controller: _vouchersCountController,
                      label: 'No. of vouchers',
                      placeholder: '0',
                      readOnly: true, // READ ONLY
                      onChanged: (_) {},
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ==========================================================
                  // 5. Imprest Entries
                  // ==========================================================
                  _buildImprestEntriesSection(),

                  const SizedBox(height: 32),

                  // ==========================================================
                  // Generate Button
                  // ==========================================================
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: canGenerate && !_isGeneratingPdf
                        ? _generatePDF
                        : null,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: canGenerate && !_isGeneratingPdf
                            ? AppTheme.primaryBlue
                            : AppTheme.dividerColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Generate PDF',
                        style: TextStyle(
                          color: canGenerate
                              ? Colors.white
                              : AppTheme.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),

        if (_isGeneratingPdf)
          Container(
            color: Colors.black12,
            child: const Center(child: CupertinoActivityIndicator()),
          ),
      ],
    );
  }

  // ... (Helper widgets: _buildSectionHeader, _buildSectionCard, _buildDateField, _buildSelectionField - Keep same as before) ...
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
    ValueChanged<DateTime> onChanged,
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
