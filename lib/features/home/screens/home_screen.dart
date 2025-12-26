// lib/features/home/screens/home_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../payment_authority/screens/create_authority_screen.dart';
import '../../payment_authority/providers/payment_authority_provider.dart';
import '../../ti_document/screens/create_ti_document_screen.dart';
import '../../ti_document/providers/ti_document_provider.dart';
import '../../employee/screens/employee_management_screen.dart'; // ✅ ADD THIS
import '../widgets/stats_card.dart';
import '../widgets/recent_authorities_list.dart';
import '../widgets/quick_action_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          // Large Title Navigation Bar
          CupertinoSliverNavigationBar(
            backgroundColor: AppTheme.backgroundLight.withOpacity(0.9),
            border: null,
            largeTitle: const Text(
              'SaralOffice',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w700,
              ),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showSettingsSheet(context),
              child: const Icon(CupertinoIcons.settings, size: 24),
            ),
          ),
          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(AppTheme.spacingM),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Section
                      _buildWelcomeSection(),
                      const SizedBox(height: AppTheme.spacingL),
                      // Quick Actions
                      _buildQuickActions(),
                      const SizedBox(height: AppTheme.spacingXL),
                      // Stats Section
                      _buildStatsSection(),
                      const SizedBox(height: AppTheme.spacingXL),
                      // Recent Authorities
                      _buildRecentSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good Morning';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
    } else {
      greeting = 'Good Evening';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          greeting,
          style: AppTheme.headline3.copyWith(color: AppTheme.textSecondary),
        ),
        const SizedBox(height: 4),
        Text('Ready to create payment authorities?', style: AppTheme.body2),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          QuickActionButton(
            icon: CupertinoIcons.add_circled_solid,
            title: 'New Payment Authority',
            subtitle: 'Create a new payment document',
            iconColor: AppTheme.primaryBlue,
            onTap: () => _navigateToCreateAuthority(),
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.doc_append,
            title: 'Create TI Document',
            subtitle: 'Generate transfer information PDFs',
            iconColor: AppTheme.successGreen,
            onTap: () => _navigateToCreateTIDocument(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Statistics', style: AppTheme.headline3),
        const SizedBox(height: AppTheme.spacingM),
        Consumer(
          builder: (context, ref, child) {
            final authoritiesAsync = ref.watch(recentAuthoritiesProvider);
            return authoritiesAsync.when(
              data: (authorities) {
                final totalCount = authorities.length;
                final now = DateTime.now();
                final thisMonthCount = authorities
                    .where(
                      (a) =>
                          a.createdAt.year == now.year &&
                          a.createdAt.month == now.month,
                    )
                    .length;
                final thisMonthAmount = authorities
                    .where(
                      (a) =>
                          a.createdAt.year == now.year &&
                          a.createdAt.month == now.month,
                    )
                    .fold(0.0, (sum, a) => sum + a.amount);

                String formattedAmount;
                if (thisMonthAmount >= 100000) {
                  formattedAmount =
                      '₹${(thisMonthAmount / 100000).toStringAsFixed(1)}L';
                } else if (thisMonthAmount >= 1000) {
                  formattedAmount =
                      '₹${(thisMonthAmount / 1000).toStringAsFixed(1)}K';
                } else {
                  formattedAmount = '₹${thisMonthAmount.toStringAsFixed(0)}';
                }

                return Row(
                  children: [
                    Expanded(
                      child: StatsCard(
                        icon: CupertinoIcons.doc_text_fill,
                        title: 'Total',
                        value: totalCount.toString(),
                        color: AppTheme.primaryBlue,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: StatsCard(
                        icon: CupertinoIcons.calendar,
                        title: 'This Month',
                        value: thisMonthCount.toString(),
                        color: AppTheme.successGreen,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacingM),
                    Expanded(
                      child: StatsCard(
                        icon: CupertinoIcons.money_dollar_circle_fill,
                        title: 'Amount',
                        value: formattedAmount,
                        color: AppTheme.warningOrange,
                      ),
                    ),
                  ],
                );
              },
              loading: () => Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      icon: CupertinoIcons.doc_text,
                      title: 'Total',
                      value: '-',
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: StatsCard(
                      icon: CupertinoIcons.calendar,
                      title: 'This Month',
                      value: '-',
                      color: AppTheme.successGreen,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: StatsCard(
                      icon: CupertinoIcons.money_dollar_circle,
                      title: 'Amount',
                      value: '-',
                      color: AppTheme.warningOrange,
                    ),
                  ),
                ],
              ),
              error: (error, stack) => Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      icon: CupertinoIcons.doc_text,
                      title: 'Total',
                      value: '0',
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: StatsCard(
                      icon: CupertinoIcons.calendar,
                      title: 'This Month',
                      value: '0',
                      color: AppTheme.successGreen,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                    child: StatsCard(
                      icon: CupertinoIcons.money_dollar_circle,
                      title: 'Amount',
                      value: '₹0',
                      color: AppTheme.warningOrange,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentSection() {
    return const RecentAuthoritiesList();
  }

  void _navigateToCreateAuthority() {
    ref.read(paymentAuthorityProvider.notifier).reset();
    Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (_) => const CreateAuthorityScreen()));
  }

  void _navigateToCreateTIDocument() {
    ref.read(tiDocumentProvider.notifier).reset();
    Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (_) => const CreateTIDocumentScreen()));
  }

  // ✅ UPDATED SETTINGS SHEET - ONLY EMPLOYEE MANAGEMENT
  void _showSettingsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Settings'),
        message: const Text('Manage application settings'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => const EmployeeManagementScreen(),
                ),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.person_2_fill,
                  color: AppTheme.primaryBlue,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text('Manage Employees'),
              ],
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ),
    );
  }
}
