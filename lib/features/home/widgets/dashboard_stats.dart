import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:saral_office/core/theme/app_theme.dart';
import 'package:saral_office/features/home/widgets/stats_card.dart';
// Ensure this import points to where recentAuthoritiesProvider is defined
// Based on your files, it seems to be in the provider file or recent_authorities_list
import 'package:saral_office/features/home/widgets/recent_authorities_list.dart';
import 'package:saral_office/features/payment_authority/providers/payment_authority_provider.dart';

class DashboardStats extends ConsumerWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the same provider that feeds the Recent List
    final authoritiesAsync = ref.watch(recentAuthoritiesProvider);

    return authoritiesAsync.when(
      data: (authorities) {
        // 1. Calculate Total Count
        final totalAuthorities = authorities.length;

        // 2. Calculate This Month's Amount
        final now = DateTime.now();
        final thisMonthAmount = authorities
            .where(
              (a) =>
                  a.createdAt.year == now.year &&
                  a.createdAt.month == now.month,
            )
            .fold(0.0, (sum, a) => sum + a.amount);

        // Format amount (e.g., 1.5L for Lakhs or just comma separated)
        String formattedAmount;
        if (thisMonthAmount >= 100000) {
          formattedAmount =
              '₹${(thisMonthAmount / 100000).toStringAsFixed(2)}L';
        } else {
          formattedAmount = '₹${thisMonthAmount.toStringAsFixed(0)}';
        }

        return Row(
          children: [
            Expanded(
              child: StatsCard(
                icon: CupertinoIcons.doc_text_fill,
                title: 'Total Authorities',
                value: totalAuthorities.toString(),
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: StatsCard(
                icon: CupertinoIcons.money_dollar_circle_fill,
                title: 'This Month',
                value: formattedAmount,
                color: AppTheme.successGreen,
              ),
            ),
          ],
        );
      },
      // Show loading state or 0 while loading
      loading: () => const Row(
        children: [
          Expanded(
            child: StatsCard(
              icon: CupertinoIcons.doc_text,
              title: 'Loading...',
              value: '-',
              color: AppTheme.textSecondary,
            ),
          ),
          SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: StatsCard(
              icon: CupertinoIcons.money_dollar,
              title: 'Loading...',
              value: '-',
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
      // Fallback for errors
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
