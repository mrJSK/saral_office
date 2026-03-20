// lib/features/ti_document/screens/create_ti_document_screen.dart

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:saral_office/features/payment_authority/screens/create_authority_screen.dart';

import '../../../core/database/models/gl_account.dart';
import '../../../core/di/injection.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/division.dart';

import '../../employee/models/employee.dart';
import '../../employee/providers/employee_provider.dart';
import '../../employee/screens/employee_management_screen.dart';

import '../models/imprest_ledger_entry.dart';
import '../providers/ti_document_provider.dart';
import '../widgets/imprest_entry_card.dart';

import '../../payment_authority/widgets/ios_text_field.dart';
import '../../../core/widgets/custom_date_picker.dart';
import '../../payment_authority/widgets/division_search_field.dart';
import '../../payment_authority/providers/payment_authority_provider.dart'
    show markGlAsUsedProvider;

class CreateTIDocumentScreen extends ConsumerStatefulWidget {
  const CreateTIDocumentScreen({super.key});

  @override
  ConsumerState<CreateTIDocumentScreen> createState() =>
      _CreateTIDocumentScreenState();
}

class _CreateTIDocumentScreenState
    extends ConsumerState<CreateTIDocumentScreen>
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
  final _recommendingOfficeController = TextEditingController();
  final _letterNumberController = TextEditingController();
  DateTime _letterDate = DateTime.now();

  // 3. Purpose
  final _purposeController = TextEditingController();

  // 4. Amount & Vouchers (Computed - READ ONLY)
  final _amountController = TextEditingController();
  final _vouchersCountController = TextEditingController();

  // Hidden Office Details (synced for PDF)
  final _officeNameController = TextEditingController();
  final _officeHeadController = TextEditingController();
  final _officeHeadDesignationController = TextEditingController();

  bool _isGeneratingPdf = false;

  bool get _isDesktop =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  bool get _isDark =>
      CupertinoTheme.of(context).brightness == Brightness.dark;
  Color get _bgCol =>
      _isDark ? AppTheme.darkBackground : AppTheme.backgroundLight;
  Color get _cardBg =>
      _isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite;
  Color get _textCol =>
      _isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
  Color get _divCol =>
      _isDark ? AppTheme.darkDivider : AppTheme.dividerColor;

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
    if (document.recommendingOffice != null)
      _recommendingOfficeController.text = document.recommendingOffice!;
    if (document.letterNumber != null)
      _letterNumberController.text = document.letterNumber!;
    if (document.omDate != null) setState(() => _omDate = document.omDate!);
    if (document.letterDate != null)
      setState(() => _letterDate = document.letterDate!);
    if (document.employeeOffice != null)
      _officeNameController.text = document.employeeOffice!;
    if (document.employeeOfficeHead != null)
      _officeHeadController.text = document.employeeOfficeHead!;
    if (document.employeeOfficeHeadDesignation != null)
      _officeHeadDesignationController.text =
          document.employeeOfficeHeadDesignation!;

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

  void _recalculateTotals() {
    final entries = ref.read(tiDocumentProvider).imprestEntries;
    final totalAmount = entries.fold(0.0, (sum, e) => sum + e.payment);
    final count = entries.length;
    _amountController.text = totalAmount.toStringAsFixed(0);
    _vouchersCountController.text = count.toString();
    final notifier = ref.read(tiDocumentProvider.notifier);
    notifier.updateAmount(totalAmount);
    notifier.updateVouchersCount(count);
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
    notifier.updatePurpose(_purposeController.text.trim());
    if (_selectedDivision != null) notifier.updateDivision(_selectedDivision!);
    if (_selectedEmployee != null) notifier.updateEmployee(_selectedEmployee!);
    notifier.updateEmployeeOfficeDetails(
      office: _officeNameController.text.trim(),
      head: _officeHeadController.text.trim(),
      headDesignation: _officeHeadDesignationController.text.trim(),
    );
  }

  Future<void> _generatePDF() async {
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
          'Recommending Office is missing. Please re-select the Employee.');
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
    if (ref.read(tiDocumentProvider).imprestEntries.isEmpty) {
      _showErrorDialog('Please add at least one Imprest Entry.');
      return;
    }

    setState(() => _isGeneratingPdf = true);
    try {
      _syncToState();
      await ref.read(tiDocumentProvider.notifier).generateAndSavePDF(
            includeImprestPage: true,
            includeHandReceiptPage: true,
          );

      if (!mounted) return;
      await showCupertinoDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => CupertinoAlertDialog(
          title: const Row(
            children: [
              Icon(CupertinoIcons.check_mark_circled_solid,
                  color: AppTheme.successGreen, size: 24),
              SizedBox(width: 8),
              Text('Success'),
            ],
          ),
          content: const Text(
              'TI Document has been generated and opened successfully!'),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
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
        title: const Row(
          children: [
            Icon(CupertinoIcons.exclamationmark_triangle_fill,
                color: AppTheme.errorRed, size: 24),
            SizedBox(width: 8),
            Text('Error'),
          ],
        ),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  void _handleBack() {
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
            'You have unsaved changes. Are you sure you want to go back?'),
        actions: [
          CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context)),
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

  // Called by both desktop inline search and mobile full-screen picker
  void _onEmployeeSelected(Employee employee) {
    setState(() => _selectedEmployee = employee);
    ref.read(tiDocumentProvider.notifier).updateEmployee(employee);

    final office = employee.office.trim();
    final headName = employee.officeHead.trim();
    final headDesig = employee.officeHeadDesignation.trim();

    String autoVal = '';
    if (headDesig.isNotEmpty && office.isNotEmpty) {
      autoVal = '$headDesig, $office';
    } else if (headDesig.isNotEmpty) {
      autoVal = headDesig;
    } else if (office.isNotEmpty) {
      autoVal = office;
    }
    _recommendingOfficeController.text = autoVal;
    _officeNameController.text = office;
    _officeHeadController.text = headName;
    _officeHeadDesignationController.text = headDesig;
    ref.read(tiDocumentProvider.notifier).updateEmployeeOfficeDetails(
          office: office,
          head: headName,
          headDesignation: headDesig,
        );
    setState(() {}); // refresh recommending office display
  }

  // Mobile: full-screen employee selector
  void _showEmployeeSelector() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => EmployeeManagementScreen(
          isSelectionMode: true,
          onEmployeeSelected: _onEmployeeSelected,
        ),
      ),
    );
  }

  // Imprest entry editor modal (used for EDIT on both platforms, ADD on mobile)
  Future<void> _openImprestEntryEditor({
    ImprestLedgerEntry? existing,
    int? index,
  }) async {
    final df = DateFormat('dd/MM/yyyy');
    final dateCtrl =
        TextEditingController(text: existing?.date.trim() ?? '');
    final vrCtrl = TextEditingController(text: existing?.vrNo ?? '');
    final headCtrl = TextEditingController(text: existing?.head ?? '');
    final txnCtrl =
        TextEditingController(text: existing?.transaction ?? '');
    final payCtrl = TextEditingController(
      text: existing != null ? existing.payment.toStringAsFixed(0) : '',
    );
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
      if (date.isEmpty || vrNo.isEmpty || head.isEmpty || txn.isEmpty ||
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
                  void Function(void Function()) setSheetState) async {
                FocusScope.of(context).unfocus();
                DateTime temp;
                try {
                  final txt = dateCtrl.text.trim();
                  temp = txt.isEmpty ? DateTime.now() : df.parse(txt);
                } catch (_) {
                  temp = DateTime.now();
                }
                final picked =
                    await showCustomDatePicker(context: context, initialDate: temp);
                if (picked != null) {
                  setSheetState(() => dateCtrl.text = df.format(picked));
                }
              }

              void showGLPicker(
                  void Function(void Function()) setSheetState) {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => GLAccountPickerScreen(
                      onSelected: (gl) {
                        setSheetState(() =>
                            headCtrl.text =
                                '${gl.glCode} - ${gl.glDescription}');
                      },
                    ),
                  ),
                );
              }

              return StatefulBuilder(
                builder: (context, setSheetState) {
                  final sheetDark = CupertinoTheme.of(context).brightness == Brightness.dark;
                  final sheetBg = sheetDark ? AppTheme.darkSurface : AppTheme.surfaceWhite;
                  final sheetFieldBg = sheetDark ? AppTheme.darkBackground : AppTheme.backgroundLight;
                  final sheetDivCol = sheetDark ? AppTheme.darkDivider : AppTheme.dividerColor;
                  final sheetTextCol = sheetDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: EdgeInsets.fromLTRB(
                        AppTheme.spacingM,
                        AppTheme.spacingM,
                        AppTheme.spacingM,
                        AppTheme.spacingM + bottomInset),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: const EdgeInsets.all(AppTheme.spacingM),
                          decoration: BoxDecoration(
                            color: sheetBg,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(children: [
                                Text(
                                    existing == null
                                        ? 'Add Imprest Entry'
                                        : 'Edit Imprest Entry',
                                    style: AppTheme.headline3.copyWith(
                                        fontWeight: FontWeight.w800)),
                                const Spacer(),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  onPressed: close,
                                  child: const Icon(
                                      CupertinoIcons.xmark_circle_fill),
                                ),
                              ]),
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => pickDate(setSheetState),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: sheetFieldBg,
                                    border: Border.all(color: sheetDivCol),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    dateCtrl.text.isEmpty
                                        ? 'Select Date'
                                        : dateCtrl.text,
                                    style: TextStyle(
                                        color: dateCtrl.text.isEmpty
                                            ? AppTheme.textSecondary
                                            : sheetTextCol,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              IOSTextField(
                                  controller: vrCtrl,
                                  label: 'Vr. No',
                                  placeholder: 'e.g. 15',
                                  scrollPadding: sp),
                              const SizedBox(height: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 6),
                                    child: Text('Head/GL Code',
                                        style: AppTheme.caption.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.textSecondary)),
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        showGLPicker(setSheetState),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: sheetFieldBg,
                                        border: Border.all(color: sheetDivCol),
                                        borderRadius:
                                            BorderRadius.circular(10),
                                      ),
                                      child: Row(children: [
                                        const Icon(CupertinoIcons.search,
                                            size: 16,
                                            color: AppTheme.primaryBlue),
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
                                                fontSize: 15),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (headCtrl.text.isNotEmpty)
                                          CupertinoButton(
                                            padding: EdgeInsets.zero,
                                            minimumSize: Size.zero,
                                            onPressed: () => setSheetState(
                                                () => headCtrl.clear()),
                                            child: const Icon(
                                                CupertinoIcons
                                                    .clear_circled_solid,
                                                size: 18,
                                                color:
                                                    AppTheme.textSecondary),
                                          ),
                                        const Icon(
                                            CupertinoIcons.chevron_right,
                                            size: 16,
                                            color: AppTheme.textSecondary),
                                      ]),
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
                                  scrollPadding: sp),
                              const SizedBox(height: 10),
                              IOSTextField(
                                  controller: payCtrl,
                                  label: 'Amount payable',
                                  placeholder: 'e.g. 2500',
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  scrollPadding: sp),
                              const SizedBox(height: 16),
                              CupertinoButton.filled(
                                  onPressed: save,
                                  child: Text(existing == null
                                      ? 'Add Entry'
                                      : 'Save Changes')),
                              const SizedBox(height: 8),
                              CupertinoButton(
                                  onPressed: close,
                                  child: const Text('Cancel')),
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

  // ─────────────────────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    ref.watch(tiDocumentProvider);
    return _isDesktop ? _buildDesktopLayout() : _buildMobileLayout();
  }

  // ─────────────────────────────────────────────────────────────
  // DESKTOP LAYOUT
  // ─────────────────────────────────────────────────────────────

  Widget _buildDesktopLayout() {
    final doc = ref.watch(tiDocumentProvider);
    final entries = doc.imprestEntries;
    final canGenerate = _omNumberController.text.trim().isNotEmpty &&
        entries.isNotEmpty &&
        _purposeController.text.trim().isNotEmpty &&
        _recommendingOfficeController.text.trim().isNotEmpty &&
        _selectedEmployee != null &&
        _selectedDivision != null;

    return Stack(
      children: [
        CupertinoPageScaffold(
          backgroundColor: _bgCol,
          child: Column(
            children: [
              _buildDesktopTopBar(canGenerate),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          width: 420, child: _buildDesktopLeftPanel()),
                      Container(width: 1, color: _divCol),
                      Expanded(
                          child: _buildDesktopRightPanel(entries)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isGeneratingPdf) _buildLoadingOverlay(),
      ],
    );
  }

  Widget _buildDesktopTopBar(bool canGenerate) {
    return Container(
      height: 52,
      color: _isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
      child: Row(
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: _isGeneratingPdf ? null : _handleBack,
            child: const Row(
              children: [
                Icon(CupertinoIcons.back,
                    size: 18, color: AppTheme.primaryBlue),
                SizedBox(width: 4),
                Text('Back',
                    style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        color: AppTheme.primaryBlue)),
              ],
            ),
          ),
          Expanded(
            child: Text(
              'Create TI Document',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: _textCol),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed:
                (canGenerate && !_isGeneratingPdf) ? _generatePDF : null,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: (canGenerate && !_isGeneratingPdf)
                    ? AppTheme.primaryBlue
                    : AppTheme.dividerColor,
                borderRadius:
                    BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Row(children: [
                Icon(CupertinoIcons.doc_text_fill,
                    size: 15,
                    color: canGenerate
                        ? AppTheme.surfaceWhite
                        : AppTheme.textSecondary),
                const SizedBox(width: 6),
                Text(
                  'Generate PDF',
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: canGenerate
                          ? AppTheme.surfaceWhite
                          : AppTheme.textSecondary),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLeftPanel() {
    final entries = ref.watch(tiDocumentProvider).imprestEntries;
    final totalAmount = entries.fold(0.0, (s, e) => s + e.payment);

    return Container(
      color: _bgCol,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Division & OM ────────────────────────────────
            _buildSectionHeader(
                'Division & OM Details', CupertinoIcons.doc_text),
            const SizedBox(height: AppTheme.spacingM),
            _buildDesktopCard([
              DivisionSearchField(
                selectedDivision: _selectedDivision,
                onChanged: (d) => setState(() => _selectedDivision = d),
              ),
              const SizedBox(height: AppTheme.spacingM),
              Row(children: [
                Expanded(
                  child: IOSTextField(
                    controller: _omNumberController,
                    label: 'OM Number',
                    placeholder: 'e.g. 451',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                    child: _buildDesktopDateField(
                        'OM Date', _omDate,
                        (d) => setState(() => _omDate = d))),
              ]),
            ]),

            const SizedBox(height: AppTheme.spacingL),

            // ── Employee & Recommending ───────────────────────
            _buildSectionHeader(
                'Employee & Recommending Office',
                CupertinoIcons.person_2_fill),
            const SizedBox(height: AppTheme.spacingM),
            _buildDesktopCard([
              _DesktopEmployeeSearchField(
                selectedEmployee: _selectedEmployee,
                onChanged: _onEmployeeSelected,
              ),
              if (_recommendingOfficeController.text.isNotEmpty) ...[
                const SizedBox(height: AppTheme.spacingM),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppTheme.primaryBlue
                            .withValues(alpha: 0.2)),
                  ),
                  child: Row(children: [
                    const Icon(CupertinoIcons.building_2_fill,
                        size: 14, color: AppTheme.primaryBlue),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _recommendingOfficeController.text,
                        style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 13,
                            color: _textCol),
                      ),
                    ),
                  ]),
                ),
              ],
              const SizedBox(height: AppTheme.spacingM),
              Row(children: [
                Expanded(
                  child: IOSTextField(
                    controller: _letterNumberController,
                    label: 'Letter Number',
                    placeholder: 'e.g. O 416 GM',
                    onChanged: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                    child: _buildDesktopDateField(
                        'Letter Date',
                        _letterDate,
                        (d) => setState(() => _letterDate = d))),
              ]),
            ]),

            const SizedBox(height: AppTheme.spacingL),

            // ── Purpose ──────────────────────────────────────
            _buildSectionHeader(
                'Purpose', CupertinoIcons.text_quote),
            const SizedBox(height: AppTheme.spacingM),
            _buildDesktopCard([
              IOSTextField(
                controller: _purposeController,
                label: 'Purpose',
                placeholder: 'e.g. For official travel expenses',
                textCapitalization: TextCapitalization.sentences,
                maxLines: 3,
                onChanged: (_) => setState(() {}),
              ),
            ]),

            const SizedBox(height: AppTheme.spacingL),

            // ── Summary tiles ────────────────────────────────
            _buildSectionHeader(
                'Summary', CupertinoIcons.chart_bar_fill),
            const SizedBox(height: AppTheme.spacingM),
            _buildDesktopCard([
              Row(children: [
                Expanded(
                    child: _buildSummaryTile(
                  label: 'Total Amount',
                  value: '₹${_fmt(totalAmount)}',
                  icon: CupertinoIcons.money_dollar_circle,
                  color: AppTheme.primaryBlue,
                )),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                    child: _buildSummaryTile(
                  label: 'Vouchers',
                  value: '${entries.length}',
                  icon: CupertinoIcons.doc_on_doc_fill,
                  color: AppTheme.successGreen,
                )),
              ]),
            ]),

            const SizedBox(height: AppTheme.spacingL),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopRightPanel(List<ImprestLedgerEntry> entries) {
    return Container(
      color: _bgCol,
      child: Column(
        children: [
          Flexible(
            flex: 6,
            fit: FlexFit.tight,
            child: _DesktopImprestTable(
              entries: entries,
              onDelete: (index) {
                ref
                    .read(tiDocumentProvider.notifier)
                    .removeImprestEntry(index);
                _recalculateTotals();
              },
              onInsertAt: (entry, index) {
                ref
                    .read(tiDocumentProvider.notifier)
                    .insertImprestEntryAt(index, entry);
                _recalculateTotals();
              },
              onHandReceiptToggle: (index, entry) {
                ref
                    .read(tiDocumentProvider.notifier)
                    .updateImprestEntry(index, entry);
              },
              onEdit: (index, entry) =>
                  _openImprestEntryEditor(existing: entry, index: index),
            ),
          ),
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              decoration: BoxDecoration(
                color: _cardBg,
                border: Border(top: BorderSide(color: _divCol)),
              ),
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: _InlineAddImprestEntryForm(
                onAdd: (entry) {
                  ref
                      .read(tiDocumentProvider.notifier)
                      .addImprestEntry(entry);
                  _recalculateTotals();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
              color: CupertinoColors.systemGrey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children),
    );
  }

  Widget _buildSummaryTile({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(height: 6),
        Text(value,
            style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: color)),
        const SizedBox(height: 2),
        Text(label, style: AppTheme.caption),
      ]),
    );
  }

  Widget _buildDesktopDateField(
      String label, DateTime date, ValueChanged<DateTime> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTheme.caption
                .copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _showDatePickerDialog(date, onChanged),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: _isDark ? AppTheme.darkSurface : AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: _isDark
                    ? AppTheme.primaryBlue.withValues(alpha: 0.35)
                    : _divCol,
                width: 1,
              ),
            ),
            child: Row(children: [
              const Icon(CupertinoIcons.calendar,
                  size: 18, color: AppTheme.primaryBlue),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(DateFormat('dd MMM yyyy').format(date),
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 15,
                        color: _textCol,
                      ))),
            ]),
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePickerDialog(
      DateTime initialDate, ValueChanged<DateTime> onChanged) async {
    final picked = await showCustomDatePicker(
      context: context,
      initialDate: initialDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) onChanged(picked);
  }

  // ─────────────────────────────────────────────────────────────
  // MOBILE LAYOUT (unchanged)
  // ─────────────────────────────────────────────────────────────

  Widget _buildMobileLayout() {
    final entries = ref.read(tiDocumentProvider).imprestEntries;
    final canGenerate = _omNumberController.text.trim().isNotEmpty &&
        entries.isNotEmpty &&
        _purposeController.text.trim().isNotEmpty &&
        _recommendingOfficeController.text.trim().isNotEmpty &&
        _selectedEmployee != null &&
        _selectedDivision != null;

    return Stack(
      children: [
        CupertinoPageScaffold(
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
                  _buildSectionHeader(
                      '1. Division & OM Details', CupertinoIcons.doc_text),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    DivisionSearchField(
                      selectedDivision: _selectedDivision,
                      onChanged: (d) =>
                          setState(() => _selectedDivision = d),
                    ),
                    const Divider(
                        height: 24, color: AppTheme.dividerColor),
                    IOSTextField(
                        controller: _omNumberController,
                        label: 'OM Number',
                        placeholder: 'e.g. 451',
                        onChanged: (_) => setState(() {})),
                    const SizedBox(height: 12),
                    _buildMobileDateField('OM Date', _omDate,
                        (d) => setState(() => _omDate = d)),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionHeader(
                      '2. Employee & Recommending Office',
                      CupertinoIcons.person_2_fill),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    _buildSelectionField(
                      label: 'Employee',
                      value: _selectedEmployee?.displayText,
                      placeholder: 'Select Employee',
                      icon: CupertinoIcons.person_fill,
                      onTap: _showEmployeeSelector,
                    ),
                    const Divider(
                        height: 24, color: AppTheme.dividerColor),
                    IOSTextField(
                        controller: _recommendingOfficeController,
                        label: 'Recommending Office',
                        placeholder: 'Auto-filled from Employee',
                        readOnly: true,
                        onChanged: (_) {}),
                    const SizedBox(height: 12),
                    IOSTextField(
                        controller: _letterNumberController,
                        label: 'Letter Number',
                        placeholder: 'e.g. O 416 GM',
                        onChanged: (_) => setState(() {})),
                    const SizedBox(height: 12),
                    _buildMobileDateField('Letter Date', _letterDate,
                        (d) => setState(() => _letterDate = d)),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionHeader(
                      '3. Purpose', CupertinoIcons.text_quote),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    IOSTextField(
                        controller: _purposeController,
                        label: 'Purpose',
                        placeholder: 'e.g. For official travel',
                        textCapitalization: TextCapitalization.sentences,
                        onChanged: (_) => setState(() {})),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionHeader('4. Amount (Calculated)',
                      CupertinoIcons.money_dollar_circle),
                  const SizedBox(height: 10),
                  _buildSectionCard([
                    IOSTextField(
                        controller: _amountController,
                        label: 'Total Amount (Rs.)',
                        placeholder: '0',
                        readOnly: true,
                        onChanged: (_) {}),
                    const SizedBox(height: 12),
                    IOSTextField(
                        controller: _vouchersCountController,
                        label: 'No. of vouchers',
                        placeholder: '0',
                        readOnly: true,
                        onChanged: (_) {}),
                  ]),
                  const SizedBox(height: 24),
                  _buildImprestEntriesSection(),
                  const SizedBox(height: 32),
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
                            fontWeight: FontWeight.w600),
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
              child: const Center(child: CupertinoActivityIndicator())),
      ],
    );
  }

  Widget _buildImprestEntriesSection() {
    final doc = ref.watch(tiDocumentProvider);
    final entries = doc.imprestEntries;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('5. Imprest Entries (Page-3)',
            CupertinoIcons.list_bullet_below_rectangle),
        const SizedBox(height: 10),
        _buildSectionCard([
          Row(children: [
            Text('Entries: ${entries.length}', style: AppTheme.caption),
            const Spacer(),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _openImprestEntryEditor(),
              child: const Row(children: [
                Icon(CupertinoIcons.add_circled_solid, size: 18),
                SizedBox(width: 6),
                Text('Add Entry'),
              ]),
            ),
          ]),
          if (entries.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('No entries added yet. Tap "Add Entry".',
                  style: AppTheme.caption
                      .copyWith(color: AppTheme.textSecondary)),
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
                    ref
                        .read(tiDocumentProvider.notifier)
                        .removeImprestEntry(i);
                    _recalculateTotals();
                    if (mounted) setState(() {});
                  },
                  onEdit: () =>
                      _openImprestEntryEditor(existing: e, index: i),
                  onHandReceiptToggle: (updatedEntry) {
                    ref
                        .read(tiDocumentProvider.notifier)
                        .updateImprestEntry(i, updatedEntry);
                  },
                ),
              );
            }),
          ],
        ]),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // SHARED WIDGETS
  // ─────────────────────────────────────────────────────────────

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: (_isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite).withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CupertinoActivityIndicator(radius: 14),
              const SizedBox(height: 12),
              Text(
                'Generating PDF...',
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _textCol,
                    decoration: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: AppTheme.primaryBlue),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: _textCol),
        ),
      ],
    );
  }

  Widget _buildSectionCard(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildMobileDateField(
      String label, DateTime date, ValueChanged<DateTime> onChanged) {
    return GestureDetector(
      onTap: () => _showMobileDatePicker(date, onChanged),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: _isDark ? AppTheme.darkSurface : AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: _isDark
                  ? AppTheme.primaryBlue.withValues(alpha: 0.35)
                  : _divCol,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              const Icon(CupertinoIcons.calendar,
                  size: 16, color: AppTheme.primaryBlue),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      fontSize: 15, color: AppTheme.textSecondary)),
            ]),
            Text(DateFormat('dd MMM yyyy').format(date),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: _textCol)),
          ],
        ),
      ),
    );
  }

  void _showMobileDatePicker(
      DateTime initial, ValueChanged<DateTime> onChanged) {
    final normalized =
        DateTime(initial.year, initial.month, initial.day);
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => Container(
        height: 300,
        color: CupertinoTheme.of(ctx).brightness == Brightness.dark
            ? AppTheme.darkSurface
            : AppTheme.surfaceWhite,
        child: Column(children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: AppTheme.dividerColor, width: 0.5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context)),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Text('Done'),
                    onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
          Expanded(
              child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: normalized,
                  onDateTimeChanged: onChanged)),
        ]),
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
            Row(children: [
              Icon(icon, size: 16, color: AppTheme.primaryBlue),
              const SizedBox(width: 8),
              Text(label,
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: _textCol)),
            ]),
            Row(children: [
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
                          : FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(CupertinoIcons.chevron_right,
                  size: 16, color: AppTheme.textSecondary),
            ]),
          ],
        ),
      ),
    );
  }

  String _fmt(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final dec = parts[1];
    final buf = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      final fromEnd = intPart.length - 1 - i;
      buf.write(intPart[i]);
      if (fromEnd > 0) {
        if (fromEnd == 3 || (fromEnd > 3 && (fromEnd - 3) % 2 == 0))
          buf.write(',');
      }
    }
    return '$buf.$dec';
  }
}

