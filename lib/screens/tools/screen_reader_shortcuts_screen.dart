import 'package:flutter/material.dart';

class _ReaderShortcuts {
  final String name;
  final String platform;
  final List<MapEntry<String, String>> shortcuts;
  const _ReaderShortcuts({required this.name, required this.platform, required this.shortcuts});
}

/// A free, always-available quick-reference for the essential shortcuts of
/// the most common screen readers — separate from (and a lighter taste of)
/// the full paid NVDA Screen Reader Training course under Accessibility
/// Special Courses.
class ScreenReaderShortcutsScreen extends StatelessWidget {
  const ScreenReaderShortcutsScreen({super.key});

  static const _readers = [
    _ReaderShortcuts(
      name: 'NVDA',
      platform: 'Windows (free)',
      shortcuts: [
        MapEntry('NVDA + Down Arrow', 'Say All — read continuously'),
        MapEntry('NVDA + F7', 'Elements List (headings, links, tables)'),
        MapEntry('Ctrl', 'Stop speech immediately'),
        MapEntry('NVDA + Ctrl + M', 'Minimize NVDA temporarily'),
        MapEntry('H / Shift + H', 'Next / previous heading (web pages)'),
        MapEntry('Insert + T', 'Read the window title'),
      ],
    ),
    _ReaderShortcuts(
      name: 'JAWS',
      platform: 'Windows (paid)',
      shortcuts: [
        MapEntry('Insert + Down Arrow', 'Say All — read continuously'),
        MapEntry('Insert + F6', 'Headings list'),
        MapEntry('Insert + F7', 'Links list'),
        MapEntry('Ctrl', 'Stop speech immediately'),
        MapEntry('Insert + T', 'Read the window title'),
      ],
    ),
    _ReaderShortcuts(
      name: 'Narrator',
      platform: 'Windows (built-in)',
      shortcuts: [
        MapEntry('Caps Lock + Enter', 'Start or stop Narrator'),
        MapEntry('Caps Lock + Space', 'Toggle Scan Mode'),
        MapEntry('Caps Lock + Down Arrow', 'Read continuously'),
        MapEntry('Ctrl', 'Stop speech immediately'),
      ],
    ),
    _ReaderShortcuts(
      name: 'TalkBack',
      platform: 'Android (built-in)',
      shortcuts: [
        MapEntry('Swipe right / left', 'Move to next / previous item'),
        MapEntry('Double-tap', 'Activate the selected item'),
        MapEntry('Swipe up then down', 'Open the reading controls menu'),
        MapEntry('Two-finger swipe', 'Scroll the screen'),
        MapEntry('Volume Up + Down (hold)', 'Toggle TalkBack on/off (on many devices)'),
      ],
    ),
    _ReaderShortcuts(
      name: 'VoiceOver',
      platform: 'iPhone / iPad (built-in)',
      shortcuts: [
        MapEntry('Swipe right / left', 'Move to next / previous item'),
        MapEntry('Double-tap', 'Activate the selected item'),
        MapEntry('Two-finger tap', 'Pause or resume speech'),
        MapEntry('Three-finger swipe', 'Scroll the screen'),
        MapEntry('Triple-click Side/Home button', 'Toggle VoiceOver on/off'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _readers.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Screen Reader Shortcuts'),
          bottom: TabBar(isScrollable: true, tabs: _readers.map((r) => Tab(text: r.name)).toList()),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: Theme.of(context).colorScheme.secondaryContainer,
                child: Text(
                  'Free quick reference. For a complete, in-depth NVDA course, check out '
                  '"NVDA Screen Reader Training" under Accessibility Special Courses.',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 13),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: _readers.map((reader) {
                    return ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Text(reader.platform, style: Theme.of(context).textTheme.bodySmall),
                        const SizedBox(height: 12),
                        ...reader.shortcuts.map(
                          (entry) => Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(entry.key,
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                                  const SizedBox(height: 4),
                                  Text(entry.value),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
