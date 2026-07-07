import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// A simple calculator that speaks every button press and the result aloud
/// — useful as a standalone accessible calculator, independent of whatever
/// screen reader (if any) is running.
class TalkingCalculatorScreen extends StatefulWidget {
  const TalkingCalculatorScreen({super.key});

  @override
  State<TalkingCalculatorScreen> createState() => _TalkingCalculatorScreenState();
}

class _TalkingCalculatorScreenState extends State<TalkingCalculatorScreen> {
  final FlutterTts _tts = FlutterTts();
  String _display = '0';
  double? _firstOperand;
  String? _pendingOperator;
  bool _startFresh = true;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-US');
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _speak(String text) async {
    await _tts.stop();
    await _tts.speak(text);
  }

  void _onDigit(String digit) {
    setState(() {
      if (_startFresh || _display == '0') {
        _display = digit;
        _startFresh = false;
      } else {
        _display += digit;
      }
    });
    _speak(digit);
  }

  void _onDecimal() {
    if (_display.contains('.')) return;
    setState(() {
      _display = _startFresh ? '0.' : '$_display.';
      _startFresh = false;
    });
    _speak('point');
  }

  void _onOperator(String op, String spokenName) {
    setState(() {
      _firstOperand = double.tryParse(_display);
      _pendingOperator = op;
      _startFresh = true;
    });
    _speak(spokenName);
  }

  void _onEquals() {
    if (_firstOperand == null || _pendingOperator == null) return;
    final second = double.tryParse(_display) ?? 0;
    double result;
    switch (_pendingOperator) {
      case '+':
        result = _firstOperand! + second;
        break;
      case '-':
        result = _firstOperand! - second;
        break;
      case '×':
        result = _firstOperand! * second;
        break;
      case '÷':
        result = second == 0 ? double.nan : _firstOperand! / second;
        break;
      default:
        result = second;
    }
    final resultText = result.isNaN
        ? 'Cannot divide by zero'
        : (result == result.roundToDouble() ? result.toInt().toString() : result.toString());
    setState(() {
      _display = resultText;
      _firstOperand = null;
      _pendingOperator = null;
      _startFresh = true;
    });
    _speak('equals $resultText');
  }

  void _onClear() {
    setState(() {
      _display = '0';
      _firstOperand = null;
      _pendingOperator = null;
      _startFresh = true;
    });
    _speak('Cleared');
  }

  Widget _button(String label, {VoidCallback? onTap, Color? background, Color? foreground, String? semanticLabel}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: SizedBox(
          height: 64,
          child: Semantics(
            button: true,
            label: semanticLabel ?? label,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: background,
                foregroundColor: foreground,
                textStyle: const TextStyle(fontSize: 22),
              ),
              onPressed: onTap,
              child: ExcludeSemantics(child: Text(label)),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Talking Calculator')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: scheme.surfaceVariant, borderRadius: BorderRadius.circular(12)),
                child: Semantics(
                  liveRegion: true,
                  label: 'Calculator display: $_display',
                  child: ExcludeSemantics(
                    child: Text(
                      _display,
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(children: [
                _button('C', onTap: _onClear, background: scheme.errorContainer, foreground: scheme.onErrorContainer),
                _button('÷', onTap: () => _onOperator('÷', 'divide'), background: scheme.secondaryContainer),
              ]),
              Row(children: [
                _button('7', onTap: () => _onDigit('7')),
                _button('8', onTap: () => _onDigit('8')),
                _button('9', onTap: () => _onDigit('9')),
                _button('×', onTap: () => _onOperator('×', 'multiply'), background: scheme.secondaryContainer),
              ]),
              Row(children: [
                _button('4', onTap: () => _onDigit('4')),
                _button('5', onTap: () => _onDigit('5')),
                _button('6', onTap: () => _onDigit('6')),
                _button('-', onTap: () => _onOperator('-', 'minus'), background: scheme.secondaryContainer, semanticLabel: 'minus'),
              ]),
              Row(children: [
                _button('1', onTap: () => _onDigit('1')),
                _button('2', onTap: () => _onDigit('2')),
                _button('3', onTap: () => _onDigit('3')),
                _button('+', onTap: () => _onOperator('+', 'plus'), background: scheme.secondaryContainer, semanticLabel: 'plus'),
              ]),
              Row(children: [
                _button('0', onTap: () => _onDigit('0')),
                _button('.', onTap: _onDecimal, semanticLabel: 'decimal point'),
                _button('=', onTap: _onEquals, background: scheme.primary, foreground: scheme.onPrimary, semanticLabel: 'equals'),
              ]),
              const SizedBox(height: 8),
              OutlinedButton.icon(
                onPressed: () => _speak('The display shows $_display'),
                icon: const Icon(Icons.volume_up),
                label: const Text('Read Display Aloud'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
