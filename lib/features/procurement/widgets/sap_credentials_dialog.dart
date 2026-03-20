// lib/features/procurement/widgets/sap_credentials_dialog.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SAPCredentialsDialog extends StatefulWidget {
  final Function(String username, String password) onSubmit;

  const SAPCredentialsDialog({super.key, required this.onSubmit});

  @override
  State<SAPCredentialsDialog> createState() => _SAPCredentialsDialogState();
}

class _SAPCredentialsDialogState extends State<SAPCredentialsDialog> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Icon(
            CupertinoIcons.lock_shield,
            color: AppTheme.primaryBlue,
            size: 32,
          ),
          const SizedBox(height: 8),
          const Text('SAP Credentials'),
        ],
      ),
      content: Column(
        children: [
          const SizedBox(height: 16),
          const Text(
            'Enter your SAP credentials for automation script generation.',
            style: TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 16),
          CupertinoTextField(
            controller: _usernameController,
            placeholder: 'SAP Username',
            prefix: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                CupertinoIcons.person,
                size: 18,
                color: AppTheme.textSecondary,
              ),
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          CupertinoTextField(
            controller: _passwordController,
            placeholder: 'SAP Password',
            obscureText: _obscurePassword,
            prefix: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(
                CupertinoIcons.lock,
                size: 18,
                color: AppTheme.textSecondary,
              ),
            ),
            suffix: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              child: Icon(
                _obscurePassword
                    ? CupertinoIcons.eye
                    : CupertinoIcons.eye_slash,
                size: 18,
                color: AppTheme.textSecondary,
              ),
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.dividerColor),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.warningOrange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Icon(
                  CupertinoIcons.info_circle,
                  size: 16,
                  color: AppTheme.warningOrange,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Credentials stored in script only',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.warningOrange,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () {
            if (_usernameController.text.isNotEmpty &&
                _passwordController.text.isNotEmpty) {
              widget.onSubmit(
                _usernameController.text,
                _passwordController.text,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Generate'),
        ),
      ],
    );
  }
}
