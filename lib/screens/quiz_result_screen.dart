import 'package:flutter/material.dart';
import '../models/models.dart';
import 'quiz_screen.dart';

class QuizResultScreen extends StatelessWidget {
  final Course course;
  final QuizSet quizSet;
  final int score;
  final int total;

  const QuizResultScreen({
    super.key,
    required this.course,
    required this.quizSet,
    required this.score,
    required this.total,
  });

  String get _feedbackMessage {
    final ratio = score / total;
    if (ratio == 1.0) return 'Perfect score! You\'ve nailed the ${quizSet.difficulty.label} ${quizSet.screenReader.label} quiz.';
    if (ratio >= 0.7) return 'Great job! Just a little more practice and you\'ll have it all.';
    if (ratio >= 0.4) return 'Good start. Revisit the lessons and try again to build your confidence.';
    return 'No worries — go back through the lessons and give this quiz another try.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Results')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Semantics(
                liveRegion: true,
                label:
                    'You scored $score out of $total on the ${quizSet.difficulty.label} ${quizSet.screenReader.label} quiz for ${course.title}.',
                child: ExcludeSemantics(
                  child: Column(
                    children: [
                      Icon(
                        score / total >= 0.7 ? Icons.emoji_events : Icons.replay_circle_filled,
                        size: 72,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text('$score / $total', style: Theme.of(context).textTheme.displaySmall),
                      const SizedBox(height: 4),
                      Text(
                        '${quizSet.difficulty.label} · ${quizSet.screenReader.label}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(_feedbackMessage, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => QuizScreen(course: course, quizSet: quizSet)),
                ),
                child: const Text('Retake This Quiz'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
