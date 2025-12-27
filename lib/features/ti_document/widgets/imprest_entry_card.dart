import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../models/ti_pdf_model.dart';

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
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _row('Date', entry.date),
                const SizedBox(height: 8),
                _row('Vr. No', entry.vrNo),
                const SizedBox(height: 8),
                _row('Head/GL Code', entry.head),
                const Divider(height: 18),
                _row('Transaction', entry.transaction),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Amount', style: AppTheme.caption),
                    const Spacer(),
                    Text(
                      entry.payment.toStringAsFixed(2),
                      style: AppTheme.body1.copyWith(
                        fontWeight: FontWeight.w800,
                        color: AppTheme.successGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('Total', style: AppTheme.caption),
                    const Spacer(),
                    Text(
                      entry.total.toStringAsFixed(2),
                      style: AppTheme.body1.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTheme.caption),
        const SizedBox(height: 3),
        Text(value, style: AppTheme.body2),
      ],
    );
  }
}
