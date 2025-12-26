// lib/features/payment_authority/widgets/ios_text_field.dart

import 'package:flutter/cupertino.dart';
import '../../../core/theme/app_theme.dart';

class IOSTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String placeholder;
  final TextInputType keyboardType;
  final int maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final Color? fillColor;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;
  final bool enabled;

  const IOSTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.fillColor,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.caption.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 6),
        CupertinoTextField(
          controller: controller,
          placeholder: placeholder,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textCapitalization: textCapitalization,
          onChanged: onChanged,
          enabled: enabled,
          prefix: prefix != null
              ? Padding(padding: const EdgeInsets.only(left: 12), child: prefix)
              : null,
          suffix: suffix != null
              ? Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: suffix,
                )
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: enabled
                ? (fillColor ?? AppTheme.backgroundLight)
                : AppTheme.backgroundLight.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: enabled
                  ? AppTheme.dividerColor
                  : AppTheme.dividerColor.withOpacity(0.5),
              width: 1,
            ),
          ),
          style: AppTheme.body1.copyWith(
            fontSize: 15,
            color: enabled ? AppTheme.textPrimary : AppTheme.textSecondary,
          ),
          placeholderStyle: AppTheme.body2,
        ),
      ],
    );
  }
}
