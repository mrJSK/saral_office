// lib/features/ti_document/widgets/ti_document_card.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ti_document.dart';
import '../../../core/theme/app_theme.dart';

class TIDocumentCard extends StatefulWidget {
  final TIDocument document;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool isSelectionMode;
  final bool isSelected;

  const TIDocumentCard({
    super.key,
    required this.document,
    required this.onTap,
    this.onLongPress,
    this.isSelectionMode = false,
    this.isSelected = false,
  });

  @override
  State<TIDocumentCard> createState() => _TIDocumentCardState();
}

class _TIDocumentCardState extends State<TIDocumentCard> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) => setState(() => isPressed = false),
      onTapCancel: () => setState(() => isPressed = false),
      onTap: widget.onTap,
      onLongPress: () {
        setState(() => isPressed = false);
        widget.onLongPress?.call();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
        decoration: BoxDecoration(
          color: widget.isSelected && widget.isSelectionMode
              ? AppTheme.successGreen.withOpacity(0.08)
              : AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: widget.isSelected && widget.isSelectionMode
                ? AppTheme.successGreen
                : isPressed
                ? AppTheme.successGreen.withOpacity(0.3)
                : AppTheme.dividerColor,
            width: widget.isSelected || isPressed ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey.withOpacity(
                isPressed ? 0.15 : 0.08,
              ),
              blurRadius: isPressed ? 12 : 8,
              offset: Offset(0, isPressed ? 3 : 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Row(
            children: [
              // Selection indicator
              if (widget.isSelectionMode)
                Padding(
                  padding: const EdgeInsets.only(right: AppTheme.spacingM),
                  child: Icon(
                    widget.isSelected
                        ? CupertinoIcons.check_mark_circled_solid
                        : CupertinoIcons.circle,
                    color: widget.isSelected
                        ? AppTheme.successGreen
                        : AppTheme.textSecondary,
                    size: 24,
                  ),
                ),

              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.successGreen.withOpacity(0.15),
                      AppTheme.successGreen.withOpacity(0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.successGreen.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.doc_text_fill,
                  color: AppTheme.successGreen,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OM ${widget.document.omNumber}',
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
                      widget.document.employeeName,
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
                        const Icon(
                          CupertinoIcons.calendar,
                          size: 12,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dateFormat.format(widget.document.createdAt),
                          style: AppTheme.caption.copyWith(fontSize: 11),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          CupertinoIcons.time,
                          size: 12,
                          color: AppTheme.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          timeFormat.format(widget.document.createdAt),
                          style: AppTheme.caption.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacingM),

              // Amount & Chevron
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₹${_formatAmount(widget.document.amount)}',
                    style: const TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.successGreen,
                      letterSpacing: -0.41,
                    ),
                  ),
                  if (!widget.isSelectionMode) ...[
                    const SizedBox(height: 8),
                    const Icon(
                      CupertinoIcons.chevron_right,
                      color: AppTheme.textSecondary,
                      size: 16,
                    ),
                  ],
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
