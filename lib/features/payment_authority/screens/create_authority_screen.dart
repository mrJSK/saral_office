// lib/features/payment_authority/screens/create_authority_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/vendor.dart';
import '../../../core/database/models/division.dart';
import '../../../core/database/models/gl_account.dart';
import '../providers/payment_authority_provider.dart';
import '../widgets/division_search_field.dart';
import '../widgets/vendor_search_field.dart';
import '../widgets/account_entry_card.dart';
import '../widgets/totals_summary_card.dart';
import '../widgets/ios_text_field.dart';

class CreateAuthorityScreen extends ConsumerStatefulWidget {
  const CreateAuthorityScreen({super.key});

  @override
  ConsumerState<CreateAuthorityScreen> createState() =>
      _CreateAuthorityScreenState();
}

class _CreateAuthorityScreenState extends ConsumerState<CreateAuthorityScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final _scrollController = ScrollController();
  final _authorityOrderController = TextEditingController();
  final _billNumberController = TextEditingController();
  final _particularsController = TextEditingController();

  // These date variables were being initialized to the current date
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedBillDate = DateTime.now();

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

    // ✅ FIX: Initialize controllers with data from the provider
    // This runs after the widget is built to safely read the provider state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authority = ref.read(paymentAuthorityProvider);

      // Populate Text Fields from the loaded authority data
      _authorityOrderController.text = authority.authorityOrderNo;
      _billNumberController.text = authority.billNumber;
      _particularsController.text = authority.particulars;

      // Populate Dates from the loaded authority data
      setState(() {
        _selectedDate = authority.date;
        _selectedBillDate = authority.billDate;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    _authorityOrderController.dispose();
    _billNumberController.dispose();
    _particularsController.dispose();
    super.dispose();
  }

  /// Syncs text field values to the Riverpod state before actions like PDF generation
  void _syncTextControllersToState() {
    final notifier = ref.read(paymentAuthorityProvider.notifier);

    notifier.updateAuthorityOrderNo(_authorityOrderController.text);
    notifier.updateBillNumber(_billNumberController.text);
    notifier.updateParticulars(_particularsController.text);
  }

  @override
  Widget build(BuildContext context) {
    final authority = ref.watch(paymentAuthorityProvider);

    return Stack(
      children: [
        CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundLight,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
            border: null,
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: _isGeneratingPdf ? null : () => _handleBack(),
              child: const Icon(CupertinoIcons.back),
            ),
            middle: const Text(
              'New Payment Authority',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: (authority.isBalanced && !_isGeneratingPdf)
                  ? () => _generatePDF()
                  : null,
              child: Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: (authority.isBalanced && !_isGeneratingPdf)
                    ? AppTheme.successGreen
                    : AppTheme.textSecondary.withOpacity(0.3),
              ),
            ),
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section: Basic Details
                          _buildSectionHeader(
                            'Basic Details',
                            CupertinoIcons.info_circle_fill,
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          _buildBasicDetailsCard(),

                          const SizedBox(height: AppTheme.spacingXL),

                          // Section: Vendor Information
                          _buildSectionHeader(
                            'Vendor Information',
                            CupertinoIcons.person_2_fill,
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          _buildVendorCard(),

                          const SizedBox(height: AppTheme.spacingXL),

                          // Section: Accounting Entries
                          _buildSectionHeader(
                            'Accounting Entries',
                            CupertinoIcons.list_bullet,
                          ),
                          const SizedBox(height: AppTheme.spacingM),
                          _buildAccountingEntriesSection(authority),

                          const SizedBox(height: AppTheme.spacingM),

                          // Add Entry Button
                          _buildAddEntryButton(),

                          const SizedBox(height: AppTheme.spacingXL),

                          // Totals Summary
                          TotalsSummaryCard(
                            totalDebit: authority.totalDebit,
                            totalCredit: authority.totalCredit,
                            isBalanced: authority.isBalanced,
                          ),

                          const SizedBox(height: AppTheme.spacingXL),

                          // Generate PDF Button
                          _buildGeneratePDFButton(authority),

                          const SizedBox(height: AppTheme.spacingXL),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Loading Overlay
        if (_isGeneratingPdf)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceWhite.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CupertinoActivityIndicator(radius: 14),
                    SizedBox(height: 12),
                    Text(
                      'Generating PDF...',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textPrimary,
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
        const SizedBox(width: AppTheme.spacingS),
        Text(title, style: AppTheme.headline3.copyWith(fontSize: 20)),
      ],
    );
  }

  Widget _buildBasicDetailsCard() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        children: [
          // Division
          DivisionSearchField(
            selectedDivision: ref.watch(paymentAuthorityProvider).division,
            onChanged: (division) {
              if (division != null) {
                ref
                    .read(paymentAuthorityProvider.notifier)
                    .updateDivision(division);

                // Mark as recent
                ref.read(markDivisionAsUsedProvider(division));
              }
            },
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Date Row
          Row(
            children: [
              Expanded(
                child: _buildDateField(
                  label: 'Date',
                  date: _selectedDate,
                  onChanged: (date) {
                    setState(() => _selectedDate = date);
                    ref
                        .read(paymentAuthorityProvider.notifier)
                        .updateDate(date);
                  },
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: IOSTextField(
                  controller: _authorityOrderController,
                  label: 'Authority Order No.',
                  placeholder: 'P_O_No.',
                  keyboardType: TextInputType.text,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingM),

          // Bill Details Row
          Row(
            children: [
              Expanded(
                child: IOSTextField(
                  controller: _billNumberController,
                  label: 'Bill/Invoice No.',
                  placeholder: 'Enter bill number',
                  keyboardType: TextInputType.text,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildDateField(
                  label: 'Bill Date',
                  date: _selectedBillDate,
                  onChanged: (date) {
                    setState(() => _selectedBillDate = date);
                    ref
                        .read(paymentAuthorityProvider.notifier)
                        .updateBillDate(date);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime date,
    required Function(DateTime) onChanged,
  }) {
    final dateFormat = DateFormat('dd MMM yyyy');

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
        GestureDetector(
          onTap: () => _showDatePicker(date, onChanged),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.dividerColor, width: 1),
            ),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.calendar,
                  size: 18,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    dateFormat.format(date),
                    style: AppTheme.body1.copyWith(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showDatePicker(DateTime initialDate, Function(DateTime) onChanged) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: AppTheme.surfaceWhite,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                initialDateTime: initialDate,
                maximumDate: DateTime.now().add(const Duration(days: 365)),
                onDateTimeChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVendorCard() {
    final vendor = ref.watch(paymentAuthorityProvider).vendor;

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Column(
        children: [
          VendorSearchField(
            selectedVendor: vendor,
            onChanged: (selectedVendor) {
              if (selectedVendor != null) {
                ref
                    .read(paymentAuthorityProvider.notifier)
                    .updateVendor(selectedVendor);

                // Mark as recent
                ref.read(markVendorAsUsedProvider(selectedVendor));
              }
            },
          ),
          if (vendor != null) ...[
            const SizedBox(height: AppTheme.spacingM),
            _buildVendorDetails(vendor),
          ],
          const SizedBox(height: AppTheme.spacingM),
          IOSTextField(
            controller: _particularsController,
            label: 'Particulars of Payment',
            placeholder: 'Enter payment details',
            maxLines: 3,
            keyboardType: TextInputType.multiline,
          ),
        ],
      ),
    );
  }

  Widget _buildVendorDetails(Vendor vendor) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Vendor Code', vendor.vendorCode),
          const SizedBox(height: 8),
          _buildDetailRow('Address', vendor.fullAddress),
          if (vendor.pan != null) ...[
            const SizedBox(height: 8),
            _buildDetailRow('PAN', vendor.pan!),
          ],
          if (vendor.gst != null) ...[
            const SizedBox(height: 8),
            _buildDetailRow('GST', vendor.gst!),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: AppTheme.caption.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTheme.body2.copyWith(color: AppTheme.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountingEntriesSection(PaymentAuthority authority) {
    if (authority.entries.isEmpty) {
      return _buildEmptyEntriesState();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: authority.entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spacingM),
      itemBuilder: (context, index) {
        return AccountEntryCard(
          entry: authority.entries[index],
          index: index,
          onDelete: () {
            ref.read(paymentAuthorityProvider.notifier).removeEntry(index);
          },
        );
      },
    );
  }

  Widget _buildEmptyEntriesState() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: AppTheme.dividerColor,
          width: 1,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.list_bullet,
              color: AppTheme.primaryBlue,
              size: 32,
            ),
          ),
          const SizedBox(height: AppTheme.spacingM),
          const Text(
            'No Entries Added',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Add debit and credit entries to create the payment authority',
            style: AppTheme.body2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAddEntryButton() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: _showAddEntrySheet,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.primaryBlue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            width: 1.5,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.add_circled_solid,
              color: AppTheme.primaryBlue,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              'Add Entry',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryBlue,
                letterSpacing: -0.32,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneratePDFButton(PaymentAuthority authority) {
    final isEnabled =
        authority.isBalanced &&
        authority.entries.isNotEmpty &&
        authority.vendor != null &&
        authority.division != null &&
        !_isGeneratingPdf;

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: isEnabled ? _generatePDF : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isEnabled
              ? const LinearGradient(
                  colors: [AppTheme.primaryBlue, AppTheme.secondaryBlue],
                )
              : null,
          color: isEnabled ? null : AppTheme.dividerColor,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.doc_text_fill,
              color: isEnabled ? AppTheme.surfaceWhite : AppTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Text(
              'Generate PDF',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: isEnabled
                    ? AppTheme.surfaceWhite
                    : AppTheme.textSecondary,
                letterSpacing: -0.41,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEntrySheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => const AddEntrySheet(),
    );
  }

  Future<void> _generatePDF() async {
    setState(() => _isGeneratingPdf = true);
    try {
      // 1. Sync latest text values from controllers to the state provider
      _syncTextControllersToState();

      // 2. Trigger PDF generation (which also saves the full state to the database)
      final generatePdfAction = ref.read(generatePaymentAuthorityPdfProvider);
      await generatePdfAction();
    } catch (e) {
      _showErrorDialog(e.toString()); // Helper to show an error popup
    } finally {
      if (mounted) {
        setState(() => _isGeneratingPdf = false);
      }
    }
  }

  void _showErrorDialog(String message) {
    // Ensure the context is still valid before showing a dialog
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _handleBack() {
    if (ref.read(paymentAuthorityProvider).entries.isNotEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Discard Changes?'),
          content: const Text('Your unsaved changes will be lost.'),
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
                ref.read(paymentAuthorityProvider.notifier).reset();
              },
            ),
          ],
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }
}

// --------------------------
// Add Entry Sheet
// --------------------------

class AddEntrySheet extends ConsumerStatefulWidget {
  const AddEntrySheet({super.key});

  @override
  ConsumerState<AddEntrySheet> createState() => _AddEntrySheetState();
}

class _AddEntrySheetState extends ConsumerState<AddEntrySheet> {
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  GLAccount? _selectedGL;
  bool _isDebit = true;

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusXLarge),
        ),
      ),
      child: Column(
        children: [
          // Handle Bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 36,
            height: 5,
            decoration: BoxDecoration(
              color: AppTheme.dividerColor,
              borderRadius: BorderRadius.circular(2.5),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'Add Entry',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _addEntry,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: AppTheme.dividerColor),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Entry Type Segmented Control
                  Text(
                    'Entry Type',
                    style: AppTheme.caption.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  CupertinoSegmentedControl<bool>(
                    padding: const EdgeInsets.all(2),
                    groupValue: _isDebit,
                    children: const {
                      true: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Debit'),
                      ),
                      false: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Credit'),
                      ),
                    },
                    onValueChanged: (value) {
                      setState(() => _isDebit = value);
                    },
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  // Description
                  IOSTextField(
                    controller: _descriptionController,
                    label: 'Description',
                    placeholder: 'Enter entry description',
                    maxLines: 2,
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  // GL Account Selection
                  Text(
                    'GL Account',
                    style: AppTheme.caption.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _showGLPicker,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceWhite,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppTheme.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _selectedGL != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _selectedGL!.glCode,
                                        style: const TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppTheme.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _selectedGL!.glDescription,
                                        style: AppTheme.caption,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  )
                                : Text(
                                    'Select GL Account',
                                    style: AppTheme.body2,
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

                  const SizedBox(height: AppTheme.spacingL),

                  // Amount
                  IOSTextField(
                    controller: _amountController,
                    label: 'Amount',
                    placeholder: '0.00',
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    prefix: const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: Text(
                        '₹',
                        style: TextStyle(
                          fontSize: 17,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showGLPicker() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => GLAccountPickerScreen(
          onSelected: (gl) {
            setState(() => _selectedGL = gl);
          },
        ),
      ),
    );
  }

  void _addEntry() {
    if (_descriptionController.text.isEmpty ||
        _selectedGL == null ||
        _amountController.text.isEmpty) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Incomplete Entry'),
          content: const Text('Please fill all fields'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      return;
    }

    final entry = AccountEntry(
      description: _descriptionController.text,
      glAccount: _selectedGL,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      isDebit: _isDebit,
    );

    ref.read(paymentAuthorityProvider.notifier).addEntry(entry);
    Navigator.pop(context);
  }
}

// --------------------------
// GL Account Picker Screen
// --------------------------

class GLAccountPickerScreen extends ConsumerStatefulWidget {
  final Function(GLAccount) onSelected;

  const GLAccountPickerScreen({super.key, required this.onSelected});

  @override
  ConsumerState<GLAccountPickerScreen> createState() =>
      _GLAccountPickerScreenState();
}

class _GLAccountPickerScreenState extends ConsumerState<GLAccountPickerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glAccountsAsync = ref.watch(glAccountSearchProvider(_searchQuery));

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
        middle: const Text('Select GL Account'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search GL code or description',
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),

            // Results
            Expanded(
              child: glAccountsAsync.when(
                data: (accounts) {
                  if (accounts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.search,
                            size: 64,
                            color: AppTheme.textSecondary.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No GL accounts found',
                            style: AppTheme.body2,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: accounts.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: AppTheme.dividerColor,
                      indent: AppTheme.spacingM,
                    ),
                    itemBuilder: (context, index) {
                      final gl = accounts[index];
                      return CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingM,
                          vertical: 12,
                        ),
                        onPressed: () {
                          // Mark as recent
                          ref.read(markGlAsUsedProvider(gl));

                          widget.onSelected(gl);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                CupertinoIcons.number,
                                size: 18,
                                color: AppTheme.primaryBlue,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    gl.glCode,
                                    style: const TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    gl.glDescription,
                                    style: AppTheme.caption,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              CupertinoIcons.chevron_right,
                              size: 18,
                              color: AppTheme.textSecondary,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (error, stack) => Center(
                  child: Text(
                    'Error loading GL accounts',
                    style: AppTheme.body2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
