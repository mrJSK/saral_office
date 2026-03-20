// lib/core/widgets/custom_date_picker.dart
//
// Standalone, zero-external-dependency date picker for Flutter.
// Drop this single file into any project — only requires package:flutter.
//
// Features:
//   • Mouse-friendly calendar grid with hover states
//   • Click month/year header to switch views:
//       Day  →  Month grid (Jan–Dec)
//       Month  →  Year grid (12 years at a time)
//       Year  → back to Day
//   • Dark-mode aware (reads CupertinoTheme brightness)
//   • Customisable accent colour
//
// Usage:
//   final picked = await showCustomDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//   );
//   if (picked != null) { /* use picked */ }
//
// Or embed the dialog widget directly:
//   showCupertinoDialog(builder: (_) => CustomDatePickerDialog(...))

import 'package:flutter/cupertino.dart';

// ─── Public API ────────────────────────────────────────────────────────────────

/// Shows the custom calendar picker as a dialog.
/// Returns the chosen [DateTime] or `null` if dismissed.
Future<DateTime?> showCustomDatePicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Color? accentColor,
}) {
  return showCupertinoDialog<DateTime>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => CustomDatePickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      accentColor: accentColor,
    ),
  );
}

// ─── Dialog widget (can be used directly) ─────────────────────────────────────

class CustomDatePickerDialog extends StatefulWidget {
  final DateTime initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;

  /// Accent colour for selected dates, today ring, and navigation arrows.
  /// Defaults to [CupertinoColors.systemBlue].
  final Color? accentColor;

  const CustomDatePickerDialog({
    super.key,
    required this.initialDate,
    this.firstDate,
    this.lastDate,
    this.accentColor,
  });

  @override
  State<CustomDatePickerDialog> createState() => _CustomDatePickerDialogState();
}

// ─── Internal state ────────────────────────────────────────────────────────────

enum _PickerView { day, month, year }

class _CustomDatePickerDialogState extends State<CustomDatePickerDialog> {
  late DateTime _selected;
  late DateTime _month; // always the 1st of the displayed month
  late DateTime _first;
  late DateTime _last;
  _PickerView _view = _PickerView.day;
  late int _yearRangeStart; // first year shown in year grid

