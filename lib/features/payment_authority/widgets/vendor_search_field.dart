// lib/features/payment_authority/widgets/vendor_search_field.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/vendor.dart';
import '../providers/payment_authority_provider.dart';

class VendorSearchField extends ConsumerWidget {
  final Vendor? selectedVendor;
  final Function(Vendor?) onChanged;

  const VendorSearchField({
    super.key,
    required this.selectedVendor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vendor Name',
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
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
                Icon(
                  CupertinoIcons.person_2_fill,
                  size: 18,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedVendor?.fullName ?? 'Select Vendor',
                    style: selectedVendor != null
                        ? AppTheme.body1.copyWith(fontSize: 15)
                        : AppTheme.body2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

  void _showVendorPicker(BuildContext context) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => VendorPickerScreen(onSelected: onChanged),
      ),
    );
  }
}

// Vendor Picker Screen
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
        backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
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
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
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
                    separatorBuilder: (_, __) => const Divider(
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
                                  // Title: Vendor Name
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
                                  // Subtitle: Vendor Code
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
                error: (_, __) => const Center(
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
