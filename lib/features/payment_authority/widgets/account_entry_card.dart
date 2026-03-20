// lib/features/payment_authority/widgets/account_entry_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/payment_authority_provider.dart';

class AccountEntryCard extends StatelessWidget {
  final AccountEntry entry;
  final int index;
  final VoidCallback onDelete;
  final Function(AccountEntry)? onUpdate;

  const AccountEntryCard({
    super.key,
    required this.entry,
    required this.index,
    required this.onDelete,
    this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final typeColor = entry.isDebit
        ? AppTheme.warningOrange
        : AppTheme.successGreen;
    final typeBg = typeColor.withOpacity(0.10);
    final borderColor = typeColor.withOpacity(0.30);

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        children: [
          // Header with DEBIT/CREDIT badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: typeBg,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusMedium - 1),
              ),
            ),
            child: Row(
              children: [
                // DEBIT/CREDIT Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: typeColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    entry.isDebit ? 'DEBIT' : 'CREDIT',
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.surfaceWhite,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Entry number
                Text(
                  'Entry ${index + 1}',
                  style: AppTheme.caption.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),

                // Edit Button
                if (onUpdate != null) ...[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => onUpdate?.call(entry),
                    child: const Icon(
                      CupertinoIcons.pencil,
                      size: 18,
                      color: AppTheme.primaryBlue,
                    ),
                    minimumSize: const Size(0, 0),
                  ),
                  const SizedBox(width: 12),
                ],

                // Delete Button
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: onDelete,
                  child: const Icon(
                    CupertinoIcons.trash,
                    size: 18,
                    color: AppTheme.errorRed,
                  ),
                  minimumSize: const Size(0, 0),
                ),
              ],
            ),
          ),

          // Content Section
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Description
                _buildRow('Description', entry.description),
                const SizedBox(height: 10),
                const Divider(height: 1, color: AppTheme.dividerColor),
                const SizedBox(height: 10),

                // GL Account Details (if available)
                if (entry.glAccount != null) ...[
                  _buildRow('GL Code', entry.glAccount!.glCode),
                  const SizedBox(height: 8),
                  _buildRow('GL Description', entry.glAccount!.glDescription),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: AppTheme.dividerColor),
                  const SizedBox(height: 10),
                ],

                // Amount with dynamic color
                Row(
                  children: [
                    Text(
                      'Amount',
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerRight,
                          child: Text(
                            '₹${entry.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: typeColor,
                            ),
                          ),
                        ),
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

  /// Helper method to build label-value rows
  Widget _buildRow(String label, String value) {
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
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
