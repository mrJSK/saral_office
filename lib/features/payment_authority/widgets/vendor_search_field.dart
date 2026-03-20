// lib/features/payment_authority/widgets/vendor_search_field.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/vendor.dart';
import '../providers/payment_authority_provider.dart';

class VendorSearchField extends ConsumerStatefulWidget {
  final Vendor? selectedVendor;
  final Function(Vendor?) onChanged;

  const VendorSearchField({
    super.key,
    required this.selectedVendor,
    required this.onChanged,
  });

  @override
  ConsumerState<VendorSearchField> createState() => _VendorSearchFieldState();
}

class _VendorSearchFieldState extends ConsumerState<VendorSearchField> {
  final _controller = TextEditingController();
  // Desktop-only state
  String _query = '';
  bool _showDropdown = false;

  bool get _isDesktop =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  @override
  void initState() {
    super.initState();
    if (widget.selectedVendor != null) {
      _controller.text = widget.selectedVendor!.fullName;
    }
  }

  @override
  void didUpdateWidget(VendorSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedVendor != oldWidget.selectedVendor) {
      if (widget.selectedVendor != null) {
        _controller.text = widget.selectedVendor!.fullName;
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
    return _isDesktop ? _buildDesktopField() : _buildMobileField();
  }

  // ── Desktop: inline search + dropdown ──────────────────────

  Widget _buildDesktopField() {
    final vendorsAsync = ref.watch(vendorSearchProvider(_query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vendor Name',
          style: AppTheme.caption.copyWith(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _showDropdown ? AppTheme.primaryBlue : AppTheme.dividerColor,
              width: _showDropdown ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              const Icon(CupertinoIcons.person_2_fill,
                  size: 18, color: AppTheme.primaryBlue),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoTextField(
                  controller: _controller,
                  placeholder: 'Search vendor name or code',
                  decoration: const BoxDecoration(),
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                  ),
                  placeholderStyle: AppTheme.body2,
                  onTap: () => setState(() => _showDropdown = true),
                  onChanged: (val) => setState(() {
                    _query = val;
                    _showDropdown = true;
                    if (val.isEmpty) widget.onChanged(null);
                  }),
                ),
              ),
              if (widget.selectedVendor != null)
                GestureDetector(
                  onTap: () {
                    _controller.clear();
                    setState(() {
                      _query = '';
                      _showDropdown = false;
                    });
                    widget.onChanged(null);
                  },
                  child: const Icon(CupertinoIcons.xmark_circle_fill,
                      size: 18, color: AppTheme.textSecondary),
                ),
            ],
          ),
        ),
        if (_showDropdown)
          Container(
            constraints: const BoxConstraints(maxHeight: 240),
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: AppTheme.surfaceWhite,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(color: AppTheme.dividerColor),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: vendorsAsync.when(
              data: (vendors) {
                if (vendors.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(AppTheme.spacingM),
                    child: Text('No vendors found', style: AppTheme.caption),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: vendors.length,
                  separatorBuilder: (_, _) =>
                      const Divider(height: 1, color: AppTheme.dividerColor),
                  itemBuilder: (ctx, i) {
                    final vendor = vendors[i];
                    return _HoverableRow(
                      onTap: () {
                        _controller.text = vendor.fullName;
                        setState(() {
                          _query = '';
                          _showDropdown = false;
                        });
                        widget.onChanged(vendor);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryBlue.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(CupertinoIcons.person_fill,
                                  size: 14, color: AppTheme.secondaryBlue),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendor.fullName,
                                    style: const TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    children: [
                                      Text(vendor.vendorCode,
                                          style: AppTheme.caption.copyWith(
                                              color: AppTheme.primaryBlue)),
                                      if (vendor.city.isNotEmpty) ...[
                                        const Text(' · ',
                                            style: AppTheme.caption),
                                        Expanded(
                                          child: Text(vendor.city,
                                              style: AppTheme.caption,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(AppTheme.spacingM),
                child: CupertinoActivityIndicator(),
              ),
              error: (_, _) => const Padding(
                padding: EdgeInsets.all(AppTheme.spacingM),
                child: Text('Error loading vendors', style: AppTheme.caption),
              ),
            ),
          ),
      ],
    );
  }

  // ── Mobile: tap to open full-screen picker ──────────────────

  Widget _buildMobileField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vendor Name',
          style: AppTheme.caption.copyWith(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: () => _showVendorPicker(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.dividerColor, width: 1),
            ),
            child: Row(
              children: [
                const Icon(CupertinoIcons.person_2_fill,
                    size: 18, color: AppTheme.primaryBlue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.selectedVendor?.fullName ?? 'Select Vendor',
                    style: widget.selectedVendor != null
                        ? AppTheme.body1.copyWith(fontSize: 15)
                        : AppTheme.body2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(CupertinoIcons.chevron_right,
                    size: 18, color: AppTheme.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showVendorPicker(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => VendorPickerScreen(onSelected: widget.onChanged),
      ),
    );
  }
}

// ── Mobile Full-Screen Picker (unchanged) ────────────────────

class VendorPickerScreen extends ConsumerStatefulWidget {
  final Function(Vendor) onSelected;

  const VendorPickerScreen({super.key, required this.onSelected});

  @override
  ConsumerState<VendorPickerScreen> createState() => _VendorPickerScreenState();
}

class _VendorPickerScreenState extends ConsumerState<VendorPickerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vendorsAsync = ref.watch(vendorSearchProvider(_searchQuery));

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
        middle: const Text('Select Vendor'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search vendor name or code',
                onChanged: (value) => setState(() => _searchQuery = value),
              ),
            ),
            Expanded(
              child: vendorsAsync.when(
                data: (vendors) {
                  if (vendors.isEmpty) {
                    return const Center(
                      child: Text('No vendors found', style: AppTheme.body2),
                    );
                  }
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: vendors.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      color: AppTheme.dividerColor,
                      indent: AppTheme.spacingM,
                    ),
                    itemBuilder: (context, index) {
                      final vendor = vendors[index];
                      return CupertinoButton(
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        onPressed: () {
                          widget.onSelected(vendor);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vendor.fullName,
                                    style: const TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    vendor.vendorCode,
                                    style: const TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 14,
                                      color: AppTheme.textSecondary,
                                    ),
                                  ),
                                  if (vendor.city.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(vendor.city, style: AppTheme.caption),
                                  ],
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
                  child: Text('Error loading vendors', style: AppTheme.body2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Shared hover row widget ──────────────────────────────────

class _HoverableRow extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _HoverableRow({required this.child, required this.onTap});

  @override
  State<_HoverableRow> createState() => _HoverableRowState();
}

class _HoverableRowState extends State<_HoverableRow> {
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