// ─────────────────────────────────────────────────────────────
// DESKTOP: Inline Employee Search Field
// ─────────────────────────────────────────────────────────────

class _DesktopEmployeeSearchField extends ConsumerStatefulWidget {
  final Employee? selectedEmployee;
  final ValueChanged<Employee> onChanged;

  const _DesktopEmployeeSearchField({
    required this.selectedEmployee,
    required this.onChanged,
  });

  @override
  ConsumerState<_DesktopEmployeeSearchField> createState() =>
      _DesktopEmployeeSearchFieldState();
}

class _DesktopEmployeeSearchFieldState
    extends ConsumerState<_DesktopEmployeeSearchField> {
  final _controller = TextEditingController();
  String _query = '';
  bool _showDropdown = false;

  bool get _isDark => CupertinoTheme.of(context).brightness == Brightness.dark;
  Color get _fieldBg => _isDark ? AppTheme.darkSurface : AppTheme.backgroundLight;
  Color get _dropdownBg => _isDark ? AppTheme.darkCard : AppTheme.surfaceWhite;
  Color get _divCol => _isDark ? AppTheme.darkDivider : AppTheme.dividerColor;
  Color get _textCol => _isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;

  @override
  void initState() {
    super.initState();
    if (widget.selectedEmployee != null)
      _controller.text = widget.selectedEmployee!.displayText;
  }

  @override
  void didUpdateWidget(_DesktopEmployeeSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedEmployee != oldWidget.selectedEmployee) {
      if (widget.selectedEmployee != null) {
        _controller.text = widget.selectedEmployee!.displayText;
      } else {
        _controller.clear();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeesAsync = ref.watch(employeeSearchProvider(_query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Employee',
            style: AppTheme.caption
                .copyWith(fontWeight: FontWeight.w500, fontSize: 12)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: _fieldBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _showDropdown
                  ? AppTheme.primaryBlue
                  : _divCol,
              width: _showDropdown ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(children: [
            const Icon(CupertinoIcons.person_fill,
                size: 18, color: AppTheme.primaryBlue),
            const SizedBox(width: 8),
            Expanded(
              child: CupertinoTextField(
                controller: _controller,
                placeholder:
                    'Search by name, designation or SAP ID',
                decoration: const BoxDecoration(),
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 15,
                    color: _textCol),
                placeholderStyle: AppTheme.body2,
                onTap: () => setState(() => _showDropdown = true),
                onChanged: (val) => setState(() {
                  _query = val;
                  _showDropdown = true;
                }),
              ),
            ),
            if (widget.selectedEmployee != null)
              GestureDetector(
                onTap: () {
                  _controller.clear();
                  setState(() {
                    _query = '';
                    _showDropdown = false;
                  });
                },
                child: const Icon(CupertinoIcons.xmark_circle_fill,
                    size: 18, color: AppTheme.textSecondary),
              ),
          ]),
        ),
        if (_showDropdown)
          Container(
            constraints: const BoxConstraints(maxHeight: 220),
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: _dropdownBg,
              borderRadius:
                  BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(color: _divCol),
              boxShadow: [
                BoxShadow(
                    color: CupertinoColors.systemGrey
                        .withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4))
              ],
            ),
            child: employeesAsync.when(
              data: (employees) {
                if (employees.isEmpty) {
                  return const Padding(
                      padding: EdgeInsets.all(AppTheme.spacingM),
                      child: Text('No employees found',
                          style: AppTheme.caption));
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: employees.length,
                  separatorBuilder: (_, _) => Divider(
                      height: 1, color: _divCol),
                  itemBuilder: (ctx, i) {
                    final emp = employees[i];
                    return _TIHoverableRow(
                      onTap: () {
                        _controller.text = emp.displayText;
                        setState(
                            () {
                          _query = '';
                          _showDropdown = false;
                        });
                        widget.onChanged(emp);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppTheme.primaryBlue
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                                CupertinoIcons.person_fill,
                                size: 14,
                                color: AppTheme.primaryBlue),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    emp.employeeName,
                                    style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: _textCol),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                      '${emp.designation} · ${emp.sapId}',
                                      style: AppTheme.caption),
                                ]),
                          ),
                        ]),
                      ),
                    );
                  },
                );
              },
              loading: () => const Padding(
                  padding: EdgeInsets.all(AppTheme.spacingM),
                  child: CupertinoActivityIndicator()),
              error: (_, _) => const Padding(
                  padding: EdgeInsets.all(AppTheme.spacingM),
                  child: Text('Error loading employees',
                      style: AppTheme.caption)),
            ),
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DESKTOP: Imprest Ledger Table
// ─────────────────────────────────────────────────────────────

