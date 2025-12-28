// lib/features/ti_document/widgets/imprest_entry_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saral_office/features/ti_document/models/imprest_ledger_entry.dart';
import '../../../core/theme/app_theme.dart';

class ImprestEntryCard extends StatelessWidget {
  final ImprestLedgerEntry entry;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback? onEdit;

  const ImprestEntryCard({
    super.key,
    required this.entry,
    required this.index,
    required this.onDelete,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: AppTheme.dividerColor, width: 1.2),
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
              color: AppTheme.primaryBlue.withOpacity(0.08),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusMedium),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'Entry ${index + 1}',
                  style: AppTheme.caption.copyWith(fontWeight: FontWeight.w700),
                ),
                const Spacer(),
                if (onEdit != null) ...[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    minSize: 0,
                    onPressed: onEdit,
                    child: const Icon(CupertinoIcons.pencil, size: 18),
                  ),
                  const SizedBox(width: 10),
                ],
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  onPressed: onDelete,
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
                    Expanded(child: _row('Date', entry.date)),
                    const SizedBox(width: 16),
                    Expanded(child: _row('Vr. No', entry.vrNo)),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: AppTheme.dividerColor),
                const SizedBox(height: 12),

                // GL Code Display (Styled like AccountEntryCard)
                // Assuming entry.head contains "Code - Description" or just Code.
                // If you have separate fields, use them here.
                _row('Head/GL Code', entry.head, isBold: true),

                const SizedBox(height: 12),
                const Divider(height: 1, color: AppTheme.dividerColor),
                const SizedBox(height: 12),

                // Transaction
                _row('Transaction', entry.transaction),

                const SizedBox(height: 16),

                // Amount Row
                Row(
                  children: [
                    Text('Amount', style: AppTheme.caption),
                    const Spacer(),
                    Text(
                      entry.payment.toStringAsFixed(2),
                      style: AppTheme.body1.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.successGreen,
                      ),
                    ),
                  ],
                ),

                // Optional: Show Running Total if needed
                if (entry.total > 0) ...[
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Running Total',
                        style: AppTheme.caption.copyWith(fontSize: 11),
                      ),
                      const Spacer(),
                      Text(
                        entry.total.toStringAsFixed(2),
                        style: AppTheme.caption.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
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
