// lib/features/payment_authority/widgets/account_entry_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/payment_authority_provider.dart';

class AccountEntryCard extends StatelessWidget {
  final AccountEntry entry;
  final int index;
  final VoidCallback onDelete;
  // Added onUpdate callback to support editing
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
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: entry.isDebit
              ? AppTheme.warningOrange.withOpacity(0.3)
              : AppTheme.successGreen.withOpacity(0.3),
          width: 1.5,
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
              color: entry.isDebit
                  ? AppTheme.warningOrange.withOpacity(0.1)
                  : AppTheme.successGreen.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radiusMedium - 1),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: entry.isDebit
                        ? AppTheme.warningOrange
                        : AppTheme.successGreen,
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
                const SizedBox(width: 8),
                Text(
                  'Entry ${index + 1}',
                  style: AppTheme.caption.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                // Edit Button (Added if onUpdate is provided)
                if (onUpdate != null) ...[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // Trigger edit logic here if you want to implement inline editing
                      // or open a dialog similar to "Add Entry"
                    },
                    child: const Icon(
                      CupertinoIcons.pencil,
                      size: 18,
                      color: AppTheme.primaryBlue,
                    ),
                    minimumSize: const Size(0, 0),
                  ),
                  const SizedBox(width: 12),
                ],
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

          // Content
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

                // GL Code
                if (entry.glAccount != null) ...[
                  _buildRow('GL Code', entry.glAccount!.glCode),
                  const SizedBox(height: 8),
                  _buildRow('GL Description', entry.glAccount!.glDescription),
                  const SizedBox(height: 10),
                  const Divider(height: 1, color: AppTheme.dividerColor),
                  const SizedBox(height: 10),
                ],

                // Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount',
                      style: AppTheme.caption.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '₹${entry.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: entry.isDebit
                            ? AppTheme.warningOrange
                            : AppTheme.successGreen,
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
