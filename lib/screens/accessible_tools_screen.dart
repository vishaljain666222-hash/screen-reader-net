import 'package:flutter/material.dart';
import 'tools/ai_text_summarizer_screen.dart';
import 'tools/talking_calculator_screen.dart';

class _ToolInfo {
  final String title;
  final String description;
  final IconData icon;
  final WidgetBuilder builder;
  final bool isNew;
  const _ToolInfo({
    required this.title,
    required this.description,
    required this.icon,
    required this.builder,
    this.isNew = false,
  });
}

/// Accessible Tools — genuinely useful, completely free tools for people
/// who are blind, have low vision, or otherwise benefit from accessibility
/// support. Separate from the paid course catalog: nothing on this page
/// requires purchase.
class AccessibleToolsScreen extends StatelessWidget {
  const AccessibleToolsScreen({super.key});

  static final List<_ToolInfo> _tools = [
    _ToolInfo(
      title: 'AI Text Summarizer',
      description: 'Paste any long text and get an instant summary, key points, and keywords — read aloud on request.',
      icon: Icons.auto_awesome,
      builder: (_) => const AiTextSummarizerScreen(),
      isNew: true,
    ),
    _ToolInfo(
      title: 'Talking Calculator',
      description: 'A calculator that speaks every button press and result aloud.',
      icon: Icons.calculate_outlined,
      builder: (_) => const TalkingCalculatorScreen(),
    ),
  ];

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
                    title: Row(
                      children: [
                        Flexible(child: Text(tool.title, style: const TextStyle(fontWeight: FontWeight.bold))),
                        if (tool.isNew) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'NEW',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onTertiaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    subtitle: Text(tool.description),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: tool.builder)),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
