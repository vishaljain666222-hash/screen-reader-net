import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import 'quiz_result_screen.dart';

/// Presents the course's quiz one question at a time. Using RadioListTile
/// (rather than a custom widget) gives free, correct screen reader semantics
/// (role=radio, checked state, group announcement) on both Android
/// accessibility services and desktop screen readers testing the Flutter web build.
class QuizScreen extends StatefulWidget {
  final Course course;

  const QuizScreen({super.key, required this.course});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int? _selectedOption;
  bool _showFeedback = false;
  final List<int?> _answers = [];

  QuizQuestion get _question => widget.course.quiz[_currentIndex];
  bool get _isLastQuestion => _currentIndex == widget.course.quiz.length - 1;

  void _selectOption(int index) {
    if (_showFeedback) return; // lock in the answer once feedback is shown
    setState(() => _selectedOption = index);
  }

  void _confirmAnswer() {
    if (_selectedOption == null) return;
    setState(() => _showFeedback = true);
  }

  Future<void> _nextQuestion() async {
    _answers.add(_selectedOption);
    if (_isLastQuestion) {
      final score = _computeScore();
      final attempt = QuizAttempt(
        courseId: widget.course.id,
        score: score,
        total: widget.course.quiz.length,
        completedAt: DateTime.now(),
      );
      await context.read<ProgressService>().recordAttempt(attempt);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(course: widget.course, score: score, total: widget.course.quiz.length),
        ),
      );
      return;
    }
    setState(() {
      _currentIndex++;
      _selectedOption = null;
      _showFeedback = false;
    });
  }

  int _computeScore() {
    var score = 0;
    for (var i = 0; i < _answers.length; i++) {
      if (_answers[i] == widget.course.quiz[i].correctIndex) score++;
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.course.quiz.length;

    return Scaffold(
      appBar: AppBar(title: Text('${widget.course.title} Quiz')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Semantics(
                label: 'Question ${_currentIndex + 1} of $total',
                child: ExcludeSemantics(
                  child: LinearProgressIndicator(value: (_currentIndex + 1) / total),
                ),
              ),
              const SizedBox(height: 8),
              Text('Question ${_currentIndex + 1} of $total', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 12),
              Text(_question.question, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: _question.options.length,
                  itemBuilder: (context, index) {
                    final isCorrect = index == _question.correctIndex;
                    final isSelected = index == _selectedOption;
                    Color? tileColor;
                    if (_showFeedback) {
                      if (isCorrect) {
                        tileColor = Colors.green.withOpacity(0.15);
                      } else if (isSelected) {
                        tileColor = Colors.red.withOpacity(0.15);
                      }
                    }
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: tileColor,
                        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: RadioListTile<int>(
                        value: index,
                        groupValue: _selectedOption,
                        onChanged: _showFeedback ? null : (value) => _selectOption(value!),
                        title: Text(_question.options[index]),
                        secondary: _showFeedback && isCorrect
                            ? const Icon(Icons.check_circle, color: Colors.green)
                            : (_showFeedback && isSelected ? const Icon(Icons.cancel, color: Colors.red) : null),
                      ),
                    );
                  },
                ),
              ),
              if (_showFeedback)
                Semantics(
                  liveRegion: true,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      _selectedOption == _question.correctIndex
                          ? 'Correct! ${_question.explanation}'
                          : 'Not quite. ${_question.explanation}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _selectedOption == _question.correctIndex ? Colors.green[800] : Colors.red[800],
                      ),
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: !_showFeedback
                    ? (_selectedOption == null ? null : _confirmAnswer)
                    : _nextQuestion,
                child: Text(!_showFeedback ? 'Check Answer' : (_isLastQuestion ? 'See Results' : 'Next Question')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