class _DesktopImprestTable extends StatefulWidget {
  final List<ImprestLedgerEntry> entries;
  final void Function(int index) onDelete;
  final void Function(ImprestLedgerEntry entry, int index) onInsertAt;
  final void Function(int index, ImprestLedgerEntry entry)
      onHandReceiptToggle;
  final void Function(int index, ImprestLedgerEntry entry) onEdit;

  const _DesktopImprestTable({
    required this.entries,
    required this.onDelete,
    required this.onInsertAt,
    required this.onHandReceiptToggle,
    required this.onEdit,
  });

  @override
  State<_DesktopImprestTable> createState() =>
      _DesktopImprestTableState();
}

class _DesktopImprestTableState extends State<_DesktopImprestTable> {
  ImprestLedgerEntry? _deletedEntry;
  int? _deletedIndex;
  Timer? _undoTimer;
  int _undoSecondsLeft = 0;

  @override
  void dispose() {
    _undoTimer?.cancel();
    super.dispose();
  }

  void _handleDelete(int index) {
    final entry = widget.entries[index];
    _undoTimer?.cancel();
    setState(() {
      _deletedEntry = entry;
      _deletedIndex = index;
      _undoSecondsLeft = 10;
    });
    widget.onDelete(index);
    _undoTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() => _undoSecondsLeft--);
      if (_undoSecondsLeft <= 0) {
        t.cancel();
        setState(() {
          _deletedEntry = null;
          _deletedIndex = null;
        });
      }
    });
  }

  void _handleUndo() {
    if (_deletedEntry == null || _deletedIndex == null) return;
    _undoTimer?.cancel();
    widget.onInsertAt(_deletedEntry!, _deletedIndex!);
    setState(() {
      _deletedEntry = null;
      _deletedIndex = null;
      _undoSecondsLeft = 0;
    });
  }

  String _fmtAmt(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final dec = parts[1];
    final buf = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      final fromEnd = intPart.length - 1 - i;
      buf.write(intPart[i]);
      if (fromEnd > 0) {
        if (fromEnd == 3 || (fromEnd > 3 && (fromEnd - 3) % 2 == 0))
          buf.write(',');
      }
    }
    return '$buf.$dec';
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount =
        widget.entries.fold(0.0, (s, e) => s + e.payment);

    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppTheme.darkBackground : AppTheme.backgroundLight;
    final divCol = isDark ? AppTheme.darkDivider : AppTheme.dividerColor;
    return Container(
      color: bg,
      child: Column(
        children: [
          // Table header
          Container(
            decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.06),
                border: Border(
                    bottom: BorderSide(color: divCol))),
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(children: [
              _hdr('Date', w: 90),
              _hdr('Vr.No', w: 64),
              _hdrFlex('Head / GL Code', flex: 2),
              _hdrFlex('Transaction', flex: 3),
              _hdr('Amount ₹', w: 100, right: true),
              _hdr('Running ₹', w: 110, right: true),
              const SizedBox(width: 34), // HR
              const SizedBox(width: 56), // edit+del
            ]),
          ),

          // Data rows
          Expanded(
            child: widget.entries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: AppTheme.primaryBlue
                                  .withValues(alpha: 0.08),
                              shape: BoxShape.circle),
                          child: const Icon(CupertinoIcons.table,
                              color: AppTheme.primaryBlue, size: 28),
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        Text('No imprest entries yet',
                            style: TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppTheme.darkTextPrimary
                                    : AppTheme.textPrimary)),
                        const SizedBox(height: 4),
                        Text('Use the form below to add entries',
                            style: AppTheme.caption),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: widget.entries.length,
                    separatorBuilder: (_, _) => const Divider(
                        height: 1, color: AppTheme.dividerColor),
                    itemBuilder: (context, i) {
                      final entry = widget.entries[i];
                      return _ImprestTableRow(
                        entry: entry,
                        isEven: i.isEven,
                        onDelete: () => _handleDelete(i),
                        onEdit: () => widget.onEdit(i, entry),
                        onHandReceiptToggle: () =>
                            widget.onHandReceiptToggle(
                                i,
                                entry.copyWith(
                                    isHandReceipt:
                                        !entry.isHandReceipt)),
                      );
                    },
                  ),
          ),

          // Undo banner
          if (_deletedEntry != null)
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF2C2C2E),
                border:
                    Border(top: BorderSide(color: AppTheme.dividerColor)),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 8),
              child: Row(children: [
                const Icon(CupertinoIcons.delete,
                    size: 15, color: Colors.white70),
                const SizedBox(width: 8),
                Expanded(
                    child: Text(
                  'Entry deleted — "${_deletedEntry!.transaction}"',
                  style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      color: Colors.white70),
                  overflow: TextOverflow.ellipsis,
                )),
                Text('${_undoSecondsLeft}s',
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 12,
                        color: Colors.white38)),
                const SizedBox(width: 8),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  onPressed: _handleUndo,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(
                        color: AppTheme.primaryBlue,
                        borderRadius: BorderRadius.circular(6)),
                    child: const Text('Undo',
                        style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white)),
                  ),
                ),
              ]),
            ),

          // Totals row
          Container(
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: divCol)),
                color: isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite),
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: Row(children: [
              const SizedBox(width: 90),
              const SizedBox(width: 64),
              const Expanded(flex: 2, child: SizedBox()),
              Expanded(
                  flex: 3,
                  child: const Text('Total',
                      style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary))),
              SizedBox(
                width: 100,
                child: Text('₹${_fmtAmt(totalAmount)}',
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.primaryBlue)),
              ),
              SizedBox(
                width: 110,
                child: widget.entries.isEmpty
                    ? const SizedBox()
                    : Text(
                        '₹${_fmtAmt(widget.entries.last.total)}',
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryBlue)),
              ),
              const SizedBox(width: 34),
              const SizedBox(width: 56),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _hdr(String label, {required double w, bool right = false}) =>
      SizedBox(
          width: w,
          child: Text(label,
              textAlign: right ? TextAlign.right : TextAlign.left,
              style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryBlue,
                  letterSpacing: 0.3)));

  Widget _hdrFlex(String label, {required int flex}) => Expanded(
      flex: flex,
      child: Text(label,
          style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryBlue,
              letterSpacing: 0.3)));
}

