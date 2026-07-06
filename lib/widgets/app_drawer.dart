import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

/// The hamburger/toggle navigation menu: Home, About, Contact Us, Logout.
/// Fully reachable with Tab/Swipe navigation for screen reader users.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();
    final user = auth.currentUser;

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.record_voice_over, color: Colors.white, size: 36),
                  const SizedBox(height: 8),
                  Text(
                    user != null && user.name.isNotEmpty ? 'Hi, ${user.name}' : 'Accessible AI Academy',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  if (user != null)
                    Text(user.email, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/about');
              },
            ),
            ListTile(
              leading: const Icon(Icons.mail_outline),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/contact');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                await context.read<AuthService>().signOut();
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
