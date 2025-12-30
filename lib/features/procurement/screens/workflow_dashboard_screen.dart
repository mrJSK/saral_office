// lib/features/procurement/screens/workflow_dashboard_screen.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/di/injection.dart' hide prServiceProvider;
import '../models/purchase_requisition.dart';
import 'pr_creation_screen.dart';
import 'pr_line_items_screen.dart';

class WorkflowDashboardScreen extends ConsumerStatefulWidget {
  const WorkflowDashboardScreen({super.key});

  @override
  ConsumerState<WorkflowDashboardScreen> createState() =>
      _WorkflowDashboardScreenState();
}

class _WorkflowDashboardScreenState
    extends ConsumerState<WorkflowDashboardScreen> {
  List<PurchaseRequisition> _allPRs = [];
  List<PurchaseRequisition> _filteredPRs = [];
  WorkflowStage? _selectedStage;
  bool _isLoading = true;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPRs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadPRs() async {
    final prService = ref.read(prServiceProvider);
    final prs = await prService.getAllPRs();

    setState(() {
      _allPRs = prs;
      _filteredPRs = prs;
      _isLoading = false;
    });
  }

  void _filterPRs() {
    setState(() {
      _filteredPRs = _allPRs.where((pr) {
        final matchesSearch =
            _searchController.text.isEmpty ||
            pr.prNumber.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            ) ||
            pr.documentType.toLowerCase().contains(
              _searchController.text.toLowerCase(),
            );

        final matchesStage =
            _selectedStage == null || pr.currentStage == _selectedStage;

        return matchesSearch && matchesStage;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppTheme.surfaceWhite.withOpacity(0.9),
        border: null,
        middle: const Text('Procurement Workflow'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => const PRCreationScreen(),
              ),
            ).then((_) => _loadPRs());
          },
          child: const Icon(CupertinoIcons.add_circled),
        ),
      ),
      child: _isLoading
          ? const Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: Column(
                children: [
                  _buildSearchAndFilter(),
                  _buildStageFilter(),
                  Expanded(
                    child: _filteredPRs.isEmpty
                        ? _buildEmptyState()
                        : _buildPRList(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      color: AppTheme.surfaceWhite,
      child: CupertinoSearchTextField(
        controller: _searchController,
        placeholder: 'Search PR number or type...',
        onChanged: (_) => _filterPRs(),
        style: AppTheme.body1,
      ),
    );
  }

  Widget _buildStageFilter() {
    return Container(
      height: 50,
      color: AppTheme.surfaceWhite,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
        children: [
          _buildFilterChip('All', null),
          const SizedBox(width: 8),
          _buildFilterChip('PR Creation', WorkflowStage.prCreation),
          const SizedBox(width: 8),
          _buildFilterChip('RFQ', WorkflowStage.rfqParentCreation),
          const SizedBox(width: 8),
          _buildFilterChip('Contract', WorkflowStage.contractCreation),
          const SizedBox(width: 8),
          _buildFilterChip('Completed', WorkflowStage.completed),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, WorkflowStage? stage) {
    final isSelected = _selectedStage == stage;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStage = stage;
        });
        _filterPRs();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryBlue : AppTheme.backgroundLight,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : AppTheme.dividerColor,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? AppTheme.surfaceWhite : AppTheme.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.doc_text,
            size: 64,
            color: AppTheme.textSecondary.withOpacity(0.3),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            _searchController.text.isEmpty
                ? 'No purchase requisitions yet'
                : 'No results found',
            style: AppTheme.body1.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            _searchController.text.isEmpty
                ? 'Create your first PR to get started'
                : 'Try a different search term',
            style: AppTheme.caption.copyWith(color: AppTheme.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPRList() {
    return ListView.separated(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: _filteredPRs.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spacingM),
      itemBuilder: (context, index) {
        final pr = _filteredPRs[index];
        return _buildPRCard(pr);
      },
    );
  }

  Widget _buildPRCard(PurchaseRequisition pr) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => PRLineItemsScreen(prNumber: pr.prNumber),
          ),
        ).then((_) => _loadPRs());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: _getStageColor(pr.currentStage).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: _getStageColor(pr.currentStage).withOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radiusMedium - 1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pr.displayNumber,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pr.documentTypeDescription,
                          style: const TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusBadge(pr.status),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWorkflowProgress(pr.currentStage),
                  const SizedBox(height: AppTheme.spacingM),
                  Row(
                    children: [
                      const Icon(
                        CupertinoIcons.calendar,
                        size: 14,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _formatDate(pr.createdAt!),
                        style: AppTheme.caption.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      if (pr.isExported)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.successGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                CupertinoIcons.checkmark_circle_fill,
                                size: 12,
                                color: AppTheme.successGreen,
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Exported',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.successGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(PRStatus status) {
    Color color;
    IconData icon;

    switch (status) {
      case PRStatus.draft:
        color = AppTheme.textSecondary;
        icon = CupertinoIcons.pencil;
        break;
      case PRStatus.approved:
        color = AppTheme.successGreen;
        icon = CupertinoIcons.checkmark_circle_fill;
        break;
      case PRStatus.rejected:
        color = AppTheme.errorRed;
        icon = CupertinoIcons.xmark_circle_fill;
        break;
      case PRStatus.completed:
        color = AppTheme.primaryBlue;
        icon = CupertinoIcons.checkmark_alt_circle_fill;
        break;
      default:
        color = AppTheme.warningOrange;
        icon = CupertinoIcons.clock;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            _getStatusText(status),
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkflowProgress(WorkflowStage stage) {
    final stages = [
      WorkflowStage.prCreation,
      WorkflowStage.rfqParentCreation,
      WorkflowStage.contractCreation,
      WorkflowStage.deliveryInspection,
      WorkflowStage.completed,
    ];

    final currentIndex = stages.indexOf(stage);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              CupertinoIcons.arrow_branch,
              size: 14,
              color: AppTheme.primaryBlue,
            ),
            const SizedBox(width: 6),
            Text(
              _getStageText(stage),
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _getStageColor(stage),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(stages.length, (index) {
            final isCompleted = index <= currentIndex;
            return Expanded(
              child: Container(
                height: 4,
                margin: EdgeInsets.only(
                  right: index < stages.length - 1 ? 4 : 0,
                ),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? _getStageColor(stage)
                      : AppTheme.dividerColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Color _getStageColor(WorkflowStage stage) {
    switch (stage) {
      case WorkflowStage.prCreation:
        return AppTheme.primaryBlue;
      case WorkflowStage.rfqParentCreation:
      case WorkflowStage.rfqChildCreation:
        return AppTheme.warningOrange;
      case WorkflowStage.contractCreation:
        return const Color(0xFF9C27B0); // Purple
      case WorkflowStage.deliveryInspection:
        return const Color(0xFF00BCD4); // Cyan
      case WorkflowStage.completed:
        return AppTheme.successGreen;
      default:
        return AppTheme.textSecondary;
    }
  }

  String _getStageText(WorkflowStage stage) {
    switch (stage) {
      case WorkflowStage.prCreation:
        return 'PR Creation';
      case WorkflowStage.prApproval:
        return 'PR Approval';
      case WorkflowStage.rfqParentCreation:
        return 'RFQ Parent';
      case WorkflowStage.rfqChildCreation:
        return 'RFQ Child';
      case WorkflowStage.quotationEntry:
        return 'Quotation Entry';
      case WorkflowStage.comparativeStatement:
        return 'Comparative Statement';
      case WorkflowStage.contractCreation:
        return 'Contract';
      case WorkflowStage.deliveryInspection:
        return 'Delivery & Inspection';
      case WorkflowStage.completed:
        return 'Completed';
      default:
        return stage.name;
    }
  }

  String _getStatusText(PRStatus status) {
    switch (status) {
      case PRStatus.draft:
        return 'DRAFT';
      case PRStatus.submitted:
        return 'SUBMITTED';
      case PRStatus.pendingApproval:
        return 'PENDING';
      case PRStatus.approved:
        return 'APPROVED';
      case PRStatus.rejected:
        return 'REJECTED';
      case PRStatus.rfqCreated:
        return 'RFQ CREATED';
      case PRStatus.contractCreated:
        return 'CONTRACT';
      case PRStatus.completed:
        return 'COMPLETED';
      case PRStatus.cancelled:
        return 'CANCELLED';
      default:
        return status.name.toUpperCase();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}
