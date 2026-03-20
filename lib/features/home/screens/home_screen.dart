// lib/features/home/screens/home_screen.dart

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:saral_office/core/database/models/saved_authority.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/widgets/service_search_field.dart';
import '../../../core/widgets/material_search_field.dart';
import '../../payment_authority/screens/create_authority_screen.dart';
import '../../payment_authority/providers/payment_authority_provider.dart';
import '../../ti_document/screens/create_ti_document_screen.dart';
import '../../ti_document/providers/ti_document_provider.dart';
import '../../ti_document/models/ti_document.dart';
import '../../ti_document/widgets/recent_ti_documents_list.dart';
import '../../employee/screens/employee_management_screen.dart';
import '../../procurement/screens/workflow_dashboard_screen.dart';
import '../widgets/stats_card.dart';
import '../widgets/recent_authorities_list.dart';
import '../widgets/quick_action_button.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool get _isDesktop =>
      defaultTargetPlatform == TargetPlatform.windows ||
      defaultTargetPlatform == TargetPlatform.macOS ||
      defaultTargetPlatform == TargetPlatform.linux;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

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
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refreshData();
    }
  }

  void _refreshData() {
    ref.invalidate(recentAuthoritiesProvider);
    ref.invalidate(recentTIDocumentsProvider);
  }

  // ─────────────────────────────────────────────────────────────
  // ROOT BUILD
  // ─────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return _isDesktop ? _buildDesktopLayout() : _buildMobileLayout();
  }

  // ═════════════════════════════════════════════════════════════
  // DESKTOP LAYOUT
  // ═════════════════════════════════════════════════════════════

  Widget _buildDesktopLayout() {
    final isDark = ref.watch(isDarkProvider);
    final bg = isDark ? AppTheme.darkBackground : AppTheme.backgroundLight;
    final divCol = isDark ? AppTheme.darkDivider : AppTheme.dividerColor;
    return CupertinoPageScaffold(
      backgroundColor: bg,
      child: Column(
        children: [
          _buildDesktopTopBar(),
          Divider(height: 1, color: divCol),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildDesktopSidebar(),
                  Container(width: 1, color: divCol),
                  Expanded(child: _buildDesktopContent()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Top bar ───────────────────────────────────────────────────

  Widget _buildDesktopTopBar() {
    final isDark = ref.watch(isDarkProvider);
    final surface = isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
    final dateStr = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());

    return Container(
      height: 52,
      color: surface,
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
          Text(
            'SaralOffice',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: textCol,
            ),
          ),
          const SizedBox(width: AppTheme.spacingL),
          Text(dateStr,
              style: AppTheme.caption.copyWith(color: AppTheme.textSecondary)),
          const Spacer(),
          // Dark / Light toggle
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () =>
                ref.read(isDarkProvider.notifier).toggle(),
            child: Row(children: [
              Icon(
                isDark ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill,
                size: 16,
                color: isDark
                    ? AppTheme.warningOrange
                    : AppTheme.textSecondary,
              ),
              const SizedBox(width: 5),
              Text(
                isDark ? 'Light' : 'Dark',
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 13,
                    color: isDark
                        ? AppTheme.warningOrange
                        : AppTheme.textSecondary),
              ),
            ]),
          ),
          const SizedBox(width: AppTheme.spacingM),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () => _showSettingsSheet(context),
            child: Row(children: [
              Icon(CupertinoIcons.settings,
                  size: 16, color: AppTheme.textSecondary),
              const SizedBox(width: 5),
              const Text('Settings',
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

  // ── Left sidebar ──────────────────────────────────────────────

  Widget _buildDesktopSidebar() {
    final isDark = ref.watch(isDarkProvider);
    final surface = isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
    final divCol = isDark ? AppTheme.darkDivider : AppTheme.dividerColor;
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';

    return Container(
      width: 220,
      color: surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppTheme.spacingL, AppTheme.spacingL,
                AppTheme.spacingL, AppTheme.spacingM),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(greeting,
                    style: AppTheme.caption
                        .copyWith(color: AppTheme.textSecondary)),
                const SizedBox(height: 2),
                Text('Welcome back',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textCol,
                    )),
              ],
            ),
          ),
          Divider(height: 1, color: divCol),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingM, vertical: AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    onTap: _navigateToCreateTIDocument,
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  _sidebarLabel('MANAGE'),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.person_2_fill,
                    label: 'Employees',
                    color: AppTheme.warningOrange,
                    onTap: _navigateToEmployeeManagement,
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.cart_fill,
                    label: 'Procurement',
                    color: AppTheme.successGreen,
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                        builder: (_) => const WorkflowDashboardScreen())),
                  ),

                  const SizedBox(height: AppTheme.spacingL),

                  _sidebarLabel('BROWSE'),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.wrench_fill,
                    label: 'Services',
                    color: AppTheme.secondaryBlue,
                    onTap: _showServiceBrowser,
                  ),
                  const SizedBox(height: AppTheme.spacingS),
                  _sidebarAction(
                    icon: CupertinoIcons.cube_box_fill,
                    label: 'Materials',
                    color: AppTheme.textSecondary,
                    onTap: _showMaterialBrowser,
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
    final isDark = ref.watch(isDarkProvider);
    final labelColor = isPrimary
        ? Colors.white
        : (isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary);
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
          child: Icon(icon, size: 14,
              color: isPrimary ? Colors.white : color),
        ),
        const SizedBox(width: AppTheme.spacingS),
        Expanded(
          child: Text(label,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 13,
                fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w500,
                color: labelColor,
              ),
              overflow: TextOverflow.ellipsis),
        ),
      ]),
    );
  }

  // ── Main content area ─────────────────────────────────────────

  Widget _buildDesktopContent() {
    final isDark = ref.watch(isDarkProvider);
    final bg = isDark ? AppTheme.darkBackground : AppTheme.backgroundLight;
    final divCol = isDark ? AppTheme.darkDivider : AppTheme.dividerColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: bg,
          padding: const EdgeInsets.all(AppTheme.spacingL),
          child: _buildDesktopStats(),
        ),
        Divider(height: 1, color: divCol),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildRecentPAPanel()),
              Container(width: 1, color: divCol),
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
              child: _statTile(
                  icon: CupertinoIcons.doc_text_fill,
                  label: 'Payment Authorities',
                  value: paTotal.toString(),
                  sub: '$paMonth this month',
                  color: AppTheme.primaryBlue)),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
              child: _statTile(
                  icon: CupertinoIcons.money_dollar_circle_fill,
                  label: 'PA Amount (Month)',
                  value: fmtAmt(paMonthAmt),
                  sub: 'Total authorized',
                  color: AppTheme.successGreen)),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
              child: _statTile(
                  icon: CupertinoIcons.doc_richtext,
                  label: 'TI Documents',
                  value: tiTotal.toString(),
                  sub: '$tiMonth this month',
                  color: AppTheme.warningOrange)),
          const SizedBox(width: AppTheme.spacingM),
          _buildQuickCreateTile(),
        ]);
      },
    );
  }

  Widget _statTile({
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
                style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: CupertinoTheme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkTextPrimary
                        : AppTheme.textPrimary)),
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
        _quickBtn(
            icon: CupertinoIcons.add_circled_solid,
            label: 'New PA',
            color: AppTheme.primaryBlue,
            onTap: _navigateToCreateAuthority),
        const SizedBox(height: AppTheme.spacingS),
        _quickBtn(
            icon: CupertinoIcons.doc_text_fill,
            label: 'New TI',
            color: AppTheme.warningOrange,
            onTap: _navigateToCreateTIDocument),
      ],
    );
  }

  Widget _quickBtn({
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

  // ── Recent PA panel ───────────────────────────────────────────

  Widget _buildRecentPAPanel() {
    final isDark = ref.watch(isDarkProvider);
    final hdrBg = isDark
        ? AppTheme.darkDivider.withValues(alpha: 0.6)
        : AppTheme.dividerColor.withValues(alpha: 0.4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHeader(
          title: 'Recent Payment Authorities',
          icon: CupertinoIcons.doc_text_fill,
          color: AppTheme.primaryBlue,
          onNew: _navigateToCreateAuthority,
        ),
        Container(
          color: hdrBg,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM, vertical: 6),
          child: Row(children: [
            Expanded(flex: 2, child: _ColHeader('Authority No.')),
            Expanded(flex: 3, child: _ColHeader('Vendor')),
            _ColHeader('Date', width: 80),
            _ColHeader('Amount', width: 90, right: true),
            const SizedBox(width: 36),
          ]),
        ),
        Expanded(
          child: Consumer(
            builder: (context, ref, _) {
              final async = ref.watch(recentAuthoritiesProvider);
              return async.when(
                data: (list) => list.isEmpty
                    ? _emptyState('No payment authorities yet',
                        'Click "New PA" to create one',
                        CupertinoIcons.doc_text)
                    : ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, color: AppTheme.dividerColor),
                        itemBuilder: (ctx, i) => _buildPARow(list[i], ref),
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
                    style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CupertinoTheme.of(context).brightness == Brightness.dark
                            ? AppTheme.darkTextPrimary
                            : AppTheme.textPrimary),
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
          ),
          Expanded(
            flex: 3,
            child: Text(authority.vendorName,
                style: AppTheme.caption.copyWith(
                    color: CupertinoTheme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.textPrimary,
                    fontSize: 13),
                overflow: TextOverflow.ellipsis),
          ),
          SizedBox(
            width: 80,
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
          SizedBox(
            width: 36,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: const Size(28, 28),
              onPressed: () => _confirmDeleteAuthority(authority, ref),
              child: const Icon(CupertinoIcons.trash,
                  size: 15, color: AppTheme.errorRed),
            ),
          ),
        ]),
      ),
    );
  }

  Future<void> _confirmDeleteAuthority(
      SavedAuthority authority, WidgetRef ref) async {
    final confirmed = await showCupertinoDialog<bool>(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('Delete Authority'),
        content: Text(
            'Delete "${authority.authorityOrderNo}"?\nThe associated PDF file will also be removed.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(ctx, false),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: const Text('Delete'),
            onPressed: () => Navigator.pop(ctx, true),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    // Delete PDF from Downloads if it exists
    if (authority.billNo.isNotEmpty) {
      String sanitize(String s) => s
          .replaceAll(RegExp(r'[^\w\s-]'), '')
          .replaceAll(RegExp(r'\s+'), '_')
          .replaceAll(RegExp(r'_+'), '_')
          .trim();
      final filename =
          '${sanitize(authority.vendorName)}_${sanitize(authority.billNo)}.pdf';
      final dir = (await getDownloadsDirectory()) ??
          await getApplicationDocumentsDirectory();
      final pdfFile = File(p.join(dir.path, filename));
      if (await pdfFile.exists()) await pdfFile.delete();
    }

    // Delete from Isar
    final isar = ref.read(isarServiceProvider);
    await isar.deleteAuthorities([authority.id]);
  }

  // ── Recent TI panel ───────────────────────────────────────────

  Widget _buildRecentTIPanel() {
    final isDark = ref.watch(isDarkProvider);
    final hdrBg = isDark
        ? AppTheme.darkDivider.withValues(alpha: 0.6)
        : AppTheme.dividerColor.withValues(alpha: 0.4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _panelHeader(
          title: 'Recent TI Documents',
          icon: CupertinoIcons.doc_richtext,
          color: AppTheme.warningOrange,
          onNew: _navigateToCreateTIDocument,
        ),
        Container(
          color: hdrBg,
          padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM, vertical: 6),
          child: Row(children: [
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
                        'Click "New TI" to create one',
                        CupertinoIcons.doc_richtext)
                    : ListView.separated(
                        itemCount: list.length,
                        separatorBuilder: (_, _) =>
                            const Divider(height: 1, color: AppTheme.dividerColor),
                        itemBuilder: (ctx, i) => _buildTIRow(list[i]),
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
      onTap: _navigateToCreateTIDocument,
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
                    style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: CupertinoTheme.of(context).brightness == Brightness.dark
                            ? AppTheme.darkTextPrimary
                            : AppTheme.textPrimary),
                    overflow: TextOverflow.ellipsis),
              ),
            ]),
          ),
          Expanded(
            flex: 2,
            child: Text(doc.employeeName,
                style: AppTheme.caption.copyWith(
                    color: CupertinoTheme.of(context).brightness == Brightness.dark
                        ? AppTheme.darkTextSecondary
                        : AppTheme.textPrimary,
                    fontSize: 13),
                overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 2,
            child: Text(doc.divisionName,
                style: AppTheme.caption, overflow: TextOverflow.ellipsis),
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

  // ── Shared desktop widgets ────────────────────────────────────

  Widget _panelHeader({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onNew,
  }) {
    final isDark = ref.watch(isDarkProvider);
    final surface = isDark ? AppTheme.darkSurface : AppTheme.surfaceWhite;
    final textCol = isDark ? AppTheme.darkTextPrimary : AppTheme.textPrimary;
    return Container(
      color: surface,
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
            style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textCol)),
        const Spacer(),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onNew,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          child: Icon(icon, color: AppTheme.primaryBlue, size: 28),
        ),
        const SizedBox(height: AppTheme.spacingM),
        Text(title,
            style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: CupertinoTheme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkTextPrimary
                    : AppTheme.textPrimary)),
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

  // ═════════════════════════════════════════════════════════════
  // MOBILE LAYOUT (unchanged)
  // ═════════════════════════════════════════════════════════════

  Widget _buildMobileLayout() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: AppTheme.surfaceWhite,
        activeColor: AppTheme.primaryBlue,
        inactiveColor: AppTheme.textSecondary,
        border: const Border(
          top: BorderSide(color: AppTheme.dividerColor, width: 0.5),
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            activeIcon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.doc_text),
            activeIcon: Icon(CupertinoIcons.doc_text_fill),
            label: 'Procurement',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return _buildHomeTab();
          case 1:
            return const WorkflowDashboardScreen();
          case 2:
            return _buildProfileTab();
          default:
            return _buildHomeTab();
        }
      },
    );
  }

  Widget _buildHomeTab() {
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
                      _buildRecentAuthoritiesSection(),
                      const SizedBox(height: AppTheme.spacingXL),
                      _buildRecentTIDocumentsSection(),
                      const SizedBox(height: AppTheme.spacingXL),
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

  Widget _buildProfileTab() {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppTheme.surfaceWhite,
        border: null,
        middle: Text('Profile'),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          children: [
            const SizedBox(height: AppTheme.spacingL),
            const Center(
              child: Icon(CupertinoIcons.person_circle_fill,
                  size: 100, color: AppTheme.primaryBlue),
            ),
            const SizedBox(height: AppTheme.spacingM),
            const Center(
              child: Text('User Profile',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  )),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            _buildProfileOption(
              icon: CupertinoIcons.person_2_fill,
              title: 'Manage Employees',
              color: AppTheme.warningOrange,
              onTap: _navigateToEmployeeManagement,
            ),
            const Divider(height: 1, color: AppTheme.dividerColor),
            _buildProfileOption(
              icon: CupertinoIcons.wrench_fill,
              title: 'Browse Services',
              color: AppTheme.successGreen,
              onTap: _showServiceBrowser,
            ),
            const Divider(height: 1, color: AppTheme.dividerColor),
            _buildProfileOption(
              icon: CupertinoIcons.cube_box_fill,
              title: 'Browse Materials',
              color: AppTheme.warningOrange,
              onTap: _showMaterialBrowser,
            ),
            const Divider(height: 1, color: AppTheme.dividerColor),
            _buildProfileOption(
              icon: CupertinoIcons.settings,
              title: 'Settings',
              color: AppTheme.textSecondary,
              onTap: () => _showSettingsSheet(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingM,
        ),
        decoration: const BoxDecoration(color: AppTheme.surfaceWhite),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  )),
            ),
            const Icon(CupertinoIcons.chevron_right,
                color: AppTheme.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final hour = DateTime.now().hour;
    final greeting = hour < 12
        ? 'Good Morning'
        : hour < 17
            ? 'Good Afternoon'
            : 'Good Evening';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting,
            style: AppTheme.headline3.copyWith(color: AppTheme.textSecondary)),
        const SizedBox(height: 4),
        Text('Ready to create documents?', style: AppTheme.body2),
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
            onTap: _navigateToCreateAuthority,
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.doc_append,
            title: 'Create TI Document',
            subtitle: 'Generate transfer information PDFs',
            iconColor: AppTheme.successGreen,
            onTap: _navigateToCreateTIDocument,
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.person_2_fill,
            title: 'Manage Employees',
            subtitle: 'Add or edit employee information',
            iconColor: AppTheme.warningOrange,
            onTap: _navigateToEmployeeManagement,
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.wrench_fill,
            title: 'Browse Services',
            subtitle: 'Search service master database',
            iconColor: AppTheme.successGreen,
            onTap: _showServiceBrowser,
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.cube_box_fill,
            title: 'Browse Materials',
            subtitle: 'Search material master database',
            iconColor: AppTheme.warningOrange,
            onTap: _showMaterialBrowser,
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
                return Row(children: [
                  Expanded(
                      child: StatsCard(
                          icon: CupertinoIcons.doc_text_fill,
                          title: 'Total',
                          value: totalCount.toString(),
                          color: AppTheme.primaryBlue)),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                      child: StatsCard(
                          icon: CupertinoIcons.calendar,
                          title: 'This Month',
                          value: thisMonthCount.toString(),
                          color: AppTheme.successGreen)),
                  const SizedBox(width: AppTheme.spacingM),
                  Expanded(
                      child: StatsCard(
                          icon: CupertinoIcons.money_dollar_circle_fill,
                          title: 'Amount',
                          value: formattedAmount,
                          color: AppTheme.warningOrange)),
                ]);
              },
              loading: () => Row(children: [
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
              ]),
              error: (_, _) => Row(children: [
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
              ]),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecentAuthoritiesSection() => const RecentAuthoritiesList();
  Widget _buildRecentTIDocumentsSection() => const RecentTIDocumentsList();

  // ─────────────────────────────────────────────────────────────
  // SHARED: Navigation & Dialogs
  // ─────────────────────────────────────────────────────────────

  void _navigateToCreateAuthority() async {
    ref.read(paymentAuthorityProvider.notifier).reset();
    await Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => const CreateAuthorityScreen()));
    _refreshData();
  }

  void _navigateToCreateTIDocument() async {
    ref.read(tiDocumentProvider.notifier).reset();
    await Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => const CreateTIDocumentScreen()));
    _refreshData();
  }

  void _navigateToEmployeeManagement() {
    Navigator.of(context).push(
        CupertinoPageRoute(builder: (_) => const EmployeeManagementScreen()));
  }

  void _showServiceBrowser() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ServicePickerScreen(
          onSelected: (service) => _showServiceDetails(context, service),
        ),
      ),
    );
  }

  void _showMaterialBrowser() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MaterialPickerScreen(
          onSelected: (material) => _showMaterialDetails(context, material),
        ),
      ),
    );
  }

  void _showServiceDetails(BuildContext context, service) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).brightness == Brightness.dark
              ? AppTheme.darkSurface
              : AppTheme.surfaceWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: CupertinoTheme.of(context).brightness == Brightness.dark
                              ? AppTheme.darkDivider
                              : AppTheme.dividerColor))),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.wrench_fill,
                      color: AppTheme.successGreen),
                  const SizedBox(width: 8),
                  const Expanded(
                      child: Text('Service Details',
                          style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              fontWeight: FontWeight.w600))),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(CupertinoIcons.xmark_circle_fill),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Activity Number', service.activityNumber),
                    _buildDetailRow('Short Text', service.serviceShortText),
                    _buildDetailRow('Long Text', service.serviceLongText),
                    _buildDetailRow('Material Group', service.materialGroupDesc),
                    _buildDetailRow(
                        'Service Category', service.serviceCategoryDesc),
                    _buildDetailRow('Base Unit', service.baseUnit),
                    if (service.glAccount != null)
                      _buildDetailRow('GL Account', service.glAccount!),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMaterialDetails(BuildContext context, material) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: CupertinoTheme.of(context).brightness == Brightness.dark
              ? AppTheme.darkSurface
              : AppTheme.surfaceWhite,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: CupertinoTheme.of(context).brightness == Brightness.dark
                              ? AppTheme.darkDivider
                              : AppTheme.dividerColor))),
              child: Row(
                children: [
                  const Icon(CupertinoIcons.cube_box_fill,
                      color: AppTheme.warningOrange),
                  const SizedBox(width: 8),
                  const Expanded(
                      child: Text('Material Details',
                          style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              fontWeight: FontWeight.w600))),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(CupertinoIcons.xmark_circle_fill),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Material Code', material.material),
                    _buildDetailRow('Description', material.materialDesc),
                    _buildDetailRow('Material Type', material.materialType),
                    _buildDetailRow('Plant', material.plant),
                    _buildDetailRow(
                        'Material Group', material.materialGroupDesc),
                    _buildDetailRow('Sub Group', material.subGroupDesc),
                    _buildDetailRow('Base Unit', material.baseUnitOfMeasure),
                    _buildDetailRow(
                        'Serial Number Status', material.serialNumberStatus),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTheme.caption
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: CupertinoTheme.of(context).brightness == Brightness.dark
                    ? AppTheme.darkTextPrimary
                    : AppTheme.textPrimary,
              )),
        ],
      ),
    );
  }

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
              _navigateToEmployeeManagement();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.person_2_fill,
                    color: AppTheme.primaryBlue, size: 20),
                SizedBox(width: 8),
                Text('Manage Employees'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _showServiceBrowser();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.wrench_fill,
                    color: AppTheme.successGreen, size: 20),
                SizedBox(width: 8),
                Text('Browse Services'),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _showMaterialBrowser();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.cube_box_fill,
                    color: AppTheme.warningOrange, size: 20),
                SizedBox(width: 8),
                Text('Browse Materials'),
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

// ── Sidebar hover item ────────────────────────────────────────

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
    final isDark =
        CupertinoTheme.of(context).brightness == Brightness.dark;
    final hoverBg = isDark
        ? AppTheme.darkDivider.withValues(alpha: 0.8)
        : AppTheme.primaryBlue.withValues(alpha: 0.07);

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
                : (_hovered ? hoverBg : Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// ── Table column header ───────────────────────────────────────

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

// ── Hoverable row for desktop tables ─────────────────────────

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
    final isDark =
        CupertinoTheme.of(context).brightness == Brightness.dark;
    final hoverBg = isDark
        ? AppTheme.darkDivider.withValues(alpha: 0.5)
        : AppTheme.primaryBlue.withValues(alpha: 0.04);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          color: _hovered ? hoverBg : Colors.transparent,
          child: widget.child,
        ),
      ),
    );
  }
}