// Single row in the desktop imprest table
class _ImprestTableRow extends StatefulWidget {
  final ImprestLedgerEntry entry;
  final bool isEven;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onHandReceiptToggle;

  const _ImprestTableRow({
    required this.entry,
    required this.isEven,
    required this.onDelete,
    required this.onEdit,
    required this.onHandReceiptToggle,
  });

  @override
  State<_ImprestTableRow> createState() => _ImprestTableRowState();
}

class _ImprestTableRowState extends State<_ImprestTableRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final rowBg = widget.isEven
        ? (isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite)
        : (isDark ? AppTheme.darkBackground : AppTheme.backgroundLight);
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
    final e = widget.entry;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        color: _hovered
            ? AppTheme.primaryBlue.withValues(alpha: 0.04)
            : rowBg,
        padding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
        child: Row(children: [
          // Date
          SizedBox(
              width: 90,
              child: Text(e.date,
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      color: textCol))),
          // Vr. No
          SizedBox(
              width: 64,
              child: Text(e.vrNo,
                  style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary))),
          // Head/GL
          Expanded(
              flex: 2,
              child: Tooltip(
                message: e.head,
                child: Text(e.head,
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 12,
                        color: AppTheme.primaryBlue,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
              )),
          // Transaction
          Expanded(
              flex: 3,
              child: Text(e.transaction,
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      color: textCol),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis)),
          // Amount
          SizedBox(
              width: 100,
              child: Text('₹${e.payment.toStringAsFixed(2)}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textCol))),
          // Running Total
          SizedBox(
              width: 110,
              child: Text('₹${e.total.toStringAsFixed(2)}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.successGreen))),
          // Hand Receipt toggle
          SizedBox(
              width: 34,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                onPressed: widget.onHandReceiptToggle,
                child: Tooltip(
                  message: e.isHandReceipt
                      ? 'Hand Receipt ✓'
                      : 'Mark as Hand Receipt',
                  child: Icon(
                      e.isHandReceipt
                          ? CupertinoIcons.checkmark_seal_fill
                          : CupertinoIcons.checkmark_seal,
                      size: 16,
                      color: e.isHandReceipt
                          ? AppTheme.successGreen
                          : AppTheme.textSecondary),
                ),
              )),
          // Edit + Delete
          SizedBox(
              width: 56,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        onPressed: widget.onEdit,
                        child: const Icon(CupertinoIcons.pencil,
                            size: 14, color: AppTheme.primaryBlue)),
                    const SizedBox(width: 6),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        onPressed: widget.onDelete,
                        child: const Icon(CupertinoIcons.xmark,
                            size: 13,
                            color: AppTheme.textSecondary)),
                  ])),
        ]),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DESKTOP: Inline Add Imprest Entry Form (no modal)
