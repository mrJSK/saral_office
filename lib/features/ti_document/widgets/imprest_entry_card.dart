// lib/features/ti_document/widgets/imprest_entry_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saral_office/features/ti_document/models/imprest_ledger_entry.dart';
import '../../../core/theme/app_theme.dart';

class ImprestEntryCard extends StatefulWidget {
  final ImprestLedgerEntry entry;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;
  final ValueChanged<ImprestLedgerEntry>? onHandReceiptToggle;

  const ImprestEntryCard({
    super.key,
    required this.entry,
    required this.index,
    required this.onDelete,
    this.onEdit,
    this.onHandReceiptToggle,
  });

  @override
  State<ImprestEntryCard> createState() => _ImprestEntryCardState();
}

class _ImprestEntryCardState extends State<ImprestEntryCard> {
  late bool _isHandReceipt;

  @override
  void initState() {
    super.initState();
    _isHandReceipt = widget.entry.isHandReceipt;
  }

  @override
  void didUpdateWidget(ImprestEntryCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.entry.isHandReceipt != widget.entry.isHandReceipt) {
      _isHandReceipt = widget.entry.isHandReceipt;
    }
  }

  void _toggleHandReceipt(bool value) {
    setState(() {
      _isHandReceipt = value;
    });

    // ✅ This is critical - it updates the entry in the provider
    widget.onHandReceiptToggle?.call(
      widget.entry.copyWith(isHandReceipt: value),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: _isHandReceipt ? AppTheme.primaryBlue : AppTheme.dividerColor,
          width: _isHandReceipt ? 2.0 : 1.2,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: _isHandReceipt
                  ? AppTheme.primaryBlue.withOpacity(0.12)
                  : AppTheme.primaryBlue.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusMedium),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Entry ${widget.index + 1}',
                  style: AppTheme.caption.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                // Hand Receipt Toggle
                Tooltip(
                  message: 'Mark as Hand Receipt (Form-2B)',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hand Receipt',
                        style: AppTheme.caption.copyWith(fontSize: 11),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        height: 24,
                        child: CupertinoSwitch(
                          value: _isHandReceipt,
                          onChanged: _toggleHandReceipt,
                          activeColor: AppTheme.primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                if (_isHandReceipt)
                  Icon(
                    CupertinoIcons.doc_text_fill,
                    size: 18,
                    color: AppTheme.primaryBlue,
                  ),
                if (_isHandReceipt) const SizedBox(width: 10),
                if (widget.onEdit != null) ...[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: widget.onEdit,
                    child: const Icon(CupertinoIcons.pencil, size: 18),
                  ),
                  const SizedBox(width: 10),
                ],
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: widget.onDelete,
                  child: const Icon(
                    CupertinoIcons.trash,
                    size: 18,
                    color: AppTheme.errorRed,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Date & Vr No
                Row(
                  children: [
                    Expanded(child: _row('Date', widget.entry.date)),
                    const SizedBox(width: 16),
                    Expanded(child: _row('Vr. No', widget.entry.vrNo)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppTheme.dividerColor),
                const SizedBox(height: 12),

                // GL Code Display
                _row('Head/GL Code', widget.entry.head, isBold: true),
                const SizedBox(height: 12),
                const Divider(height: 1, color: AppTheme.dividerColor),
                const SizedBox(height: 12),

                // Transaction
                _row('Transaction', widget.entry.transaction),
                const SizedBox(height: 16),

                // Amount Row
                Row(
                  children: [
                    Text('Amount', style: AppTheme.caption),
                    const Spacer(),
                    Text(
                      widget.entry.payment.toStringAsFixed(2),
                      style: AppTheme.body1.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: _isHandReceipt
                            ? AppTheme.primaryBlue
                            : AppTheme.successGreen,
                      ),
                    ),
                  ],
                ),

                // Optional: Show Running Total
                if (widget.entry.total > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Running Total',
                        style: AppTheme.caption.copyWith(fontSize: 11),
                      ),
                      const Spacer(),
                      Text(
                        widget.entry.total.toStringAsFixed(2),
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],

                // Hand Receipt Badge
                if (_isHandReceipt) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                      border: Border.all(
                        color: AppTheme.primaryBlue.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.doc_text,
                          size: 14,
                          color: AppTheme.primaryBlue,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Hand Receipt (Form-2B)',
                          style: AppTheme.caption.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: isBold
              ? const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                )
              : AppTheme.body2.copyWith(color: AppTheme.textPrimary),
        ),
      ],
    );
  }
}
