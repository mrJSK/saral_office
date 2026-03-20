import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saral_office/core/database/models/saved_authority.dart';
import '../../core/theme/app_theme.dart';
import '../payment_authority/screens/create_authority_screen.dart';
import '../payment_authority/providers/payment_authority_provider.dart';
import '../ti_document/screens/create_ti_document_screen.dart';
import '../ti_document/providers/ti_document_provider.dart';
import '../ti_document/models/ti_document.dart';
import '../employee/screens/employee_management_screen.dart';
import '../procurement/screens/workflow_dashboard_screen.dart';
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
    final now = DateTime.now();
    final dateStr = DateFormat('EEEE, dd MMMM yyyy').format(now);
    return Container(
      height: 52,
      color: AppTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingL),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppTheme.primaryBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(CupertinoIcons.doc_text_fill,
                color: Colors.white, size: 16),
          ),
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
          const SizedBox(width: AppTheme.spacingL),
          Text(dateStr,
              style: AppTheme.caption.copyWith(color: AppTheme.textSecondary)),
          const Spacer(),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _showSettingsSheet(context),
            child: const Row(children: [
              Icon(CupertinoIcons.settings,
                  size: 16, color: AppTheme.textSecondary),
              SizedBox(width: 5),
              Text('Settings',
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 13,
                      color: AppTheme.textSecondary)),
            ]),
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
      width: 220,
      color: AppTheme.surfaceWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting header
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingL, AppTheme.spacingL, AppTheme.spacingL, AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greeting,
                    style: AppTheme.caption
                        .copyWith(color: AppTheme.textSecondary)),
                const SizedBox(height: 2),
                const Text('Welcome back',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    )),
              ],
            ),
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM, vertical: AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Create Documents ──────────────────────
                  _sidebarLabel('CREATE'),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.add_circled_solid,
                    label: 'New Payment Authority',
                    color: AppTheme.primaryBlue,
                    isPrimary: true,
                    onTap: _navigateToCreateAuthority,
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.doc_text_fill,
                    label: 'New TI Document',
                    color: AppTheme.warningOrange,
                    onTap: _navigateToCreateTI,
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  // ── Manage ────────────────────────────────
                  _sidebarLabel('MANAGE'),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.person_2_fill,
                    label: 'Employees',
                    color: AppTheme.secondaryBlue,
                    onTap: _navigateToEmployees,
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.cart_fill,
                    label: 'Procurement',
                    color: AppTheme.successGreen,
                    onTap: _navigateToProcurement,
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  // ── Browse ────────────────────────────────
                  _sidebarLabel('BROWSE'),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.search,
                    label: 'Vendors',
                    color: AppTheme.textSecondary,
                    onTap: () => _showComingSoon('Vendor Search'),
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.doc_text_search,
                    label: 'GL Accounts',
                    color: AppTheme.textSecondary,
                    onTap: () => _showComingSoon('GL Browser'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sidebarLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(label,
          style: const TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: AppTheme.textSecondary,
            letterSpacing: 0.8,
          )),
    );
  }

  Widget _sidebarAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return _SidebarHoverItem(
      isPrimary: isPrimary,
      onTap: onTap,
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isPrimary
                ? Colors.white.withValues(alpha: 0.2)
                : color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon,
              size: 14,
              color: isPrimary ? Colors.white : color),
        ),
        const SizedBox(width: AppTheme.spacingS),
        Expanded(
          child: Text(label,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 13,
                fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
                color: isPrimary ? Colors.white : AppTheme.textPrimary,
              ),
              overflow: TextOverflow.ellipsis),
        ),
      ]),
    );
  }

  Widget _buildDesktopContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats row
        Container(
          color: AppTheme.surfaceWhite,
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: _buildDesktopStats(),
        ),
        const Divider(height: 1, color: AppTheme.dividerColor),

        // Two-column recent lists
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Recent Payment Authorities
              Expanded(child: _buildRecentPAPanel()),
              Container(width: 1, color: AppTheme.dividerColor),
              // Right: Recent TI Documents
              Expanded(child: _buildRecentTIPanel()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopStats() {
    return Consumer(
      builder: (context, ref, _) {
        final authoritiesAsync = ref.watch(recentAuthoritiesProvider);
        final tiDocsAsync = ref.watch(recentTIDocumentsProvider);

        final now = DateTime.now();

        int paTotal = 0, paMonth = 0;
        double paMonthAmt = 0;
        authoritiesAsync.whenData((list) {
          paTotal = list.length;
          final m = list.where((a) =>
              a.createdAt.year == now.year && a.createdAt.month == now.month);
          paMonth = m.length;
          paMonthAmt = m.fold(0.0, (s, a) => s + a.amount);
        });

        int tiTotal = 0, tiMonth = 0;
        tiDocsAsync.whenData((list) {
          tiTotal = list.length;
          tiMonth = list
              .where((d) =>
                  d.createdAt.year == now.year && d.createdAt.month == now.month)
              .length;
        });

        String fmtAmt(double v) {
          if (v >= 100000) return '₹${(v / 100000).toStringAsFixed(1)}L';
          if (v >= 1000) return '₹${(v / 1000).toStringAsFixed(1)}K';
          return '₹${v.toStringAsFixed(0)}';
        }

        return Row(children: [
          Expanded(
              child: _desktopStatTile(
                  icon: CupertinoIcons.doc_text_fill,
                  label: 'Payment Authorities',
                  value: paTotal.toString(),
                  sub: '$paMonth this month',
                  color: AppTheme.primaryBlue)),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
              child: _desktopStatTile(
                  icon: CupertinoIcons.money_dollar_circle_fill,
                  label: 'PA Amount (Month)',
                  value: fmtAmt(paMonthAmt),
                  sub: 'Total authorized',
                  color: AppTheme.successGreen)),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
              child: _desktopStatTile(
                  icon: CupertinoIcons.doc_richtext,
                  label: 'TI Documents',
                  value: tiTotal.toString(),
                  sub: '$tiMonth this month',
                  color: AppTheme.warningOrange)),
          const SizedBox(width: AppTheme.spacingM),
          // Quick action button
          _buildQuickCreateTile(),
        ]);
      },
    );
  }

  Widget _desktopStatTile({
    required IconData icon,
    required String label,
    required String value,
    required String sub,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Icon(icon, size: 22, color: color),
        ),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value,
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: color)),
            Text(label,
                style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary)),
            Text(sub, style: AppTheme.caption),
          ]),
        ),
      ]),
    );
  }

  Widget _buildQuickCreateTile() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _quickCreateBtn(
          icon: CupertinoIcons.add_circled_solid,
          label: 'New PA',
          color: AppTheme.primaryBlue,
          onTap: _navigateToCreateAuthority,
        ),
        const SizedBox(height: AppTheme.spacingS),
        _quickCreateBtn(
          icon: CupertinoIcons.doc_text_fill,
          label: 'New TI',
          color: AppTheme.warningOrange,
          onTap: _navigateToCreateTI,
        ),
      ],
    );
  }

  Widget _quickCreateBtn({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(label,
              style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
        ]),
      ),
    );
  }

  // ── Recent Payment Authorities panel ─────────────────────────

  Widget _buildRecentPAPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHeader(
          title: 'Recent Payment Authorities',
          icon: CupertinoIcons.doc_text_fill,
          color: AppTheme.primaryBlue,
          onNew: _navigateToCreateAuthority,
        ),
        // Table column headers
        Container(
          color: AppTheme.dividerColor.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM, vertical: 6),
          child: const Row(children: [
            Expanded(flex: 2, child: _ColHeader('Authority No.')),
            Expanded(flex: 3, child: _ColHeader('Vendor')),
            _ColHeader('Date', width: 90),
            _ColHeader('Amount', width: 90, right: true),
          ]),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ref, _) {
              final async = ref.watch(recentAuthoritiesProvider);
              return async.when(
                data: (list) => list.isEmpty
                    ? _emptyState('No payment authorities yet',
                        'Tap "New PA" to create one',
                        CupertinoIcons.doc_text)
                    : ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, color: AppTheme.dividerColor),
                        itemBuilder: (ctx, i) =>
                            _buildPARow(list[i], ref),
                      ),
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (e, _) =>
                    Center(child: Text('Error: $e', style: AppTheme.caption)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPARow(SavedAuthority authority, WidgetRef ref) {
    final df = DateFormat('dd MMM yy');
    return _HoverableRow(
      onTap: () => _handleAuthorityTap(authority, ref),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM, vertical: 11),
        child: Row(children: [
          Expanded(
            flex: 2,
            child: Row(children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(CupertinoIcons.doc_text_fill,
                    color: AppTheme.primaryBlue, size: 13),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(authority.authorityOrderNo,
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary),
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
          ),
          Expanded(
            flex: 3,
            child: Text(authority.vendorName,
                style: AppTheme.caption
                    .copyWith(color: AppTheme.textPrimary, fontSize: 13),
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: 90,
            child: Text(df.format(authority.createdAt),
                style: AppTheme.caption),
          ),
          SizedBox(
            width: 90,
            child: Text(
              '₹${NumberFormat.compact().format(authority.amount)}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.successGreen),
            ),
          ),
        ]),
      ),
    );
  }

  // ── Recent TI Documents panel ─────────────────────────────────

  Widget _buildRecentTIPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHeader(
          title: 'Recent TI Documents',
          icon: CupertinoIcons.doc_richtext,
          color: AppTheme.warningOrange,
          onNew: _navigateToCreateTI,
        ),
        // Table column headers
        Container(
          color: AppTheme.dividerColor.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM, vertical: 6),
          child: const Row(children: [
            Expanded(flex: 2, child: _ColHeader('OM Number')),
            Expanded(flex: 2, child: _ColHeader('Employee')),
            Expanded(flex: 2, child: _ColHeader('Division')),
            _ColHeader('Amount', width: 90, right: true),
          ]),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ref, _) {
              final async = ref.watch(recentTIDocumentsProvider);
              return async.when(
                data: (list) => list.isEmpty
                    ? _emptyState('No TI documents yet',
                        'Tap "New TI" to create one',
                        CupertinoIcons.doc_richtext)
                    : ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, color: AppTheme.dividerColor),
                        itemBuilder: (ctx, i) =>
                            _buildTIRow(list[i]),
                      ),
                loading: () =>
                    const Center(child: CupertinoActivityIndicator()),
                error: (e, _) =>
                    Center(child: Text('Error: $e', style: AppTheme.caption)),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTIRow(TIDocument doc) {
    return _HoverableRow(
      onTap: () => _navigateToCreateTI(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM, vertical: 11),
        child: Row(children: [
          Expanded(
            flex: 2,
            child: Row(children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppTheme.warningOrange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(CupertinoIcons.doc_richtext,
                    color: AppTheme.warningOrange, size: 13),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(doc.omNumber,
                    style: const TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary),
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
          ),
          Expanded(
            flex: 2,
            child: Text(doc.employeeName,
                style: AppTheme.caption
                    .copyWith(color: AppTheme.textPrimary, fontSize: 13),
                overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text(doc.divisionName,
                style: AppTheme.caption,
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: 90,
            child: Text(
              '₹${NumberFormat.compact().format(doc.amount)}',
              textAlign: TextAlign.right,
              style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.warningOrange),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _panelHeader({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onNew,
  }) {
    return Container(
      color: AppTheme.surfaceWhite,
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM, vertical: AppTheme.spacingM),
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6)),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: AppTheme.spacingS),
        Text(title,
            style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary)),
        const Spacer(),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onNew,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6)),
            child: Row(children: [
              Icon(CupertinoIcons.add, size: 12, color: color),
              const SizedBox(width: 4),
              Text('New',
                  style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: color)),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget _emptyState(String title, String sub, IconData icon) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: AppTheme.primaryBlue.withValues(alpha: 0.07),
              shape: BoxShape.circle),
          child:
              Icon(icon, color: AppTheme.primaryBlue, size: 28),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Text(title,
            style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary)),
        const SizedBox(height: 4),
        Text(sub, style: AppTheme.caption),
      ]),
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

  void _navigateToCreateTI() {
    ref.read(tiDocumentProvider.notifier).reset();
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => const CreateTIDocumentScreen()));
  }

  void _navigateToEmployees() {
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => const EmployeeManagementScreen()));
  }

  void _navigateToProcurement() {
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => const WorkflowDashboardScreen()));
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

// Sidebar item with hover highlight
class _SidebarHoverItem extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isPrimary;

  const _SidebarHoverItem({
    required this.child,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  State<_SidebarHoverItem> createState() => _SidebarHoverItemState();
}

class _SidebarHoverItemState extends State<_SidebarHoverItem> {
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: widget.isPrimary
                ? (_hovered
                    ? AppTheme.primaryBlue.withValues(alpha: 0.85)
                    : AppTheme.primaryBlue)
                : (_hovered
                    ? AppTheme.primaryBlue.withValues(alpha: 0.07)
                    : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// Column header for desktop table views
class _ColHeader extends StatelessWidget {
  final String text;
  final double? width;
  final bool right;

  const _ColHeader(this.text, {this.width, this.right = false});

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      textAlign: right ? TextAlign.right : TextAlign.left,
      style: const TextStyle(
        fontFamily: 'SF Pro Display',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: AppTheme.textSecondary,
        letterSpacing: 0.3,
      ),
    );
    if (width != null) return SizedBox(width: width, child: child);
    return child;
  }
}
