// lib/main.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_provider.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style for consistent appearance
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppTheme.backgroundLight,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Set preferred orientations (optional - remove if you want landscape support)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Initialize all app services (Isar, Firebase, etc.)
  try {
    await initializeApp();
    debugPrint('✅ App initialization complete');
  } catch (e, stackTrace) {
    debugPrint('❌ App initialization failed: $e');
    debugPrint('Stack trace: $stackTrace');
    // Continue anyway - error will be shown in the app
  }

  // Load saved theme preference
  final prefs = await SharedPreferences.getInstance();
  final savedIsDark = prefs.getBool('is_dark_mode') ?? false;

  // Run the app with Riverpod state management
  runApp(ProviderScope(
    overrides: [
      isDarkProvider.overrideWith(() => ThemeNotifier(savedIsDark)),
    ],
    child: const SaralOfficeApp(),
  ));
}

class SaralOfficeApp extends ConsumerWidget {
  const SaralOfficeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDbInitialized = ref.watch(isDatabaseInitializedProvider);
    final isDark = ref.watch(isDarkProvider);

    return CupertinoApp(
      title: 'SaralOffice',
      theme: isDark ? AppTheme.cupertinoThemeDark : AppTheme.cupertinoTheme,
      debugShowCheckedModeBanner: false,
      home: isDbInitialized
          ? const SplashScreen()
          : const DatabaseInitializationScreen(),
      // Optional: Add error handling for navigation
      builder: (context, child) {
        // Add error boundary
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return CupertinoPageScaffold(
            backgroundColor: AppTheme.backgroundLight,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingL),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      CupertinoIcons.exclamationmark_triangle_fill,
                      size: 64,
                      color: AppTheme.errorRed,
                    ),
                    const SizedBox(height: AppTheme.spacingL),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    Text(
                      details.exceptionAsString(),
                      style: AppTheme.caption,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spacingL),
                    CupertinoButton.filled(
                      onPressed: () {
                        // Restart the app
                        SystemNavigator.pop();
                      },
                      child: const Text('Restart App'),
                    ),
                  ],
                ),
              ),
            ),
          );
        };
        return child ?? const SizedBox.shrink();
      },
    );
  }
}

/// Screen shown while database is initializing
class DatabaseInitializationScreen extends StatelessWidget {
  const DatabaseInitializationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppTheme.backgroundLight,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo or Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                CupertinoIcons.doc_text_fill,
                size: 40,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            const Text(
              'SaralOffice',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingM),
            const Text(
              'Initializing database...',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacingXL),
            // Loading indicator
            const CupertinoActivityIndicator(
              radius: 16,
              color: AppTheme.primaryBlue,
            ),
            const SizedBox(height: AppTheme.spacingL),
            // Status text
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingXL),
              child: Text(
                'This may take a few moments on first launch',
                style: AppTheme.caption,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Alternative: Simpler version without database status check
/// Just uncomment this and comment out the ConsumerWidget version above
/*
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
*/
