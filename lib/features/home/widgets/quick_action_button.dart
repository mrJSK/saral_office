// lib/features/home/widgets/quick_action_button.dart

import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_theme.dart';

class QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconColor;
  final VoidCallback onTap;
  final bool showBadge;
  final String? badgeText;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.onTap,
    this.showBadge = false,
    this.badgeText,
  });

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse();
        // Small delay for animation to complete
        Future.delayed(const Duration(milliseconds: 50), widget.onTap);
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: _isPressed
                ? AppTheme.dividerColor.withOpacity(0.5)
                : AppTheme.surfaceWhite,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: 14,
            ),
            child: Row(
              children: [
                // Icon Container with Badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.iconColor.withOpacity(0.15),
                            widget.iconColor.withOpacity(0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: widget.iconColor.withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: _isPressed
                            ? []
                            : [
                                BoxShadow(
                                  color: widget.iconColor.withOpacity(0.15),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: 26,
                      ),
                    ),

                    // Badge
                    if (widget.showBadge)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.errorRed,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppTheme.surfaceWhite,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.errorRed.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            widget.badgeText ?? '',
                            style: const TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.surfaceWhite,
                              height: 1,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(width: AppTheme.spacingM),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                          letterSpacing: -0.32,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.subtitle,
                        style: AppTheme.body2.copyWith(
                          fontSize: 13,
                          height: 1.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: AppTheme.spacingS),

                // Chevron
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  transform: Matrix4.translationValues(
                    _isPressed ? 2 : 0,
                    0,
                    0,
                  ),
                  child: Icon(
                    CupertinoIcons.chevron_right,
                    color: AppTheme.textSecondary,
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Alternative: Compact Quick Action Button
class CompactQuickActionButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;

  const CompactQuickActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<CompactQuickActionButton> createState() =>
      _CompactQuickActionButtonState();
}

class _CompactQuickActionButtonState extends State<CompactQuickActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _isPressed
              ? widget.iconColor.withOpacity(0.15)
              : widget.iconColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.iconColor.withOpacity(_isPressed ? 0.4 : 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, color: widget.iconColor, size: 20),
            const SizedBox(width: 8),
            Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: widget.iconColor,
                letterSpacing: -0.24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Grid Quick Action Button (for grid layout)
class GridQuickActionButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;

  const GridQuickActionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onTap,
  });

  @override
  State<GridQuickActionButton> createState() => _GridQuickActionButtonState();
}

class _GridQuickActionButtonState extends State<GridQuickActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: AppTheme.surfaceWhite,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: _isPressed
                ? widget.iconColor.withOpacity(0.3)
                : AppTheme.dividerColor,
            width: _isPressed ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: _isPressed
                  ? widget.iconColor.withOpacity(0.15)
                  : CupertinoColors.systemGrey.withValues(alpha: 0.08),
              blurRadius: _isPressed ? 12 : 8,
              offset: Offset(0, _isPressed ? 3 : 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.iconColor.withOpacity(0.15),
                    widget.iconColor.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(widget.icon, color: widget.iconColor, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
                letterSpacing: -0.24,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
