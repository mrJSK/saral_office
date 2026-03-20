// lib/core/theme/theme_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeKey = 'is_dark_mode';

class ThemeNotifier extends Notifier<bool> {
  final bool _initial;
  ThemeNotifier(this._initial);

  @override
  bool build() => _initial;

  Future<void> toggle() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kThemeKey, state);
  }
}

final isDarkProvider =
    NotifierProvider<ThemeNotifier, bool>(() => ThemeNotifier(false));
