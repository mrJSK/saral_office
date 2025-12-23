// lib/features/home/widgets/recent_authorities_list.dart

import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class RecentAuthoritiesList extends StatelessWidget {
  const RecentAuthoritiesList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual data from Isar database
    final hasData = false;

    if (!hasData) {
      return _buildEmptyState();
    }

    return _buildAuthoritiesList();
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingXL),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppTheme.dividerColor, width: 1),
      ),
      child: Column(
        children: [
          // Icon with gradient background
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

          // Create button
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            color: AppTheme.primaryBlue,
            borderRadius: BorderRadius.circular(10),
            onPressed: () {
              // TODO: Navigate to create authority
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

  Widget _buildAuthoritiesList() {
    // Sample data - replace with actual database query
    final authorities = [
      AuthorityItem(
        id: 'PA-2025-1234',
        vendorName: 'M/S ABB India Limited',
        amount: 31451.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        status: AuthorityStatus.completed,
      ),
      AuthorityItem(
        id: 'PA-2025-1235',
        vendorName: 'DREAMZ ENTERPRISES',
        amount: 45200.00,
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: AuthorityStatus.pending,
      ),
      AuthorityItem(
        id: 'PA-2025-1236',
        vendorName: 'V.K. ENTERPRISES',
        amount: 28900.00,
        date: DateTime.now().subtract(const Duration(days: 5)),
        status: AuthorityStatus.completed,
      ),
    ];

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: authorities.length,
          separatorBuilder: (_, __) =>
              const SizedBox(height: AppTheme.spacingM),
          itemBuilder: (context, index) {
            return AuthorityCard(authority: authorities[index]);
          },
        ),
      ],
    );
  }
}

// Authority Item Model
class AuthorityItem {
  final String id;
  final String vendorName;
  final double amount;
  final DateTime date;
  final AuthorityStatus status;

  AuthorityItem({
    required this.id,
    required this.vendorName,
    required this.amount,
    required this.date,
    required this.status,
  });
}

enum AuthorityStatus { completed, pending, draft }

// Authority Card Widget
class AuthorityCard extends StatefulWidget {
  final AuthorityItem authority;

  const AuthorityCard({super.key, required this.authority});

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
        _onTap(context);
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
              color: CupertinoColors.systemGrey.withValues(
                alpha: _isPressed ? 0.15 : 0.08,
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
              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _getStatusColor().withOpacity(0.15),
                      _getStatusColor().withOpacity(0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _getStatusColor().withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Icon(
                  CupertinoIcons.doc_text_fill,
                  color: _getStatusColor(),
                  size: 22,
                ),
              ),

              const SizedBox(width: AppTheme.spacingM),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Authority ID with Status Badge
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.authority.id,
                            style: const TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ),
                        _buildStatusBadge(),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Vendor Name
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

                    // Date and Time
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.calendar,
                          size: 12,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dateFormat.format(widget.authority.date),
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
                          timeFormat.format(widget.authority.date),
                          style: AppTheme.caption.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppTheme.spacingM),

              // Amount and Arrow
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${_formatAmount(widget.authority.amount)}',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: _getStatusColor(),
                      letterSpacing: -0.41,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
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

  Widget _buildStatusBadge() {
    String statusText;
    Color statusColor;

    switch (widget.authority.status) {
      case AuthorityStatus.completed:
        statusText = 'Completed';
        statusColor = AppTheme.successGreen;
        break;
      case AuthorityStatus.pending:
        statusText = 'Pending';
        statusColor = AppTheme.warningOrange;
        break;
      case AuthorityStatus.draft:
        statusText = 'Draft';
        statusColor = AppTheme.textSecondary;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: statusColor.withOpacity(0.3), width: 1),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          fontFamily: 'SF Pro Display',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: statusColor,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Color _getStatusColor() {
    switch (widget.authority.status) {
      case AuthorityStatus.completed:
        return AppTheme.successGreen;
      case AuthorityStatus.pending:
        return AppTheme.warningOrange;
      case AuthorityStatus.draft:
        return AppTheme.textSecondary;
    }
  }

  String _formatAmount(double amount) {
    if (amount >= 100000) {
      return '${(amount / 100000).toStringAsFixed(2)}L';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(2)}K';
    }
    return amount.toStringAsFixed(2);
  }

  void _onTap(BuildContext context) {
    // TODO: Navigate to authority detail screen
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(widget.authority.id),
        content: const Text('Authority details coming soon!'),
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
