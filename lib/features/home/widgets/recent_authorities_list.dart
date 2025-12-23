// lib/features/home/widgets/recent_authorities_list.dart

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saral_office/core/database/models/saved_authority.dart';
import 'package:saral_office/core/theme/app_theme.dart';
import 'package:saral_office/features/payment_authority/providers/payment_authority_provider.dart';
import 'package:saral_office/features/payment_authority/screens/create_authority_screen.dart';

class RecentAuthoritiesList extends ConsumerWidget {
  const RecentAuthoritiesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authoritiesAsync = ref.watch(recentAuthoritiesProvider);

    return authoritiesAsync.when(
      data: (authorities) {
        if (authorities.isEmpty) {
          return _buildEmptyState(context);
        }
        return _buildAuthoritiesList(context, authorities, ref);
      },
      loading: () => _buildLoadingState(),
      error: (error, stackTrace) => _buildErrorState(error),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppTheme.dividerColor, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.primaryBlue.withOpacity(0.15),
                  AppTheme.primaryBlue.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.doc_text,
              color: AppTheme.primaryBlue,
              size: 36,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          const Text(
            'No Authorities Yet',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Create your first payment authority\nto get started',
            style: AppTheme.body2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingL),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: AppTheme.primaryBlue,
            borderRadius: BorderRadius.circular(10),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => const CreateAuthorityScreen(),
                ),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  CupertinoIcons.add,
                  size: 18,
                  color: AppTheme.surfaceWhite,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Create Authority',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.surfaceWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppTheme.dividerColor, width: 1),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CupertinoActivityIndicator(),
          SizedBox(height: AppTheme.spacingM),
          Text(
            'Loading authorities...',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 15,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppTheme.dividerColor, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.errorRed.withOpacity(0.15),
                  AppTheme.errorRed.withOpacity(0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.exclamationmark_circle,
              color: AppTheme.errorRed,
              size: 36,
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          const Text(
            'Error Loading Authorities',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            error.toString(),
            style: AppTheme.caption,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAuthoritiesList(
    BuildContext context,
    List<SavedAuthority> authorities,
    WidgetRef ref,
  ) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: authorities.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppTheme.spacingM),
          itemBuilder: (context, index) {
            return AuthorityCard(
              authority: authorities[index],
              onTap: () =>
                  _handleAuthorityTap(context, authorities[index], ref),
            );
          },
        ),
      ],
    );
  }

  void _handleAuthorityTap(
    BuildContext context,
    SavedAuthority savedAuthority,
    WidgetRef ref,
  ) {
    try {
      final authorityMap =
          jsonDecode(savedAuthority.fullJsonData) as Map<String, dynamic>;

      final authority = PaymentAuthority.fromMap(authorityMap);

      ref.read(paymentAuthorityProvider.notifier).load(authority);

      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => const CreateAuthorityScreen()),
      );
    } catch (e, stackTrace) {
      debugPrint('Error loading authority: $e\n$stackTrace');
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text('Failed to load authority details.\n$e'),
          actions: [
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}

class AuthorityCard extends StatefulWidget {
  final SavedAuthority authority;
  final VoidCallback onTap;

  const AuthorityCard({
    super.key,
    required this.authority,
    required this.onTap,
  });

  @override
  State<AuthorityCard> createState() => _AuthorityCardState();
}

class _AuthorityCardState extends State<AuthorityCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: _isPressed
                ? AppTheme.primaryBlue.withOpacity(0.3)
                : AppTheme.dividerColor,
            width: _isPressed ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(
                _isPressed ? 0.15 : 0.08,
              ),
              blurRadius: _isPressed ? 12 : 8,
              offset: Offset(0, _isPressed ? 3 : 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryBlue.withOpacity(0.15),
                      AppTheme.primaryBlue.withOpacity(0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.primaryBlue.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.doc_text_fill,
                  color: AppTheme.primaryBlue,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.authority.authorityOrderNo,
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                        letterSpacing: -0.24,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.authority.vendorName,
                      style: AppTheme.caption.copyWith(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.calendar,
                          size: 12,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dateFormat.format(widget.authority.createdAt),
                          style: AppTheme.caption.copyWith(fontSize: 11),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          CupertinoIcons.time,
                          size: 12,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeFormat.format(widget.authority.createdAt),
                          style: AppTheme.caption.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${_formatAmount(widget.authority.amount)}',
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.successGreen,
                      letterSpacing: -0.41,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    color: AppTheme.textSecondary,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    final format = NumberFormat.compact();
    return format.format(amount);
  }
}
