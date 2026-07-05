/// Core data models used throughout Screen Reader Academy.

/// A single keyboard shortcut entry shown inside a lesson.
class ShortcutItem {
  final String keys;
  final String description;

  const ShortcutItem({required this.keys, required this.description});
}

/// One screen reader's set of shortcuts + explanation for a given topic
/// (e.g. "NVDA shortcuts for Microsoft Word").
class ScreenReaderSection {
  final String screenReaderName; // NVDA, JAWS, Narrator
  final String introText;
  final List<ShortcutItem> shortcuts;

  const ScreenReaderSection({
    required this.screenReaderName,
    required this.introText,
    required this.shortcuts,
  });
}

/// A lesson is one readable "page" inside a course, e.g.
/// "Formatting text in Word" containing sections for NVDA / JAWS / Narrator.
class Lesson {
  final String id;
  final String title;
  final String summary;
  final List<ScreenReaderSection> sections;

  const Lesson({
    required this.id,
    required this.title,
    required this.summary,
    required this.sections,
  });
}

/// A quiz question with four options and one correct answer index.
class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

/// A course groups lessons + a final quiz under one topic
/// (Microsoft Word, Excel, PowerPoint, Google Chrome, ...).
class Course {
  final String id;
  final String title;
  final String description;
  final String iconLabel; // used for Semantics + simple icon mapping
  final List<Lesson> lessons;
  final List<QuizQuestion> quiz;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.iconLabel,
    required this.lessons,
    required this.quiz,
  });
}

/// Stores a user's best quiz result for a course, persisted locally.
class QuizAttempt {
  final String courseId;
  final int score;
  final int total;
  final DateTime completedAt;

  const QuizAttempt({
    required this.courseId,
    required this.score,
    required this.total,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'score': score,
        'total': total,
        'completedAt': completedAt.toIso8601String(),
      };

  factory QuizAttempt.fromJson(Map<String, dynamic> json) => QuizAttempt(
        courseId: json['courseId'],
        score: json['score'],
        total: json['total'],
        completedAt: DateTime.parse(json['completedAt']),
      );
}
