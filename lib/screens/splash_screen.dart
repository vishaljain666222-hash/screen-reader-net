import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';

/// Brief branded splash that decides where to send the user: onboarding on
/// first ever run, straight to the main app if already logged in, or to
/// Login otherwise.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _decideRoute());
  }

  Future<void> _decideRoute() async {
    final auth = context.read<AuthService>();
    final prefs = SharedPreferences.getInstance();

    final results = await Future.wait([
      auth.restoreSession(),
      Future.delayed(const Duration(milliseconds: 700)),
      prefs,
    ]);
    if (!mounted) return;

    final seenOnboarding = (results[2] as SharedPreferences).getBool('onboarding_seen_v1') ?? false;

    if (!seenOnboarding) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
      return;
    }
    Navigator.of(context).pushReplacementNamed(auth.isLoggedIn ? '/main' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: 'Accessible AI Academy logo',
              image: true,
              child: Icon(Icons.school, size: 96, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 16),
            Text('Accessible AI Academy', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 4),
            Text(
              'Learn. Grow. Succeed.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(semanticsLabel: 'Loading Accessible AI Academy'),
          ],
        ),
      ),
    );
  }
}
