// lib/features/payment_authority/screens/create_authority_screen.dart

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/vendor.dart';
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

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedBillDate = DateTime.now();

  bool _isGeneratingPdf = false;

  bool get _isDesktop =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authority = ref.read(paymentAuthorityProvider);
      _authorityOrderController.text = authority.authorityOrderNo;
      _billNumberController.text = authority.billNumber;
      _particularsController.text = authority.particulars;
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

  void _syncTextControllersToState() {
    final notifier = ref.read(paymentAuthorityProvider.notifier);
    notifier.updateAuthorityOrderNo(_authorityOrderController.text);
    notifier.updateBillNumber(_billNumberController.text);
    notifier.updateParticulars(_particularsController.text);
  }

  @override
  Widget build(BuildContext context) {
    return _isDesktop ? _buildDesktopLayout() : _buildMobileLayout();
  }

  // ─────────────────────────────────────────────────────────────
  // DESKTOP LAYOUT
  // ─────────────────────────────────────────────────────────────

  Widget _buildDesktopLayout() {
    final authority = ref.watch(paymentAuthorityProvider);

    return Stack(
      children: [
        CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundLight,
          child: Column(
            children: [
              _buildDesktopTopBar(authority),
              Expanded(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Left panel: form fields
                      SizedBox(
                        width: 420,
                        child: _buildDesktopLeftPanel(),
                      ),
                      Container(width: 1, color: AppTheme.dividerColor),
                      // Right panel: entries + inline add entry
                      Expanded(
                        child: _buildDesktopRightPanel(authority),
                      ),
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

  Widget _buildDesktopTopBar(PaymentAuthority authority) {
    final isEnabled = authority.isBalanced &&
        authority.entries.isNotEmpty &&
        authority.vendor != null &&
        authority.division != null &&
        !_isGeneratingPdf;

    return Container(
      height: 52,
      color: AppTheme.surfaceWhite,
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
                      color: AppTheme.primaryBlue,
                    )),
              ],
            ),
          ),
          const Expanded(
            child: Text(
              'New Payment Authority',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: isEnabled ? _generatePDF : null,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isEnabled
                    ? AppTheme.primaryBlue
                    : AppTheme.dividerColor,
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.doc_text_fill,
                    size: 15,
                    color: isEnabled
                        ? AppTheme.surfaceWhite
                        : AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Generate PDF',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isEnabled
                          ? AppTheme.surfaceWhite
                          : AppTheme.textSecondary,
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

  Widget _buildDesktopLeftPanel() {
    return Container(
      color: AppTheme.backgroundLight,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Basic Details', CupertinoIcons.info_circle_fill),
            const SizedBox(height: AppTheme.spacingM),
            _buildBasicDetailsCard(),

            const SizedBox(height: AppTheme.spacingL),

            _buildSectionHeader(
                'Vendor Information', CupertinoIcons.person_2_fill),
            const SizedBox(height: AppTheme.spacingM),
            _buildVendorCard(),

            const SizedBox(height: AppTheme.spacingL),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopRightPanel(PaymentAuthority authority) {
    return Container(
      color: AppTheme.backgroundLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ledger table (takes all available space)
          Expanded(
            child: _DesktopLedgerTable(
              authority: authority,
              onDelete: (index) =>
                  ref.read(paymentAuthorityProvider.notifier).removeEntry(index),
              onUndo: (entry, index) =>
                  ref.read(paymentAuthorityProvider.notifier).insertEntryAt(index, entry),
            ),
          ),

          // Inline Add Entry form
          Container(
            decoration: const BoxDecoration(
              color: AppTheme.surfaceWhite,
              border: Border(
                  top: BorderSide(color: AppTheme.dividerColor, width: 1)),
            ),
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: _InlineAddEntryForm(
              onAdd: (entry) =>
                  ref.read(paymentAuthorityProvider.notifier).addEntry(entry),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────
  // MOBILE LAYOUT (unchanged)
  // ─────────────────────────────────────────────────────────────

  Widget _buildMobileLayout() {
    final authority = ref.watch(paymentAuthorityProvider);

    return Stack(
      children: [
        CupertinoPageScaffold(
          backgroundColor: AppTheme.backgroundLight,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: AppTheme.surfaceWhite.withValues(alpha: 0.9),
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
                    : AppTheme.textSecondary.withValues(alpha: 0.3),
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
                          _buildSectionHeader(
                              'Basic Details', CupertinoIcons.info_circle_fill),
                          const SizedBox(height: AppTheme.spacingM),
                          _buildBasicDetailsCard(),
                          const SizedBox(height: AppTheme.spacingXL),
                          _buildSectionHeader('Vendor Information',
                              CupertinoIcons.person_2_fill),
                          const SizedBox(height: AppTheme.spacingM),
                          _buildVendorCard(),
                          const SizedBox(height: AppTheme.spacingXL),
                          _buildSectionHeader('Accounting Entries',
                              CupertinoIcons.list_bullet),
                          const SizedBox(height: AppTheme.spacingM),
                          _buildAccountingEntriesSection(authority),
                          const SizedBox(height: AppTheme.spacingM),
                          _buildAddEntryButton(),
                          const SizedBox(height: AppTheme.spacingXL),
                          TotalsSummaryCard(
                            totalDebit: authority.totalDebit,
                            totalCredit: authority.totalCredit,
                            isBalanced: authority.isBalanced,
                          ),
                          const SizedBox(height: AppTheme.spacingXL),
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
        if (_isGeneratingPdf) _buildLoadingOverlay(),
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
            color: AppTheme.surfaceWhite.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
        const SizedBox(width: AppTheme.spacingS),
        Text(title, style: AppTheme.headline3.copyWith(fontSize: 17)),
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
          DivisionSearchField(
            selectedDivision: ref.watch(paymentAuthorityProvider).division,
            onChanged: (division) {
              if (division != null) {
                ref
                    .read(paymentAuthorityProvider.notifier)
                    .updateDivision(division);
                ref.read(markDivisionAsUsedProvider(division));
              }
            },
          ),
          const SizedBox(height: AppTheme.spacingM),
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
                const Icon(CupertinoIcons.calendar,
                    size: 18, color: AppTheme.primaryBlue),
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
    if (_isDesktop) {
      // On desktop, show a dialog with a date picker
      showCupertinoDialog(
        context: context,
        builder: (context) {
          DateTime tempDate = initialDate;
          return CupertinoAlertDialog(
            content: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: initialDate,
                maximumDate: DateTime.now().add(const Duration(days: 365)),
                onDateTimeChanged: (d) => tempDate = d,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text('Done'),
                onPressed: () {
                  onChanged(tempDate);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => Container(
          height: 300,
          color: AppTheme.surfaceWhite,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  maximumDate:
                      DateTime.now().add(const Duration(days: 365)),
                  onDateTimeChanged: onChanged,
                ),
              ),
            ],
          ),
        ),
      );
    }
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
    bool hasText(String? s) => s != null && s.trim().isNotEmpty;

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

          if (hasText(vendor.pan)) ...[
            const SizedBox(height: 8),
            _buildDetailRow('PAN', vendor.pan!.trim()),
          ],

          if (hasText(vendor.gst)) ...[
            const SizedBox(height: 8),
            _buildDetailRow('GST', vendor.gst!.trim()),
          ],

          // ✅ NEW: Bank details + Email
          if (hasText(vendor.bankAccount)) ...[
            const SizedBox(height: 8),
            _buildDetailRow('Bank A/C', vendor.bankAccount!.trim()),
          ],

          if (hasText(vendor.ifsc)) ...[
            const SizedBox(height: 8),
            _buildDetailRow('IFSC', vendor.ifsc!.trim()),
          ],

          if (hasText(vendor.email)) ...[
            const SizedBox(height: 8),
            _buildDetailRow('Email', vendor.email!.trim()),
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
          child: Text(label,
              style: AppTheme.caption.copyWith(fontWeight: FontWeight.w500)),
        ),
        Expanded(
          child: Text(value,
              style: AppTheme.body2.copyWith(color: AppTheme.textPrimary)),
        ),
      ],
    );
  }

  // Mobile-only widgets below

  Widget _buildAccountingEntriesSection(PaymentAuthority authority) {
    if (authority.entries.isEmpty) return _buildEmptyEntriesState();
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: authority.entries.length,
      separatorBuilder: (_, _) =>
          const SizedBox(height: AppTheme.spacingM),
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
        border: Border.all(color: AppTheme.dividerColor, width: 1),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(CupertinoIcons.list_bullet,
                color: AppTheme.primaryBlue, size: 32),
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
          color: AppTheme.primaryBlue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: AppTheme.primaryBlue.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.add_circled_solid,
                color: AppTheme.primaryBlue, size: 20),
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
    final isEnabled = authority.isBalanced &&
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
                    color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.doc_text_fill,
                color: isEnabled
                    ? AppTheme.surfaceWhite
                    : AppTheme.textSecondary,
                size: 20),
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
      builder: (context) => const AddEntryScreen(),
    );
  }

  Future<void> _generatePDF() async {
    setState(() => _isGeneratingPdf = true);
    try {
      _syncTextControllersToState();
      final generatePdfAction = ref.read(generatePaymentAuthorityPdfProvider);
      await generatePdfAction();
    } catch (e) {
      _showErrorDialog(e.toString());
    } finally {
      if (mounted) setState(() => _isGeneratingPdf = false);
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

// ─────────────────────────────────────────────────────────────
// ─────────────────────────────────────────────────────────────
// DESKTOP: Ledger Table (Excel-style Debit | Credit columns)
// ─────────────────────────────────────────────────────────────

class _DesktopLedgerTable extends StatefulWidget {
  final PaymentAuthority authority;
  final void Function(int index) onDelete;
  final void Function(AccountEntry entry, int index) onUndo;

  const _DesktopLedgerTable({
    required this.authority,
    required this.onDelete,
    required this.onUndo,
  });

  @override
  State<_DesktopLedgerTable> createState() => _DesktopLedgerTableState();
}

class _DesktopLedgerTableState extends State<_DesktopLedgerTable> {
  AccountEntry? _deletedEntry;
  int? _deletedIndex;
  Timer? _undoTimer;
  int _undoSecondsLeft = 0;

  @override
  void dispose() {
    _undoTimer?.cancel();
    super.dispose();
  }

  void _handleDelete(int index) {
    final entry = widget.authority.entries[index];
    _undoTimer?.cancel();
    setState(() {
      _deletedEntry = entry;
      _deletedIndex = index;
      _undoSecondsLeft = 10;
    });
    widget.onDelete(index);
    _undoTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() => _undoSecondsLeft--);
      if (_undoSecondsLeft <= 0) {
        t.cancel();
        setState(() { _deletedEntry = null; _deletedIndex = null; });
      }
    });
  }

  void _handleUndo() {
    if (_deletedEntry == null || _deletedIndex == null) return;
    _undoTimer?.cancel();
    widget.onUndo(_deletedEntry!, _deletedIndex!);
    setState(() { _deletedEntry = null; _deletedIndex = null; _undoSecondsLeft = 0; });
  }

  @override
  Widget build(BuildContext context) {
    final debits = widget.authority.entries
        .asMap()
        .entries
        .where((e) => e.value.isDebit)
        .toList();
    final credits = widget.authority.entries
        .asMap()
        .entries
        .where((e) => !e.value.isDebit)
        .toList();

    final rowCount = debits.length > credits.length
        ? debits.length
        : credits.length;

    return Container(
      color: AppTheme.backgroundLight,
      child: Column(
        children: [
          // Column headers
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppTheme.dividerColor),
              ),
            ),
            child: Row(
              children: [
                // Debit header
                Expanded(
                  child: Container(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.arrow_up_circle_fill,
                            size: 14, color: AppTheme.primaryBlue),
                        SizedBox(width: 6),
                        Text(
                          'DEBIT',
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
                  ),
                ),
                Container(width: 1, color: AppTheme.dividerColor),
                // Credit header
                Expanded(
                  child: Container(
                    color: AppTheme.successGreen.withValues(alpha: 0.08),
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM, vertical: 10),
                    child: const Row(
                      children: [
                        Icon(CupertinoIcons.arrow_down_circle_fill,
                            size: 14, color: AppTheme.successGreen),
                        SizedBox(width: 6),
                        Text(
                          'CREDIT',
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
                  ),
                ),
              ],
            ),
          ),

          // Sub-header: column labels
          Container(
            color: AppTheme.dividerColor.withValues(alpha: 0.4),
            child: Row(
              children: [
                _buildSubHeader('Description', flex: 3),
                _buildSubHeader('GL Code', flex: 2),
                _buildSubHeader('Amount', flex: 2, alignRight: true),
                const SizedBox(width: 32), // delete btn space
                Container(width: 1, color: AppTheme.dividerColor),
                _buildSubHeader('Description', flex: 3),
                _buildSubHeader('GL Code', flex: 2),
                _buildSubHeader('Amount', flex: 2, alignRight: true),
                const SizedBox(width: 32),
              ],
            ),
          ),

          // Data rows
          Expanded(
            child: rowCount == 0
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(CupertinoIcons.table,
                              color: AppTheme.primaryBlue, size: 28),
                        ),
                        const SizedBox(height: AppTheme.spacingM),
                        const Text('No entries yet',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            )),
                        const SizedBox(height: 4),
                        Text('Add debit & credit entries below',
                            style: AppTheme.caption),
                      ],
                    ),
                  )
                : ListView.separated(
                    itemCount: rowCount,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: AppTheme.dividerColor),
                    itemBuilder: (context, i) {
                      final debitEntry =
                          i < debits.length ? debits[i] : null;
                      final creditEntry =
                          i < credits.length ? credits[i] : null;
                      return _LedgerRow(
                        debitEntry: debitEntry?.value,
                        creditEntry: creditEntry?.value,
                        onDeleteDebit: debitEntry != null
                            ? () => _handleDelete(debitEntry.key)
                            : null,
                        onDeleteCredit: creditEntry != null
                            ? () => _handleDelete(creditEntry.key)
                            : null,
                        isEven: i.isEven,
                      );
                    },
                  ),
          ),

          // Undo banner (shown for 10s after a row is deleted)
          if (_deletedEntry != null)
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                border: const Border(
                    top: BorderSide(color: AppTheme.dividerColor)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.delete,
                      size: 15, color: Colors.white70),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Entry deleted — "${_deletedEntry!.description}"',
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${_undoSecondsLeft}s',
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 12,
                        color: Colors.white38),
                  ),
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
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('Undo',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),

          // Totals row
          Container(
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppTheme.dividerColor)),
              color: AppTheme.surfaceWhite,
            ),
            child: Row(
              children: [
                // Debit total
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Debit',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryBlue,
                            )),
                        Text(
                          '₹${_fmt(widget.authority.totalDebit)}',
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(width: 1, color: AppTheme.dividerColor),
                // Credit total + balance badge
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingM, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Credit',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.successGreen,
                            )),
                        Row(
                          children: [
                            Text(
                              '₹${_fmt(widget.authority.totalCredit)}',
                              style: const TextStyle(
                                fontFamily: 'SF Pro Display',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppTheme.successGreen,
                              ),
                            ),
                            const SizedBox(width: AppTheme.spacingS),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: widget.authority.isBalanced
                                    ? AppTheme.successGreen.withValues(alpha: 0.12)
                                    : AppTheme.errorRed.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.authority.isBalanced ? 'Balanced' : 'Unbalanced',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: widget.authority.isBalanced
                                      ? AppTheme.successGreen
                                      : AppTheme.errorRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubHeader(String label,
      {required int flex, bool alignRight = false}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: Text(
          label,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppTheme.textSecondary,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }

  String _fmt(double amount) {
    final parts = amount.toStringAsFixed(2).split('.');
    final intPart = parts[0];
    final dec = parts[1];
    // Indian number formatting
    final buf = StringBuffer();
    for (int i = 0; i < intPart.length; i++) {
      final fromEnd = intPart.length - 1 - i;
      buf.write(intPart[i]);
      if (fromEnd > 0) {
        if (fromEnd == 3 ||
            (fromEnd > 3 && (fromEnd - 3) % 2 == 0)) {
          buf.write(',');
        }
      }
    }
    return '$buf.$dec';
  }
}

// A single row in the ledger table
class _LedgerRow extends StatefulWidget {
  final AccountEntry? debitEntry;
  final AccountEntry? creditEntry;
  final VoidCallback? onDeleteDebit;
  final VoidCallback? onDeleteCredit;
  final bool isEven;

  const _LedgerRow({
    this.debitEntry,
    this.creditEntry,
    this.onDeleteDebit,
    this.onDeleteCredit,
    required this.isEven,
  });

  @override
  State<_LedgerRow> createState() => _LedgerRowState();
}

class _LedgerRowState extends State<_LedgerRow> {
  bool _debitHovered = false;
  bool _creditHovered = false;

  @override
  Widget build(BuildContext context) {
    final rowBg = widget.isEven
        ? AppTheme.surfaceWhite
        : AppTheme.backgroundLight;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Debit cell
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _debitHovered = true),
              onExit: (_) => setState(() => _debitHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                color: _debitHovered && widget.debitEntry != null
                    ? AppTheme.primaryBlue.withValues(alpha: 0.04)
                    : rowBg,
                child: _buildCell(
                  entry: widget.debitEntry,
                  onDelete: widget.onDeleteDebit,
                  accentColor: AppTheme.primaryBlue,
                ),
              ),
            ),
          ),
          Container(width: 1, color: AppTheme.dividerColor),
          // Credit cell
          Expanded(
            child: MouseRegion(
              onEnter: (_) => setState(() => _creditHovered = true),
              onExit: (_) => setState(() => _creditHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                color: _creditHovered && widget.creditEntry != null
                    ? AppTheme.successGreen.withValues(alpha: 0.04)
                    : rowBg,
                child: _buildCell(
                  entry: widget.creditEntry,
                  onDelete: widget.onDeleteCredit,
                  accentColor: AppTheme.successGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell({
    required AccountEntry? entry,
    required VoidCallback? onDelete,
    required Color accentColor,
  }) {
    if (entry == null) {
      return const SizedBox(height: 40);
    }

    final glDesc = entry.glAccount?.glDescription ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        children: [
          // Description
          Expanded(
            flex: 3,
            child: Text(
              entry.description,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 13,
                color: AppTheme.textPrimary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // GL Code + description tooltip
          Expanded(
            flex: 2,
            child: Tooltip(
              message: glDesc,
              child: Text(
                entry.glAccount!.glCode,
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Amount
          Expanded(
            flex: 2,
            child: Text(
              '₹${entry.amount.toStringAsFixed(2)}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          // Delete button
          SizedBox(
            width: 32,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              onPressed: onDelete,
              child: const Icon(CupertinoIcons.xmark,
                  size: 13, color: AppTheme.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// DESKTOP: Inline Add Entry Form (no modal, always visible)
// ─────────────────────────────────────────────────────────────

// Split two-column form: Debit on left, Credit on right — mirrors the ledger above
class _InlineAddEntryForm extends StatelessWidget {
  final void Function(AccountEntry entry) onAdd;

  const _InlineAddEntryForm({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: _SideEntryInput(
            isDebit: true,
            accentColor: AppTheme.primaryBlue,
            onAdd: onAdd,
          ),
        ),
        Container(width: 1, color: AppTheme.dividerColor),
        Expanded(
          child: _SideEntryInput(
            isDebit: false,
            accentColor: AppTheme.successGreen,
            onAdd: onAdd,
          ),
        ),
      ],
    );
  }
}

// One side (Debit or Credit) of the split add-entry form
class _SideEntryInput extends ConsumerStatefulWidget {
  final bool isDebit;
  final Color accentColor;
  final void Function(AccountEntry entry) onAdd;

  const _SideEntryInput({
    required this.isDebit,
    required this.accentColor,
    required this.onAdd,
  });

  @override
  ConsumerState<_SideEntryInput> createState() => _SideEntryInputState();
}

class _SideEntryInputState extends ConsumerState<_SideEntryInput> {
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _glSearchController = TextEditingController();
  GLAccount? _selectedGL;
  bool _showGLDropdown = false;
  String _glQuery = '';

  @override
  void dispose() {
    _descController.dispose();
    _amountController.dispose();
    _glSearchController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_descController.text.isEmpty ||
        _selectedGL == null ||
        _amountController.text.isEmpty) {
      return;
    }

    widget.onAdd(AccountEntry(
      description: _descController.text,
      glAccount: _selectedGL,
      amount: double.tryParse(_amountController.text) ?? 0.0,
      isDebit: widget.isDebit,
    ));

    _descController.clear();
    _amountController.clear();
    _glSearchController.clear();
    setState(() {
      _selectedGL = null;
      _showGLDropdown = false;
      _glQuery = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final glAccountsAsync = ref.watch(glAccountSearchProvider(_glQuery));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Input row
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingS, vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Expanded(
                flex: 3,
                child: _buildField(
                  controller: _descController,
                  placeholder: 'Description',
                  onSubmitted: (_) => _submit(),
                ),
              ),
              const SizedBox(width: 6),

              // GL search field
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildField(
                      controller: _glSearchController,
                      placeholder: _selectedGL != null
                          ? '${_selectedGL!.glCode} — ${_selectedGL!.glDescription}'
                          : 'Search GL Account',
                      focusColor: widget.accentColor,
                      onTap: () => setState(() => _showGLDropdown = true),
                      onChanged: (val) => setState(() {
                        _glQuery = val;
                        _showGLDropdown = true;
                        if (val.isEmpty) _selectedGL = null;
                      }),
                    ),
                    if (_showGLDropdown)
                      Container(
                        constraints: const BoxConstraints(maxHeight: 160),
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceWhite,
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusMedium),
                          border: Border.all(color: AppTheme.dividerColor),
                          boxShadow: [
                            BoxShadow(
                              color: CupertinoColors.systemGrey
                                  .withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, -4),
                            ),
                          ],
                        ),
                        child: glAccountsAsync.when(
                          data: (accounts) {
                            if (accounts.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(AppTheme.spacingS),
                                child: Text('No results',
                                    style: AppTheme.caption),
                              );
                            }
                            return ListView.separated(
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: accounts.length,
                              separatorBuilder: (_, _) => const Divider(
                                  height: 1, color: AppTheme.dividerColor),
                              itemBuilder: (ctx, i) {
                                final gl = accounts[i];
                                return _HoverableGLRow(
                                  onTap: () {
                                    ref.read(markGlAsUsedProvider(gl));
                                    setState(() {
                                      _selectedGL = gl;
                                      _glSearchController.text =
                                          '${gl.glCode} — ${gl.glDescription}';
                                      _showGLDropdown = false;
                                      _glQuery = '';
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    child: Row(
                                      children: [
                                        Text(gl.glCode,
                                            style: TextStyle(
                                              fontFamily: 'SF Pro Display',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: widget.accentColor,
                                            )),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(gl.glDescription,
                                              style: AppTheme.caption,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          loading: () => const Padding(
                            padding: EdgeInsets.all(AppTheme.spacingS),
                            child: CupertinoActivityIndicator(),
                          ),
                          error: (_, _) => const SizedBox.shrink(),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 6),

              // Amount
              Expanded(
                flex: 2,
                child: _buildField(
                  controller: _amountController,
                  placeholder: '0.00',
                  prefix: '₹',
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submit(),
                ),
              ),
              const SizedBox(width: 6),

              // Add button
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _submit,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 9),
                  decoration: BoxDecoration(
                    color: widget.accentColor,
                    borderRadius:
                        BorderRadius.circular(AppTheme.radiusMedium),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(CupertinoIcons.add,
                          color: AppTheme.surfaceWhite, size: 15),
                      SizedBox(width: 4),
                      Text('Add',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.surfaceWhite,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String placeholder,
    String? prefix,
    Color? focusColor,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: AppTheme.dividerColor),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          if (prefix != null) ...[
            Text(prefix,
                style: AppTheme.caption.copyWith(color: AppTheme.textPrimary)),
            const SizedBox(width: 4),
          ],
          Expanded(
            child: CupertinoTextField(
              controller: controller,
              placeholder: placeholder,
              keyboardType: keyboardType,
              decoration: const BoxDecoration(),
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 13,
                color: AppTheme.textPrimary,
              ),
              placeholderStyle: AppTheme.caption,
              onTap: onTap,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            ),
          ),
        ],
      ),
    );
  }
}

// Hover effect for GL dropdown rows
class _HoverableGLRow extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _HoverableGLRow({required this.child, required this.onTap});

  @override
  State<_HoverableGLRow> createState() => _HoverableGLRowState();
}

class _HoverableGLRowState extends State<_HoverableGLRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: _hovered
              ? AppTheme.primaryBlue.withValues(alpha: 0.06)
              : Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────
// MOBILE: Add Entry Sheet (unchanged)
// ─────────────────────────────────────────────────────────────

class AddEntryScreen extends ConsumerStatefulWidget {
  const AddEntryScreen({super.key});

  @override
  ConsumerState<AddEntryScreen> createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends ConsumerState<AddEntryScreen> {
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
    final activeColor = _isDebit
        ? AppTheme.warningOrange
        : AppTheme.successGreen;

    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      resizeToAvoidBottomInset: false, // IMPORTANT: avoid double inset
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
        border: null,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        middle: const Text(
          'Add Entry',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _addEntry,
          child: const Text('Add'),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.fromLTRB(
                AppTheme.spacingM,
                AppTheme.spacingM,
                AppTheme.spacingM,
                AppTheme.spacingM + bottomInset,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- keep your existing widgets EXACTLY as-is below ---
                    Text(
                      'Entry Type',
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),

                    CupertinoSegmentedControl<bool>(
                      padding: const EdgeInsets.all(3),
                      groupValue: _isDebit,
                      selectedColor: activeColor,
                      unselectedColor: AppTheme.surfaceWhite,
                      borderColor: activeColor.withOpacity(0.55),
                      pressedColor: activeColor.withOpacity(0.18),
                      children: {
                        true: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                          child: Text(
                            'Debit',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w600,
                              color: _isDebit
                                  ? AppTheme.surfaceWhite
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ),
                        false: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 10,
                          ),
                          child: Text(
                            'Credit',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w600,
                              color: !_isDebit
                                  ? AppTheme.surfaceWhite
                                  : AppTheme.textPrimary,
                            ),
                          ),
                        ),
                      },
                      onValueChanged: (value) =>
                          setState(() => _isDebit = value),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    IOSTextField(
                      controller: _descriptionController,
                      label: 'Description',
                      placeholder: 'Enter entry description',
                      maxLines: 2,
                      fillColor: AppTheme.surfaceWhite,
                    ),

                    const SizedBox(height: AppTheme.spacingL),

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
                      fillColor: AppTheme.surfaceWhite,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showGLPicker() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => GLAccountPickerScreen(
          onSelected: (gl) => setState(() => _selectedGL = gl),
        ),
      ),
    );
  }

  void _addEntry() {
    FocusScope.of(context).unfocus();

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

    ref.read(paymentAuthorityProvider.notifier).addEntry(AccountEntry(
          description: _descriptionController.text,
          glAccount: _selectedGL,
          amount: double.tryParse(_amountController.text) ?? 0.0,
          isDebit: _isDebit,
        ));
    Navigator.pop(context);
  }
}

class GLAccountPickerScreen extends ConsumerStatefulWidget {
  final Function(GLAccount) onSelected;

  const GLAccountPickerScreen({super.key, required this.onSelected});

  @override
  ConsumerState<GLAccountPickerScreen> createState() =>
      _GLAccountPickerScreenState();
}

class _GLAccountPickerScreenState
    extends ConsumerState<GLAccountPickerScreen> {
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
        backgroundColor: AppTheme.surfaceWhite.withValues(alpha: 0.9),
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
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search GL code or description',
                onChanged: (value) =>
                    setState(() => _searchQuery = value),
              ),
            ),
            Expanded(
              child: glAccountsAsync.when(
                data: (accounts) {
                  if (accounts.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(CupertinoIcons.search,
                              size: 64,
                              color: AppTheme.textSecondary
                                  .withValues(alpha: 0.5)),
                          const SizedBox(height: 16),
                          const Text('No GL accounts found',
                              style: AppTheme.body2),
                        ],
                      ),
                    );
                  }
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: accounts.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      color: AppTheme.dividerColor,
                      indent: AppTheme.spacingM,
                    ),
                    itemBuilder: (context, index) {
                      final gl = accounts[index];
                      return CupertinoButton(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingM, vertical: 12),
                        onPressed: () {
                          ref.read(markGlAsUsedProvider(gl));
                          widget.onSelected(gl);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(CupertinoIcons.number,
                                  size: 18, color: AppTheme.primaryBlue),
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
                                  Text(gl.glDescription,
                                      style: AppTheme.caption,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                            const Icon(CupertinoIcons.chevron_right,
                                size: 18, color: AppTheme.textSecondary),
                          ],
                        ),
                      );
                    },
                  );
                },
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (_, _) => const Center(
                  child: Text('Error loading GL accounts',
                      style: AppTheme.body2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
