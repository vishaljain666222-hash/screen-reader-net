import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../services/progress_service.dart';
import '../services/sound_service.dart';
import 'quiz_result_screen.dart';

/// Presents one specific quiz (a difficulty + screen reader combination)
/// one question at a time, with sound effects on submit / correct / wrong.
class QuizScreen extends StatefulWidget {
  final Course course;
  final QuizSet quizSet;

  const QuizScreen({super.key, required this.course, required this.quizSet});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int? _selectedOption;
  bool _showFeedback = false;
  final List<int?> _answers = [];

  QuizQuestion get _question => widget.quizSet.questions[_currentIndex];
  bool get _isLastQuestion => _currentIndex == widget.quizSet.questions.length - 1;

  void _selectOption(int index) {
    if (_showFeedback) return;
    setState(() => _selectedOption = index);
  }

  Future<void> _confirmAnswer() async {
    if (_selectedOption == null) return;
    await SoundService.playClick();
    setState(() => _showFeedback = true);
    if (_selectedOption == _question.correctIndex) {
      await SoundService.playCorrect();
    } else {
      await SoundService.playWrong();
    }
  }

  Future<void> _nextQuestion() async {
    _answers.add(_selectedOption);
    if (_isLastQuestion) {
      final score = _computeScore();
      final attempt = QuizAttempt(
        courseId: widget.course.id,
        quizKey: widget.quizSet.key,
        score: score,
        total: widget.quizSet.questions.length,
        completedAt: DateTime.now(),
      );
      await context.read<ProgressService>().recordAttempt(attempt);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            course: widget.course,
            quizSet: widget.quizSet,
            score: score,
            total: widget.quizSet.questions.length,
          ),
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
      if (_answers[i] == widget.quizSet.questions[i].correctIndex) score++;
    }
    return score;
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.quizSet.questions.length;
    final title =
        '${widget.course.title} · ${widget.quizSet.difficulty.label} · ${widget.quizSet.screenReader.label}';

    return Scaffold(
      appBar: AppBar(title: Text(title, style: const TextStyle(fontSize: 16))),
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
