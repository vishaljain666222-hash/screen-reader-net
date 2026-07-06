import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/accessibility_settings_service.dart';

class AccessibilitySettingsScreen extends StatelessWidget {
  const AccessibilitySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<AccessibilitySettingsService>();

    return Scaffold(
      appBar: AppBar(title: const Text('Accessibility Settings')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('Text Size', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              '${(settings.fontScale * 100).round()}% — supports up to 200%',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Semantics(
              label: 'Text size slider, currently ${(settings.fontScale * 100).round()} percent',
              child: Slider(
                value: settings.fontScale,
                min: 1.0,
                max: 2.0,
                divisions: 10,
                label: '${(settings.fontScale * 100).round()}%',
                onChanged: (value) => context.read<AccessibilitySettingsService>().setFontScale(value),
              ),
            ),
            const Divider(height: 32),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('High Contrast Mode'),
              subtitle: const Text('Stronger colour contrast throughout the app.'),
              value: settings.highContrast,
              onChanged: (value) => context.read<AccessibilitySettingsService>().setHighContrast(value),
            ),
            const Divider(height: 32),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Screen Reader Hints'),
              subtitle: const Text('Extra spoken hints on buttons and cards for TalkBack, NVDA, JAWS, and Narrator.'),
              value: settings.screenReaderHints,
              onChanged: (value) => context.read<AccessibilitySettingsService>().setScreenReaderHints(value),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'This app follows WCAG 2.1 AA as the minimum accessibility standard, with 48dp minimum touch targets '
                'and full TalkBack support on every screen.',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
