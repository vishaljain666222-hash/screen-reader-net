/// Core data models used throughout Accessible AI Academy.

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

/// Difficulty tiers for quizzes.
enum QuizDifficulty { basic, intermediate, advanced }

extension QuizDifficultyLabel on QuizDifficulty {
  String get label {
    switch (this) {
      case QuizDifficulty.basic:
        return 'Basic';
      case QuizDifficulty.intermediate:
        return 'Intermediate';
      case QuizDifficulty.advanced:
        return 'Advanced';
    }
  }

  String get description {
    switch (this) {
      case QuizDifficulty.basic:
        return 'Core shortcuts everyone should know first.';
      case QuizDifficulty.intermediate:
        return 'Everyday tasks that mix a few shortcuts together.';
      case QuizDifficulty.advanced:
        return 'Trickier settings, edge cases, and power-user shortcuts.';
    }
  }
}

/// Which screen reader a quiz set targets.
enum ScreenReaderKind { nvda, jaws, narrator }

extension ScreenReaderKindLabel on ScreenReaderKind {
  String get label {
    switch (this) {
      case ScreenReaderKind.nvda:
        return 'NVDA';
      case ScreenReaderKind.jaws:
        return 'JAWS';
      case ScreenReaderKind.narrator:
        return 'Narrator';
    }
  }
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

/// One quiz — a specific difficulty level for a specific screen reader
/// (e.g. "Intermediate JAWS quiz for Excel").
class QuizSet {
  final QuizDifficulty difficulty;
  final ScreenReaderKind screenReader;
  final List<QuizQuestion> questions;

  const QuizSet({
    required this.difficulty,
    required this.screenReader,
    required this.questions,
  });

  /// A stable key for progress tracking, e.g. "advanced_jaws".
  String get key => '${difficulty.name}_${screenReader.name}';
}

/// A course groups lessons + a full grid of quizzes (difficulty x screen
/// reader) under one topic (Microsoft Word, Excel, PowerPoint, Chrome, ...).
class Course {
  final String id;
  final String title;
  final String description;
  final String iconLabel; // used for Semantics + simple icon mapping
  final List<Lesson> lessons;
  final List<QuizSet> quizSets;

  const Course({
    required this.id,
    required this.title,
    required this.description,
    required this.iconLabel,
    required this.lessons,
    required this.quizSets,
  });

  QuizSet? quizFor(QuizDifficulty difficulty, ScreenReaderKind reader) {
    for (final set in quizSets) {
      if (set.difficulty == difficulty && set.screenReader == reader) return set;
    }
    return null;
  }
}

/// Stores a user's best quiz result for one course + difficulty + screen
/// reader combination, persisted locally.
class QuizAttempt {
  final String courseId;
  final String quizKey; // e.g. "advanced_jaws"
  final int score;
  final int total;
  final DateTime completedAt;

  const QuizAttempt({
    required this.courseId,
    required this.quizKey,
    required this.score,
    required this.total,
    required this.completedAt,
  });

  /// The map key used for storage/lookup: unique per course + quiz.
  String get storageKey => '${courseId}__$quizKey';

  Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'quizKey': quizKey,
        'score': score,
        'total': total,
        'completedAt': completedAt.toIso8601String(),
      };

  factory QuizAttempt.fromJson(Map<String, dynamic> json) => QuizAttempt(
        courseId: json['courseId'],
        quizKey: json['quizKey'] ?? '',
        score: json['score'],
        total: json['total'],
        completedAt: DateTime.parse(json['completedAt']),
      );
}
