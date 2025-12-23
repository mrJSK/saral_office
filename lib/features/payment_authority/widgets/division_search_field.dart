// lib/features/payment_authority/widgets/division_search_field.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/database/models/division.dart';
import '../providers/payment_authority_provider.dart';

class DivisionSearchField extends ConsumerStatefulWidget {
  final Division? selectedDivision;
  final Function(Division?) onChanged;

  const DivisionSearchField({
    super.key,
    required this.selectedDivision,
    required this.onChanged,
  });

  @override
  ConsumerState<DivisionSearchField> createState() =>
      _DivisionSearchFieldState();
}

class _DivisionSearchFieldState extends ConsumerState<DivisionSearchField> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedDivision != null) {
      _controller.text = widget.selectedDivision!.displayText;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Division Name',
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _showDivisionPicker,
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
                  CupertinoIcons.building_2_fill,
                  size: 18,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.selectedDivision?.displayText ?? 'Select Division',
                    style: widget.selectedDivision != null
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

  void _showDivisionPicker() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => DivisionPickerScreen(
          onSelected: (division) {
            setState(() {
              _controller.text = division.displayText;
            });
            widget.onChanged(division);
          },
        ),
      ),
    );
  }
}

// Division Picker Screen
class DivisionPickerScreen extends ConsumerStatefulWidget {
  final Function(Division) onSelected;

  const DivisionPickerScreen({super.key, required this.onSelected});

  @override
  ConsumerState<DivisionPickerScreen> createState() =>
      _DivisionPickerScreenState();
}

class _DivisionPickerScreenState extends ConsumerState<DivisionPickerScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final divisionsAsync = ref.watch(divisionSearchProvider(_searchQuery));

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
        middle: const Text('Select Division'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search division name or code',
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
              ),
            ),
            Expanded(
              child: divisionsAsync.when(
                data: (divisions) {
                  if (divisions.isEmpty) {
                    return const Center(
                      child: Text('No divisions found', style: AppTheme.body2),
                    );
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: divisions.length,
                    separatorBuilder: (_, __) => const Divider(
                      height: 1,
                      color: AppTheme.dividerColor,
                      indent: AppTheme.spacingM,
                    ),
                    itemBuilder: (context, index) {
                      final division = divisions[index];
                      return CupertinoButton(
                        padding: const EdgeInsets.all(AppTheme.spacingM),
                        onPressed: () {
                          widget.onSelected(division);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    division.name,
                                    style: const TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    division.fundsCenter,
                                    style: AppTheme.caption,
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
                error: (_, __) => const Center(
                  child: Text('Error loading divisions', style: AppTheme.body2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
