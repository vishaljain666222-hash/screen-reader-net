import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// A free text-to-speech reader: type or paste any text (a message, an
/// email, a label off a product) and have it read aloud, with adjustable
/// speaking speed. Useful on its own, independent of screen reader software.
class ReadAloudScreen extends StatefulWidget {
  const ReadAloudScreen({super.key});

  @override
  State<ReadAloudScreen> createState() => _ReadAloudScreenState();
}

class _ReadAloudScreenState extends State<ReadAloudScreen> {
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _controller = TextEditingController();
  double _speechRate = 0.5;
  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-US');
    _tts.setSpeechRate(_speechRate);
    _tts.setCompletionHandler(() {
      if (mounted) setState(() => _isSpeaking = false);
    });
  }

  @override
  void dispose() {
    _tts.stop();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _speak() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    await _tts.setSpeechRate(_speechRate);
    setState(() => _isSpeaking = true);
    await _tts.speak(text);
  }

  Future<void> _stop() async {
    await _tts.stop();
    setState(() => _isSpeaking = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Read Aloud')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Type or paste any text below, then tap Read Aloud. Great for messages, '
                'labels, or anything you want read out — no screen reader required.',
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Semantics(
                  textField: true,
                  label: 'Text to read aloud',
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                      hintText: 'Type or paste text here...',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Speaking Speed: ${(_speechRate * 100).round()}%', style: Theme.of(context).textTheme.bodyMedium),
              Semantics(
                label: 'Speaking speed slider, currently ${(_speechRate * 100).round()} percent',
                child: Slider(
                  value: _speechRate,
                  min: 0.2,
                  max: 1.0,
                  divisions: 8,
                  label: '${(_speechRate * 100).round()}%',
                  onChanged: (value) => setState(() => _speechRate = value),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _isSpeaking ? null : _speak,
                      icon: const Icon(Icons.volume_up),
                      label: const Text('Read Aloud'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _isSpeaking ? _stop : null,
                      icon: const Icon(Icons.stop),
                      label: const Text('Stop'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
