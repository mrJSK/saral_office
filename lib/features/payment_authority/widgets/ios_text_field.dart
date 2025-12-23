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

  const IOSTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.placeholder,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
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
            color: AppTheme.backgroundLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.dividerColor, width: 1),
          ),
          style: AppTheme.body1.copyWith(fontSize: 15),
          placeholderStyle: AppTheme.body2,
        ),
      ],
    );
  }
}
