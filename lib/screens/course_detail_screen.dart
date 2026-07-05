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
    final best = progress.bestFor(course.id);

    return Scaffold(
      appBar: AppBar(title: Text(course.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(course.description, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            if (best != null)
              Semantics(
                liveRegion: true,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.emoji_events_outlined),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text('Your best quiz score: ${best.score} out of ${best.total}'),
                      ),
                    ],
                  ),
                ),
              ),
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
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.quiz_outlined),
              label: Text(best == null ? 'Take the ${course.title} Quiz' : 'Retake the ${course.title} Quiz'),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => QuizScreen(course: course)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
