import 'package:flutter/material.dart';
import '../models/models.dart';

/// Shows one lesson's reading content, split into a tab per screen reader
/// (NVDA / JAWS / Narrator). Each tab is fully readable top-to-bottom by a
/// screen reader without needing to interact with the shortcut list as a
/// data table — it's just a simple, linear column of text.
class LessonScreen extends StatelessWidget {
  final Course course;
  final Lesson lesson;

  const LessonScreen({super.key, required this.course, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: lesson.sections.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lesson.title),
          bottom: TabBar(
            tabs: lesson.sections
                .map((s) => Tab(text: s.screenReaderName))
                .toList(),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: lesson.sections.map((section) => _SectionView(section: section)).toList(),
          ),
        ),
      ),
    );
  }
}

class _SectionView extends StatelessWidget {
  final ScreenReaderSection section;

  const _SectionView({required this.section});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          '${section.screenReaderName} — how it works',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text(section.introText, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 20),
        Text('Keyboard shortcuts', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...section.shortcuts.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Semantics(
              label: 'Shortcut: ${s.keys}. ${s.description}',
              child: ExcludeSemantics(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.keys,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace', fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(s.description),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
