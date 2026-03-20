import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saral_office/core/database/models/saved_authority.dart';
import '../../core/theme/app_theme.dart';
import '../payment_authority/screens/create_authority_screen.dart';
import '../payment_authority/providers/payment_authority_provider.dart';
import 'widgets/stats_card.dart';
import 'widgets/recent_authorities_list.dart';
import 'widgets/quick_action_button.dart';
import 'dart:convert';

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
    if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS ||
        defaultTargetPlatform == TargetPlatform.linux) {
      return _buildDesktopLayout();
    }
    return _buildMobileLayout();
  }

  // ─────────────────────────────────────────────────────────────
  // DESKTOP LAYOUT
  // ─────────────────────────────────────────────────────────────

  Widget _buildDesktopLayout() {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      child: Column(
        children: [
          _buildDesktopTopBar(),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDesktopSidebar(),
                  Container(width: 1, color: AppTheme.dividerColor),
                  Expanded(child: _buildDesktopContent()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopTopBar() {
    return Container(
      height: 52,
      color: AppTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
      child: Row(
        children: [
          const Icon(CupertinoIcons.doc_text_fill,
              color: AppTheme.primaryBlue, size: 20),
          const SizedBox(width: AppTheme.spacingS),
          const Text(
            'SaralOffice',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimary,
            ),
          ),
          const Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _showSettingsSheet(context),
            child: const Row(
              children: [
                Icon(CupertinoIcons.settings, size: 18,
                    color: AppTheme.textSecondary),
                SizedBox(width: 6),
                Text('Settings',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopSidebar() {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';

    return Container(
      width: 240,
      color: AppTheme.surfaceWhite,
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(greeting,
              style:
                  AppTheme.caption.copyWith(color: AppTheme.textSecondary)),
          const SizedBox(height: 2),
          const Text('Payment Authorities',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              )),

          const SizedBox(height: AppTheme.spacingL),
          const Divider(height: 1, color: AppTheme.dividerColor),
          const SizedBox(height: AppTheme.spacingM),

          // Navigation items
          _buildSidebarItem(
            icon: CupertinoIcons.add_circled_solid,
            label: 'New Authority',
            color: AppTheme.primaryBlue,
            isPrimary: true,
            onTap: _navigateToCreateAuthority,
          ),
          const SizedBox(height: AppTheme.spacingS),
          _buildSidebarItem(
            icon: CupertinoIcons.search,
            label: 'Search Vendors',
            color: AppTheme.secondaryBlue,
            onTap: () => _showComingSoon('Vendor Search'),
          ),
          const SizedBox(height: AppTheme.spacingS),
          _buildSidebarItem(
            icon: CupertinoIcons.doc_text_search,
            label: 'Browse GL Accounts',
            color: AppTheme.warningOrange,
            onTap: () => _showComingSoon('GL Browser'),
          ),
          const SizedBox(height: AppTheme.spacingS),
          _buildSidebarItem(
            icon: CupertinoIcons.chart_bar_square,
            label: 'View History',
            color: AppTheme.successGreen,
            onTap: () => _showComingSoon('History'),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM, vertical: 10),
        decoration: BoxDecoration(
          color: isPrimary ? AppTheme.primaryBlue : Colors.transparent,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 18,
                color: isPrimary ? AppTheme.surfaceWhite : color),
            const SizedBox(width: AppTheme.spacingS),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                fontWeight:
                    isPrimary ? FontWeight.w600 : FontWeight.w500,
                color: isPrimary
                    ? AppTheme.surfaceWhite
                    : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats bar
        Container(
          color: AppTheme.backgroundLight,
          padding: const EdgeInsets.fromLTRB(
              AppTheme.spacingL, AppTheme.spacingM, AppTheme.spacingL, 0),
          child: _buildStatsSection(),
        ),
        const SizedBox(height: AppTheme.spacingM),

        // Recent Authorities header
        Padding(
          padding: const EdgeInsets.fromLTRB(
              AppTheme.spacingL, 0, AppTheme.spacingL, AppTheme.spacingS),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Authorities',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  )),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _showComingSoon('History'),
                child: const Text('View All',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 14,
                      color: AppTheme.primaryBlue,
                    )),
              ),
            ],
          ),
        ),

        // Table header
        _buildTableHeader(),

        // Authorities list
        Expanded(child: _buildDesktopAuthoritiesList()),
      ],
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: AppTheme.dividerColor.withValues(alpha: 0.5),
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingL, vertical: 8),
      child: const Row(
        children: [
          SizedBox(
            width: 180,
            child: Text('Authority No.',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                )),
          ),
          Expanded(
            child: Text('Vendor',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                )),
          ),
          SizedBox(
            width: 120,
            child: Text('Date',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                )),
          ),
          SizedBox(
            width: 120,
            child: Text('Amount',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textSecondary,
                )),
          ),
          SizedBox(width: AppTheme.spacingM),
        ],
      ),
    );
  }

  Widget _buildDesktopAuthoritiesList() {
    return Consumer(
      builder: (context, ref, _) {
        final authoritiesAsync = ref.watch(recentAuthoritiesProvider);
        return authoritiesAsync.when(
          data: (authorities) {
            if (authorities.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryBlue.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(CupertinoIcons.doc_text,
                          color: AppTheme.primaryBlue, size: 36),
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    const Text('No authorities yet',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        )),
                    const SizedBox(height: AppTheme.spacingS),
                    Text('Click "New Authority" to get started',
                        style: AppTheme.body2),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: authorities.length,
              separatorBuilder: (_, _) =>
                  const Divider(height: 1, color: AppTheme.dividerColor),
              itemBuilder: (context, index) {
                return _buildDesktopAuthorityRow(authorities[index], ref);
              },
            );
          },
          loading: () => const Center(child: CupertinoActivityIndicator()),
          error: (e, _) => Center(child: Text('Error: $e', style: AppTheme.body2)),
        );
      },
    );
  }

  Widget _buildDesktopAuthorityRow(SavedAuthority authority, WidgetRef ref) {
    final dateFormat = DateFormat('dd MMM yyyy');
    return _HoverableRow(
      onTap: () => _handleAuthorityTap(authority, ref),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingL, vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 180,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(CupertinoIcons.doc_text_fill,
                        color: AppTheme.primaryBlue, size: 16),
                  ),
                  const SizedBox(width: AppTheme.spacingS),
                  Expanded(
                    child: Text(
                      authority.authorityOrderNo,
                      style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                authority.vendorName,
                style: AppTheme.body2.copyWith(color: AppTheme.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                dateFormat.format(authority.createdAt),
                style: AppTheme.caption,
              ),
            ),
            SizedBox(
              width: 120,
              child: Text(
                '₹${NumberFormat.compact().format(authority.amount)}',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.successGreen,
                ),
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
          ],
        ),
      ),
    );
  }

  void _handleAuthorityTap(SavedAuthority savedAuthority, WidgetRef ref) {
    try {
      final authorityMap =
          jsonDecode(savedAuthority.fullJsonData) as Map<String, dynamic>;
      final authority = PaymentAuthority.fromMap(authorityMap);
      ref.read(paymentAuthorityProvider.notifier).load(authority);
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => const CreateAuthorityScreen()),
      );
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: Text('Failed to load authority.\n$e'),
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

  // ─────────────────────────────────────────────────────────────
  // MOBILE LAYOUT (unchanged)
  // ─────────────────────────────────────────────────────────────

  Widget _buildMobileLayout() {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverNavigationBar(
            backgroundColor: AppTheme.backgroundLight.withValues(alpha: 0.9),
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
                      _buildWelcomeSection(),
                      const SizedBox(height: AppTheme.spacingL),
                      _buildQuickActions(),
                      const SizedBox(height: AppTheme.spacingXL),
                      _buildStatsSection(),
                      const SizedBox(height: AppTheme.spacingXL),
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
        Text(greeting,
            style: AppTheme.headline3.copyWith(color: AppTheme.textSecondary)),
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
            icon: CupertinoIcons.search,
            title: 'Search Vendors',
            subtitle: 'Find vendor details quickly',
            iconColor: AppTheme.secondaryBlue,
            onTap: () => _showComingSoon('Vendor Search'),
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.doc_text_search,
            title: 'Browse GL Accounts',
            subtitle: 'View all GL codes',
            iconColor: AppTheme.warningOrange,
            onTap: () => _showComingSoon('GL Browser'),
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.chart_bar_square,
            title: 'View History',
            subtitle: 'Past payment authorities',
            iconColor: AppTheme.successGreen,
            onTap: () => _showComingSoon('History'),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Authorities', style: AppTheme.headline3),
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () => _showComingSoon('History'),
              child: Text(
                'View All',
                style: AppTheme.body2.copyWith(color: AppTheme.primaryBlue),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacingM),
        const RecentAuthoritiesList(),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────
  // SHARED: Stats Section
  // ─────────────────────────────────────────────────────────────

  Widget _buildStatsSection() {
    return Consumer(
      builder: (context, ref, child) {
        final authoritiesAsync = ref.watch(recentAuthoritiesProvider);
        return authoritiesAsync.when(
          data: (authorities) {
            final totalCount = authorities.length;
            final now = DateTime.now();
            final thisMonthCount = authorities
                .where((a) =>
                    a.createdAt.year == now.year &&
                    a.createdAt.month == now.month)
                .length;
            final thisMonthAmount = authorities
                .where((a) =>
                    a.createdAt.year == now.year &&
                    a.createdAt.month == now.month)
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
                      color: AppTheme.primaryBlue)),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                  child: StatsCard(
                      icon: CupertinoIcons.calendar,
                      title: 'This Month',
                      value: '-',
                      color: AppTheme.successGreen)),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                  child: StatsCard(
                      icon: CupertinoIcons.money_dollar_circle,
                      title: 'Amount',
                      value: '-',
                      color: AppTheme.warningOrange)),
            ],
          ),
          error: (_, _) => Row(
            children: [
              Expanded(
                  child: StatsCard(
                      icon: CupertinoIcons.doc_text,
                      title: 'Total',
                      value: '0',
                      color: AppTheme.primaryBlue)),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                  child: StatsCard(
                      icon: CupertinoIcons.calendar,
                      title: 'This Month',
                      value: '0',
                      color: AppTheme.successGreen)),
              const SizedBox(width: AppTheme.spacingM),
              Expanded(
                  child: StatsCard(
                      icon: CupertinoIcons.money_dollar_circle,
                      title: 'Amount',
                      value: '₹0',
                      color: AppTheme.warningOrange)),
            ],
          ),
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────
  // SHARED: Navigation & Dialogs
  // ─────────────────────────────────────────────────────────────

  void _navigateToCreateAuthority() {
    ref.read(paymentAuthorityProvider.notifier).reset();
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => const CreateAuthorityScreen()));
  }

  void _showSettingsSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text('Settings'),
        message: const Text('Manage your SaralOffice preferences'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _showComingSoon('Sync Data');
            },
            child: const Text('Sync Data'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _showAboutDialog();
            },
            child: const Text('About'),
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

  void _showAboutDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('SaralOffice'),
        content: const Text(
            'Version 1.0.0\n\nProfessional Payment Authority Generator for Government Offices'),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showComingSoon(String feature) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(feature),
        content: const Text('This feature is coming soon!'),
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

// Hover effect row for desktop table
class _HoverableRow extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _HoverableRow({required this.child, required this.onTap});

  @override
  State<_HoverableRow> createState() => _HoverableRowState();
}

class _HoverableRowState extends State<_HoverableRow> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          color: _hovered
              ? AppTheme.primaryBlue.withValues(alpha: 0.04)
              : Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
