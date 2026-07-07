import 'package:flutter/material.dart';
import 'package:app_settings/app_settings.dart';
import 'tools/read_aloud_screen.dart';
import 'tools/talking_calculator_screen.dart';
import 'tools/screen_reader_shortcuts_screen.dart';
import 'tools/color_contrast_checker_screen.dart';

class _ToolInfo {
  final String title;
  final String description;
  final IconData icon;
  final WidgetBuilder builder;
  const _ToolInfo({required this.title, required this.description, required this.icon, required this.builder});
}

/// Accessible Tools — genuinely useful, completely free tools for people
/// who are blind, have low vision, or otherwise benefit from accessibility
/// support. Separate from the paid course catalog: nothing on this page
/// requires purchase.
class AccessibleToolsScreen extends StatelessWidget {
  const AccessibleToolsScreen({super.key});

  static final List<_ToolInfo> _tools = [
    _ToolInfo(
      title: 'Read Aloud',
      description: 'Type or paste any text and have it read aloud, with adjustable speed.',
      icon: Icons.record_voice_over_outlined,
      builder: (_) => const ReadAloudScreen(),
    ),
    _ToolInfo(
      title: 'Talking Calculator',
      description: 'A calculator that speaks every button press and result aloud.',
      icon: Icons.calculate_outlined,
      builder: (_) => const TalkingCalculatorScreen(),
    ),
    _ToolInfo(
      title: 'Screen Reader Shortcuts',
      description: 'Free quick-reference for NVDA, JAWS, Narrator, TalkBack, and VoiceOver.',
      icon: Icons.keyboard_alt_outlined,
      builder: (_) => const ScreenReaderShortcutsScreen(),
    ),
    _ToolInfo(
      title: 'Color Contrast Checker',
      description: 'Check if a text/background colour combination is easy to read.',
      icon: Icons.contrast_outlined,
      builder: (_) => const ColorContrastCheckerScreen(),
    ),
  ];

  Future<void> _openSystemSetting(BuildContext context, AppSettingsType type, String label) async {
    try {
      await AppSettings.openAppSettings(type: type);
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $label on this device.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accessible Tools')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.volunteer_activism_outlined, color: Theme.of(context).colorScheme.onSecondaryContainer),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'These tools are completely free — no purchase needed. Use them anytime, whether or not you take a course.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ..._tools.map((tool) => Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(tool.icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    ),
                    title: Text(tool.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(tool.description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: tool.builder)),
                  ),
                )),
            const SizedBox(height: 12),
            Text('Quick Settings Shortcuts', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Jump straight to your phone\'s built-in accessibility settings.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                OutlinedButton.icon(
                  onPressed: () => _openSystemSetting(context, AppSettingsType.accessibility, 'Accessibility settings'),
                  icon: const Icon(Icons.accessibility_new),
                  label: const Text('Accessibility Settings'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _openSystemSetting(context, AppSettingsType.display, 'Display settings'),
                  icon: const Icon(Icons.brightness_6_outlined),
                  label: const Text('Display Settings'),
                ),
                OutlinedButton.icon(
                  onPressed: () => _openSystemSetting(context, AppSettingsType.settings, 'Settings'),
                  icon: const Icon(Icons.settings_outlined),
                  label: const Text('All Phone Settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
