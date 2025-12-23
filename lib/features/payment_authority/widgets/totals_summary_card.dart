// lib/features/payment_authority/widgets/totals_summary_card.dart

import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_theme.dart';

class TotalsSummaryCard extends StatelessWidget {
  final double totalDebit;
  final double totalCredit;
  final bool isBalanced;

  const TotalsSummaryCard({
    super.key,
    required this.totalDebit,
    required this.totalCredit,
    required this.isBalanced,
  });

  @override
  Widget build(BuildContext context) {
    final difference = (totalDebit - totalCredit).abs();

    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: isBalanced
              ? AppTheme.successGreen.withOpacity(0.3)
              : AppTheme.errorRed.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: isBalanced
                ? AppTheme.successGreen.withOpacity(0.1)
                : AppTheme.errorRed.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              Icon(
                isBalanced
                    ? CupertinoIcons.check_mark_circled_solid
                    : CupertinoIcons.exclamationmark_triangle_fill,
                color: isBalanced ? AppTheme.successGreen : AppTheme.errorRed,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isBalanced ? 'Balanced' : 'Unbalanced',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: isBalanced ? AppTheme.successGreen : AppTheme.errorRed,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingL),

          // Totals
          Row(
            children: [
              Expanded(
                child: _buildTotalItem(
                  'Total Debit',
                  totalDebit,
                  AppTheme.warningOrange,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: _buildTotalItem(
                  'Total Credit',
                  totalCredit,
                  AppTheme.successGreen,
                ),
              ),
            ],
          ),

          if (!isBalanced) ...[
            const SizedBox(height: AppTheme.spacingM),
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: AppTheme.errorRed.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.info_circle_fill,
                    size: 16,
                    color: AppTheme.errorRed,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Difference: ₹${difference.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.errorRed,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTotalItem(String label, double amount, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTheme.caption.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 4),
          Text(
            '₹${amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
