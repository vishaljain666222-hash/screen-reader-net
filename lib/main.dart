import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/auth_service.dart';
import 'services/wishlist_service.dart';
import 'services/accessibility_settings_service.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/main_shell.dart';
import 'screens/about_screen.dart';

// Brand colours from the Master Plan, Section 3.1.
const _brandPurple = Color(0xFF5B21B6);
const _brandAmber = Color(0xFFF59E0B);
const _brandLavender = Color(0xFFF3EEFB);
const _brandText = Color(0xFF1A1A1A);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AccessibleAiAcademyApp());
}

class AccessibleAiAcademyApp extends StatelessWidget {
  const AccessibleAiAcademyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()..restoreSession()),
        ChangeNotifierProvider(create: (_) => WishlistService()..load()),
        ChangeNotifierProvider(create: (_) => AccessibilitySettingsService()..load()),
      ],
      child: Consumer<AccessibilitySettingsService>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Accessible AI Academy',
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(highContrast: settings.highContrast),
            builder: (context, child) {
              // Support Android system font scaling up to 200% (Master Plan
              // 3.2) — combine the system's own scale with our in-app slider,
              // capped at 2.0x so nothing breaks layouts beyond that.
              final systemScale = MediaQuery.textScalerOf(context);
              final combinedScale = systemScale.scale(1.0) * settings.fontScale;
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(combinedScale.clamp(1.0, 2.0)),
                ),
                child: child!,
              );
            },
            initialRoute: '/',
            routes: {
              '/': (_) => const SplashScreen(),
              '/onboarding': (_) => const OnboardingScreen(),
              '/login': (_) => const LoginScreen(),
              '/signup': (_) => const SignupScreen(),
              '/main': (_) => const MainShell(),
              '/about': (_) => const AboutScreen(),
            },
          );
        },
      ),
    );
  }

  ThemeData _buildTheme({required bool highContrast}) {
    final colorScheme = highContrast
        ? ColorScheme.fromSeed(
            seedColor: _brandPurple,
            brightness: Brightness.light,
            primary: const Color(0xFF3B0A94), // deeper purple for higher contrast
            secondary: const Color(0xFFB45300), // deeper amber for higher contrast
            surface: Colors.white,
            onSurface: Colors.black,
          )
        : ColorScheme.fromSeed(
            seedColor: _brandPurple,
            brightness: Brightness.light,
            primary: _brandPurple,
            secondary: _brandAmber,
          );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: highContrast ? Colors.white : _brandLavender,
      visualDensity: VisualDensity.standard,
      textTheme: TextTheme(
        bodyLarge: TextStyle(fontSize: 18, color: highContrast ? Colors.black : _brandText),
        bodyMedium: TextStyle(fontSize: 16, color: highContrast ? Colors.black : _brandText),
        bodySmall: TextStyle(fontSize: 14, color: highContrast ? Colors.black : _brandText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(88, 48), // 48dp minimum touch target
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(minimumSize: const Size(88, 48)),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: highContrast ? 0 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: highContrast ? const BorderSide(color: Colors.black, width: 1.5) : BorderSide.none,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: colorScheme.primaryContainer,
      ),
    );
  }
}