  static const _weekDays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  static const _monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];
  static const _monthShort = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.initialDate;
    _month = DateTime(widget.initialDate.year, widget.initialDate.month);
    _first = widget.firstDate ?? DateTime(1900);
    _last = widget.lastDate ?? DateTime.now().add(const Duration(days: 365 * 10));
    _yearRangeStart = (_month.year ~/ 12) * 12;
  }

  Color get _accent => widget.accentColor ?? CupertinoColors.systemBlue;

  // ── View switching ──────────────────────────────────────────────────────────

  void _onHeaderTap() => setState(() {
        _view = switch (_view) {
          _PickerView.day => _PickerView.month,
          _PickerView.month => _PickerView.year,
          _PickerView.year => _PickerView.day,
        };
      });

  // ── Navigation arrows ───────────────────────────────────────────────────────

  void _prev() => setState(() {
        switch (_view) {
          case _PickerView.day:
            _month = DateTime(_month.year, _month.month - 1);
          case _PickerView.month:
            _month = DateTime(_month.year - 1, _month.month);
          case _PickerView.year:
            _yearRangeStart -= 12;
        }
      });

  void _next() => setState(() {
        switch (_view) {
          case _PickerView.day:
            _month = DateTime(_month.year, _month.month + 1);
          case _PickerView.month:
            _month = DateTime(_month.year + 1, _month.month);
          case _PickerView.year:
            _yearRangeStart += 12;
        }
      });

  String get _headerLabel => switch (_view) {
        _PickerView.day => '${_monthNames[_month.month - 1]}, ${_month.year}',
        _PickerView.month => '${_month.year}',
        _PickerView.year => '$_yearRangeStart – ${_yearRangeStart + 11}',
      };

  // ── Day grid helpers ────────────────────────────────────────────────────────

  List<DateTime> _buildDayGrid() {
    final startOffset = _month.weekday % 7;
    final lastDay = DateTime(_month.year, _month.month + 1, 0).day;
    final grid = <DateTime>[];
    for (int i = startOffset - 1; i >= 0; i--) {
      grid.add(DateTime(_month.year, _month.month, -i));
    }
    for (int d = 1; d <= lastDay; d++) {
      grid.add(DateTime(_month.year, _month.month, d));
    }
    int next = 1;
    while (grid.length < 42) {
      grid.add(DateTime(_month.year, _month.month + 1, next++));
    }
    return grid;
  }

  // ── Selection callbacks ─────────────────────────────────────────────────────

  void _pickDay(DateTime date) {
    setState(() => _selected = date);
    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) Navigator.pop(context, _selected);
    });
  }

  void _pickMonth(int month) => setState(() {
        _month = DateTime(_month.year, month);
        _view = _PickerView.day;
      });

  void _pickYear(int year) => setState(() {
        _month = DateTime(year, _month.month);
        _view = _PickerView.month;
      });

  // ── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.of(context).brightness == Brightness.dark;
    final bg = isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);
    final textCol = isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
    final divCol = isDark ? const Color(0xFF38383A) : const Color(0xFFE5E5EA);
    final subtleCol = isDark ? const Color(0xFF8E8E93) : const Color(0xFF8E8E93);

    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000)
                  .withValues(alpha: isDark ? 0.55 : 0.18),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(textCol, isDark),
            Container(height: 1, color: divCol),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 180),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: switch (_view) {
                _PickerView.day => _buildDayView(
                    textCol, subtleCol, divCol, isDark,
                    key: const ValueKey('day')),
                _PickerView.month => _buildMonthView(textCol, isDark,
                    key: const ValueKey('month')),
                _PickerView.year => _buildYearView(textCol, isDark,
                    key: const ValueKey('year')),
              },
            ),
          ],
        ),
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────────

  Widget _buildHeader(Color textCol, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _onHeaderTap,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _headerLabel,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textCol,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(
                      _view == _PickerView.year
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      size: 12,
                      color: _accent,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _NavArrow(icon: CupertinoIcons.chevron_up, onTap: _prev, isDark: isDark, accent: _accent),
          const SizedBox(width: 2),
          _NavArrow(icon: CupertinoIcons.chevron_down, onTap: _next, isDark: isDark, accent: _accent),
        ],
      ),
    );
  }

  // ── Day view ────────────────────────────────────────────────────────────────

  Widget _buildDayView(Color textCol, Color subtleCol, Color divCol, bool isDark,
      {Key? key}) {
    final grid = _buildDayGrid();
    return KeyedSubtree(
      key: key,
      child: Column(
        children: [
          // Weekday headers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: _weekDays
                  .map((d) => Expanded(
                        child: Center(
                          child: Text(
                            d,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: subtleCol,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Day grid
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: grid.length,
              itemBuilder: (_, i) {
                final date = grid[i];
                final inMonth = date.month == _month.month;
                final isSelected = _sameDay(date, _selected);
                final isToday = _sameDay(date, DateTime.now());
                final enabled = inMonth &&
                    !date.isBefore(_first) &&
                    !date.isAfter(_last);
                return _DayCell(
                  date: date,
                  inMonth: inMonth,
                  isSelected: isSelected,
                  isToday: isToday,
                  enabled: enabled,
                  isDark: isDark,
                  textCol: textCol,
                  accent: _accent,
                  onTap: enabled ? () => _pickDay(date) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Month view ──────────────────────────────────────────────────────────────

  Widget _buildMonthView(Color textCol, bool isDark, {Key? key}) {
    final now = DateTime.now();
    return KeyedSubtree(
      key: key,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 12,
          itemBuilder: (_, i) => _MonthYearCell(
            label: _monthShort[i],
            isSelected: i + 1 == _selected.month && _month.year == _selected.year,
            isCurrent: i + 1 == now.month && _month.year == now.year,
            isDark: isDark,
            textCol: textCol,
            accent: _accent,
            onTap: () => _pickMonth(i + 1),
          ),
        ),
      ),
    );
  }

  // ── Year view ───────────────────────────────────────────────────────────────

  Widget _buildYearView(Color textCol, bool isDark, {Key? key}) {
    final now = DateTime.now();
    return KeyedSubtree(
      key: key,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 12,
          itemBuilder: (_, i) {
            final year = _yearRangeStart + i;
            return _MonthYearCell(
              label: '$year',
              isSelected: year == _selected.year,
              isCurrent: year == now.year,
              isDark: isDark,
              textCol: textCol,
              accent: _accent,
              onTap: () => _pickYear(year),
            );
          },
        ),
      ),
    );
  }

  static bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

// ─── Day cell ──────────────────────────────────────────────────────────────────

class _DayCell extends StatefulWidget {
  final DateTime date;
  final bool inMonth, isSelected, isToday, enabled, isDark;
  final Color textCol, accent;
  final VoidCallback? onTap;

  const _DayCell({
    required this.date,
    required this.inMonth,
    required this.isSelected,
    required this.isToday,
    required this.enabled,
    required this.isDark,
    required this.textCol,
    required this.accent,
    this.onTap,
  });

  @override
  State<_DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<_DayCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    Color? circleBg;
    Color labelCol;

    if (widget.isSelected) {
      circleBg = widget.accent;
      labelCol = const Color(0xFFFFFFFF);
    } else if (_hovered && widget.enabled) {
      circleBg = widget.accent.withValues(alpha: 0.12);
      labelCol = widget.textCol;
    } else {
      circleBg = null;
      if (!widget.inMonth) {
        labelCol = const Color(0xFF8E8E93).withValues(alpha: 0.4);
      } else if (widget.isToday) {
        labelCol = widget.accent;
      } else {
        labelCol = widget.textCol;
      }
    }

    return MouseRegion(
      cursor: widget.enabled ? SystemMouseCursors.click : MouseCursor.defer,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: circleBg,
              shape: BoxShape.circle,
              border: widget.isToday && !widget.isSelected
                  ? Border.all(
                      color: widget.accent.withValues(alpha: 0.5), width: 1)
                  : null,
            ),
            child: Center(
              child: Text(
                '${widget.date.day}',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: widget.isSelected || widget.isToday
                      ? FontWeight.w600
                      : FontWeight.w400,
                  color: labelCol,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Month / Year cell ─────────────────────────────────────────────────────────

class _MonthYearCell extends StatefulWidget {
  final String label;
  final bool isSelected, isCurrent, isDark;
  final Color textCol, accent;
  final VoidCallback onTap;

  const _MonthYearCell({
    required this.label,
    required this.isSelected,
    required this.isCurrent,
    required this.isDark,
    required this.textCol,
    required this.accent,
    required this.onTap,
  });

  @override
  State<_MonthYearCell> createState() => _MonthYearCellState();
}

class _MonthYearCellState extends State<_MonthYearCell> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.isSelected
        ? widget.accent
        : _hovered
            ? widget.accent.withValues(alpha: 0.12)
            : widget.isCurrent
                ? widget.accent.withValues(alpha: 0.07)
                : null;

    final textColor = widget.isSelected
        ? const Color(0xFFFFFFFF)
        : widget.isCurrent
            ? widget.accent
            : widget.textCol;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(8),
            border: widget.isCurrent && !widget.isSelected
                ? Border.all(
                    color: widget.accent.withValues(alpha: 0.4), width: 1)
                : null,
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: widget.isSelected || widget.isCurrent
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Navigation arrow button ───────────────────────────────────────────────────

class _NavArrow extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isDark;
  final Color accent;

  const _NavArrow({
    required this.icon,
    required this.onTap,
    required this.isDark,
    required this.accent,
  });

  @override
  State<_NavArrow> createState() => _NavArrowState();
}

class _NavArrowState extends State<_NavArrow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final iconCol =
        widget.isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: _hovered
                ? widget.accent.withValues(alpha: 0.1)
                : const Color(0x00000000),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(widget.icon, size: 13, color: iconCol),
        ),
      ),
    );
  }
}