// ─────────────────────────────────────────────────────────────

class _InlineAddImprestEntryForm extends ConsumerStatefulWidget {
  final void Function(ImprestLedgerEntry entry) onAdd;

  const _InlineAddImprestEntryForm({required this.onAdd});

  @override
  ConsumerState<_InlineAddImprestEntryForm> createState() =>
      _InlineAddImprestEntryFormState();
}

class _InlineAddImprestEntryFormState
    extends ConsumerState<_InlineAddImprestEntryForm> {
  final _df = DateFormat('dd/MM/yyyy');
  DateTime _date = DateTime.now();
  final _vrCtrl = TextEditingController();
  final _glSearchCtrl = TextEditingController();
  final _txnCtrl = TextEditingController();
  final _amtCtrl = TextEditingController();
  GLAccount? _selectedGL;
  bool _showGLDropdown = false;
  String _glQuery = '';

  @override
  void dispose() {
    _vrCtrl.dispose();
    _glSearchCtrl.dispose();
    _txnCtrl.dispose();
    _amtCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    final vrNo = _vrCtrl.text.trim();
    final head = _selectedGL != null
        ? '${_selectedGL!.glCode} - ${_selectedGL!.glDescription}'
        : _glSearchCtrl.text.trim();
    final txn = _txnCtrl.text.trim();
    final pay = double.tryParse(_amtCtrl.text.trim()) ?? 0.0;
    if (vrNo.isEmpty || head.isEmpty || txn.isEmpty || pay <= 0) return;

    widget.onAdd(ImprestLedgerEntry(
      date: _df.format(_date),
      vrNo: vrNo,
      transaction: txn,
      payment: pay,
      total: 0.0,
      head: head,
    ));

    _vrCtrl.clear();
    _glSearchCtrl.clear();
    _txnCtrl.clear();
    _amtCtrl.clear();
    setState(() {
      _selectedGL = null;
      _showGLDropdown = false;
      _glQuery = '';
      _date = DateTime.now();
    });
  }

  Future<void> _pickDate() async {
    final picked = await showCustomDatePicker(
      context: context,
      initialDate: _date,
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    final glAccountsAsync = ref.watch(glAccountSearchProvider(_glQuery));
    final df = DateFormat('dd MMM yy');
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final fieldBg = isDark ? AppTheme.darkSurface : AppTheme.backgroundLight;
    final dropdownBg = isDark ? AppTheme.darkCard : AppTheme.surfaceWhite;
    final divCol = isDark ? AppTheme.darkDivider : AppTheme.dividerColor;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(5)),
            child: const Icon(CupertinoIcons.add,
                size: 13, color: AppTheme.primaryBlue),
          ),
          const SizedBox(width: 8),
          Text('Add Imprest Entry',
              style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: textCol)),
        ]),
        const SizedBox(height: 10),

        // Input row
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Date button (90px)
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: 90,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: fieldBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: divCol)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Date',
                          style: AppTheme.caption
                              .copyWith(fontSize: 10)),
                      const SizedBox(height: 2),
                      Text(df.format(_date),
                          style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: textCol)),
                    ]),
              ),
            ),
            const SizedBox(width: 6),
            // Vr. No (64px)
            SizedBox(
                width: 64,
                child: _inlineField(_vrCtrl, 'Vr. No', '15')),
            const SizedBox(width: 6),
            // GL Search (flex 2)
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          color: fieldBg,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: _showGLDropdown
                                  ? AppTheme.primaryBlue
                                  : divCol,
                              width: _showGLDropdown ? 1.5 : 1)),
                      child: CupertinoTextField(
                        controller: _glSearchCtrl,
                        placeholder: _selectedGL != null
                            ? '${_selectedGL!.glCode} — ${_selectedGL!.glDescription}'
                            : 'Search GL account...',
                        decoration: const BoxDecoration(),
                        style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 12,
                            color: textCol),
                        placeholderStyle: AppTheme.caption,
                        onTap: () =>
                            setState(() => _showGLDropdown = true),
                        onChanged: (val) => setState(() {
                          _glQuery = val;
                          _showGLDropdown = true;
                          if (val.isEmpty) _selectedGL = null;
                        }),
                      ),
                    ),
                    if (_showGLDropdown)
                      SizedBox(
                        height: 0,
                        child: OverflowBox(
                          alignment: Alignment.topLeft,
                          maxWidth: 480,
                          minWidth: 0,
                          maxHeight: 200,
                          minHeight: 0,
                          child: Container(
                            width: 480,
                            constraints: const BoxConstraints(maxHeight: 200),
                            decoration: BoxDecoration(
                              color: dropdownBg,
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                              border: Border.all(color: divCol),
                              boxShadow: [
                                BoxShadow(
                                    color: CupertinoColors.systemGrey.withValues(alpha: 0.2),
                                    blurRadius: 14,
                                    offset: const Offset(0, 4)),
                              ],
                            ),
                            child: glAccountsAsync.when(
                              data: (accounts) {
                                if (accounts.isEmpty) {
                                  return const Padding(
                                      padding: EdgeInsets.all(AppTheme.spacingS),
                                      child: Text('No results', style: AppTheme.caption));
                                }
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: accounts.length,
                                  separatorBuilder: (_, _) =>
                                      Divider(height: 1, color: divCol),
                                  itemBuilder: (ctx, i) {
                                    final gl = accounts[i];
                                    return _TIHoverableRow(
                                      onTap: () {
                                        ref.read(markGlAsUsedProvider(gl));
                                        setState(() {
                                          _selectedGL = gl;
                                          _glSearchCtrl.text =
                                              '${gl.glCode} — ${gl.glDescription}';
                                          _showGLDropdown = false;
                                          _glQuery = '';
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 7),
                                        child: Row(children: [
                                          Text(gl.glCode,
                                              style: const TextStyle(
                                                  fontFamily: 'SF Pro Display',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppTheme.primaryBlue)),
                                          const SizedBox(width: 8),
                                          Expanded(
                                              child: Text(gl.glDescription,
                                                  style: TextStyle(
                                                      fontFamily: 'SF Pro Display',
                                                      fontSize: 12,
                                                      color: textCol))),
                                        ]),
                                      ),
                                    );
                                  },
                                );
                              },
                              loading: () => const Padding(
                                  padding: EdgeInsets.all(AppTheme.spacingS),
                                  child: CupertinoActivityIndicator()),
                              error: (_, _) => const Padding(
                                  padding: EdgeInsets.all(AppTheme.spacingS),
                                  child: Text('Error', style: AppTheme.caption)),
                            ),
                          ),
                        ),
                      ),
                  ],
                )),
            const SizedBox(width: 6),
            // Transaction (flex 3)
            Expanded(
                flex: 3,
                child: _inlineField(
                    _txnCtrl, 'Transaction', 'e.g. Stationery')),
            const SizedBox(width: 6),
            // Amount (100px)
            SizedBox(
                width: 100,
                child: _inlineField(_amtCtrl, 'Amount ₹', '2500',
                    isNumeric: true)),
            const SizedBox(width: 8),
            // Add button
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _submit,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue,
                  borderRadius:
                      BorderRadius.circular(AppTheme.radiusMedium),
                ),
                child: const Row(children: [
                  Icon(CupertinoIcons.add,
                      size: 14, color: Colors.white),
                  SizedBox(width: 4),
                  Text('Add',
                      style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ]),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _inlineField(
    TextEditingController ctrl,
    String label,
    String placeholder, {
    bool isNumeric = false,
  }) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isDark ? AppTheme.darkDivider : AppTheme.dividerColor)),
      child: CupertinoTextField(
        controller: ctrl,
        placeholder: placeholder,
        decoration: const BoxDecoration(),
        style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 12,
            color: isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary),
        placeholderStyle: AppTheme.caption,
        keyboardType: isNumeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,
        onSubmitted: (_) => _submit(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// SHARED: Hoverable row (for dropdowns in this file)
// ─────────────────────────────────────────────────────────────

class _TIHoverableRow extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _TIHoverableRow({required this.child, required this.onTap});

  @override
  State<_TIHoverableRow> createState() => _TIHoverableRowState();
}

class _TIHoverableRowState extends State<_TIHoverableRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 80),
          color: _hovered
              ? AppTheme.primaryBlue.withValues(alpha: 0.06)
              : Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
