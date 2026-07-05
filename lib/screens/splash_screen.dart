import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

/// Brief branded splash that decides where to send the user:
/// straight to Home if already logged in, otherwise to Login.
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
    // restoreSession() is idempotent and cheap (SharedPreferences read), so
    // awaiting it here — even though main.dart also kicks it off — guarantees
    // isLoggedIn reflects any saved session before we route.
    await Future.wait([
      auth.restoreSession(),
      Future.delayed(const Duration(milliseconds: 700)),
    ]);
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(auth.isLoggedIn ? '/home' : '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Semantics(
              label: 'Screen Reader Academy logo',
              image: true,
              child: const Icon(Icons.record_voice_over, size: 96, color: Color(0xFF1D4ED8)),
            ),
            const SizedBox(height: 16),
            Text(
              'Screen Reader Academy',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(
              semanticsLabel: 'Loading Screen Reader Academy',
            ),
          ],
        ),
      ),
    );
  }
}
