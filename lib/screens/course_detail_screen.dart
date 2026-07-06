import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import 'lesson_screen.dart';
import 'quiz_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(course.description, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 20),
            Text('Lessons', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            ...course.lessons.asMap().entries.map((entry) {
              final index = entry.key;
              final lesson = entry.value;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}')),
                  title: Text(lesson.title),
                  subtitle: Text(lesson.summary, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => LessonScreen(course: course, lesson: lesson)),
                  ),
                ),
              );
            }),
            const SizedBox(height: 28),
            Text('Quizzes', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(
              'Pick a difficulty and a screen reader to start a focused quiz.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            for (final difficulty in QuizDifficulty.values) ...[
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 6),
                child: Row(
                  children: [
                    Text(difficulty.label, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        difficulty.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: ScreenReaderKind.values.map((reader) {
                  final quizSet = course.quizFor(difficulty, reader);
                  if (quizSet == null) return const SizedBox.shrink();
                  final best = progress.bestFor(course.id, quizSet.key);
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Semantics(
                        button: true,
                        label: '${difficulty.label} ${reader.label} quiz for ${course.title}'
                            '${best != null ? ", best score ${best.score} out of ${best.total}" : ", not attempted yet"}',
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => QuizScreen(course: course, quizSet: quizSet)),
                          ),
                          child: ExcludeSemantics(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(reader.label, style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Text(
                                  best != null ? '${best.score}/${best.total}' : 'Start',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 4),
            ],
          ],
        ),
      ),
    );
  }
}
