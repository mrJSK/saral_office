// lib/main.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppTheme.backgroundLight,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Initialize dependencies (Isar will auto-import data if needed)
  await setupDependencyInjection();

  runApp(const ProviderScope(child: SaralOfficeApp()));
}

class SaralOfficeApp extends StatelessWidget {
  const SaralOfficeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'SaralOffice',
      theme: AppTheme.cupertinoTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
