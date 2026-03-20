// lib/features/payment_authority/widgets/division_search_field.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  // Desktop-only state
  String _query = '';
  bool _showDropdown = false;

  bool get _isDesktop =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  bool get _isDark =>
      CupertinoTheme.of(context).brightness == Brightness.dark;
  Color get _fieldBg =>
      _isDark ? AppTheme.darkSurface : AppTheme.backgroundLight;
  Color get _dropdownBg =>
      _isDark ? AppTheme.darkCard : AppTheme.surfaceWhite;
  Color get _divCol =>
      _isDark ? AppTheme.darkDivider : AppTheme.dividerColor;
  Color get _textCol =>
      _isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;

  @override
  void initState() {
    super.initState();
    if (widget.selectedDivision != null) {
      _controller.text = widget.selectedDivision!.displayText;
    }
  }

  @override
  void didUpdateWidget(DivisionSearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDivision != oldWidget.selectedDivision) {
      if (widget.selectedDivision != null) {
        _controller.text = widget.selectedDivision!.displayText;
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
    final divisionsAsync = ref.watch(divisionSearchProvider(_query));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Division Name',
          style: AppTheme.caption.copyWith(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: _fieldBg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _showDropdown ? AppTheme.primaryBlue : _divCol,
              width: _showDropdown ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            children: [
              const Icon(CupertinoIcons.building_2_fill,
                  size: 18, color: AppTheme.primaryBlue),
              const SizedBox(width: 8),
              Expanded(
                child: CupertinoTextField(
                  controller: _controller,
                  placeholder: 'Search division name or code',
                  decoration: const BoxDecoration(),
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 15,
                    color: _textCol,
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
              if (widget.selectedDivision != null)
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
            constraints: const BoxConstraints(maxHeight: 220),
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              color: _dropdownBg,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              border: Border.all(color: _divCol),
              boxShadow: [
                BoxShadow(
                  color: CupertinoColors.systemGrey.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: divisionsAsync.when(
              data: (divisions) {
                if (divisions.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(AppTheme.spacingM),
                    child: Text('No divisions found', style: AppTheme.caption),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: divisions.length,
                  separatorBuilder: (_, _) =>
                      Divider(height: 1, color: _divCol),
                  itemBuilder: (ctx, i) {
                    final division = divisions[i];
                    return _HoverableRow(
                      onTap: () {
                        _controller.text = division.displayText;
                        setState(() {
                          _query = '';
                          _showDropdown = false;
                        });
                        widget.onChanged(division);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(CupertinoIcons.building_2_fill,
                                  size: 14, color: AppTheme.primaryBlue),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    division.name,
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: _textCol,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    division.fundsCenter,
                                    style: AppTheme.caption,
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
                child: Text('Error loading divisions', style: AppTheme.caption),
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
          'Division Name',
          style: AppTheme.caption.copyWith(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _showDivisionPicker,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: _fieldBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _divCol, width: 1),
            ),
            child: Row(
              children: [
                const Icon(CupertinoIcons.building_2_fill,
                    size: 18, color: AppTheme.primaryBlue),
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
                const Icon(CupertinoIcons.chevron_right,
                    size: 18, color: AppTheme.textSecondary),
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
            setState(() => _controller.text = division.displayText);
            widget.onChanged(division);
          },
        ),
      ),
    );
  }
}

// ── Mobile Full-Screen Picker (unchanged) ────────────────────

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
      navigationBar: const CupertinoNavigationBar(
        border: null,
        middle: Text('Select Division'),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: CupertinoSearchTextField(
                controller: _searchController,
                placeholder: 'Search division name or code',
                onChanged: (value) => setState(() => _searchQuery = value),
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
                    separatorBuilder: (_, _) => const Divider(
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
                                  Text(division.fundsCenter,
                                      style: AppTheme.caption),
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
