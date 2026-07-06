import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/update_service.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _version = '...';
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = info.version);
    });
  }

  Future<void> _checkForUpdates() async {
    setState(() => _checking = true);
    final result = await UpdateService().checkForUpdateVerbose();
    if (!mounted) return;
    setState(() => _checking = false);

    if (result.status == UpdateCheckStatus.updateAvailable) {
      final update = result.info!;
      showDialog(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Update available'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Version ${update.versionName} is ready to install.'),
                const SizedBox(height: 12),
                Text(update.releaseNotes),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Later')),
            FilledButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await launchUrl(Uri.parse(update.downloadUrl), mode: LaunchMode.externalApplication);
              },
              child: const Text('Update Now'),
            ),
          ],
        ),
      );
    } else if (result.status == UpdateCheckStatus.upToDate) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You\'re on the latest version (${result.currentVersion}).')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.errorMessage ?? 'Could not check for updates.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('About Accessible AI Academy', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Text(
              'Accessible AI Academy, by Accessible Knowledge Hub, is where students, professionals, and business '
              'owners come to upskill — with 51 practical courses across Microsoft Office, AI, Digital Marketing, '
              'Finance, Business Management, Accounting, Communication, and dedicated Accessibility courses for '
              'visually impaired learners.\n\n'
              'Online payments are being finished right now — until then, browse every course freely, save your '
              'favourites to your wishlist, and tap "Notify Me" on any course to hear the moment checkout opens.\n\n'
              'This app is built to WCAG 2.1 AA accessibility standards, with full screen-reader support, '
              'high-contrast mode, and adjustable text size, because learning should never have barriers.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            Text('Contact & Support', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.email_outlined),
              title: Text('Email'),
              subtitle: Text('support@accessibleknowledgehub.example'),
            ),
            const ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.phone_outlined),
              title: Text('Phone / WhatsApp'),
              subtitle: Text('+91 90000 00000'),
            ),
            const SizedBox(height: 16),
            Text('Version $_version', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _checking ? null : _checkForUpdates,
              icon: _checking
                  ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.system_update_outlined),
              label: Text(_checking ? 'Checking...' : 'Check for Updates'),
            ),
          ],
        ),
      ),
    );
  }
}
