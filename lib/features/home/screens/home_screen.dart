// lib/features/home/screens/home_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/service_search_field.dart';
import '../../../core/widgets/material_search_field.dart';
import '../../payment_authority/screens/create_authority_screen.dart';
import '../../payment_authority/providers/payment_authority_provider.dart';
import '../../ti_document/screens/create_ti_document_screen.dart';
import '../../ti_document/providers/ti_document_provider.dart';
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
  int _currentTab = 0;

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

  @override
  Widget build(BuildContext context) {
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
              child: Icon(
                CupertinoIcons.person_circle_fill,
                size: 100,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            const Center(
              child: Text(
                'User Profile',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            const Icon(
              CupertinoIcons.chevron_right,
              color: AppTheme.textSecondary,
              size: 20,
            ),
          ],
        ),
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
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.person_2_fill,
            title: 'Manage Employees',
            subtitle: 'Add or edit employee information',
            iconColor: AppTheme.warningOrange,
            onTap: () => _navigateToEmployeeManagement(),
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.wrench_fill,
            title: 'Browse Services',
            subtitle: 'Search service master database',
            iconColor: AppTheme.successGreen,
            onTap: () => _showServiceBrowser(),
          ),
          const Divider(height: 1, color: AppTheme.dividerColor),
          QuickActionButton(
            icon: CupertinoIcons.cube_box_fill,
            title: 'Browse Materials',
            subtitle: 'Search material master database',
            iconColor: AppTheme.warningOrange,
            onTap: () => _showMaterialBrowser(),
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

  Widget _buildRecentAuthoritiesSection() {
    return const RecentAuthoritiesList();
  }

  Widget _buildRecentTIDocumentsSection() {
    return const RecentTIDocumentsList();
  }

  void _navigateToCreateAuthority() async {
    ref.read(paymentAuthorityProvider.notifier).reset();
    await Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (_) => const CreateAuthorityScreen()));
    _refreshData();
  }

  void _navigateToCreateTIDocument() async {
    ref.read(tiDocumentProvider.notifier).reset();
    await Navigator.of(
      context,
    ).push(CupertinoPageRoute(builder: (_) => const CreateTIDocumentScreen()));
    _refreshData();
  }

  void _navigateToEmployeeManagement() {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (_) => const EmployeeManagementScreen()),
    );
  }

  void _showServiceBrowser() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ServicePickerScreen(
          onSelected: (service) {
            _showServiceDetails(context, service);
          },
        ),
      ),
    );
  }

  void _showMaterialBrowser() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => MaterialPickerScreen(
          onSelected: (material) {
            _showMaterialDetails(context, material);
          },
        ),
      ),
    );
  }

  void _showServiceDetails(BuildContext context, service) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.wrench_fill,
                    color: AppTheme.successGreen,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Service Details',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
                    _buildDetailRow(
                      'Material Group',
                      service.materialGroupDesc,
                    ),
                    _buildDetailRow(
                      'Service Category',
                      service.serviceCategoryDesc,
                    ),
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
        decoration: const BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.dividerColor),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.cube_box_fill,
                    color: AppTheme.warningOrange,
                  ),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Material Details',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
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
                      'Material Group',
                      material.materialGroupDesc,
                    ),
                    _buildDetailRow('Sub Group', material.subGroupDesc),
                    _buildDetailRow('Base Unit', material.baseUnitOfMeasure),
                    _buildDetailRow(
                      'Serial Number Status',
                      material.serialNumberStatus,
                    ),
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
          Text(
            label,
            style: AppTheme.caption.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppTheme.textPrimary,
            ),
          ),
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
                Icon(
                  CupertinoIcons.person_2_fill,
                  color: AppTheme.primaryBlue,
                  size: 20,
                ),
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
                Icon(
                  CupertinoIcons.wrench_fill,
                  color: AppTheme.successGreen,
                  size: 20,
                ),
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
                Icon(
                  CupertinoIcons.cube_box_fill,
                  color: AppTheme.warningOrange,
                  size: 20,
                ),
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
