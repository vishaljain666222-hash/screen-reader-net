import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import '../../services/text_summarizer_service.dart';

/// A free, on-device "AI Text Summarizer" — paste any long text, or attach
/// a .txt or .pdf file, and get a short summary, key points, and top
/// keywords. Read the summary aloud, or copy it to your clipboard. Runs
/// entirely on the device: no API key, no network call, no ongoing cost,
/// works offline, and nothing you type or attach ever leaves your phone.
class AiTextSummarizerScreen extends StatefulWidget {
  const AiTextSummarizerScreen({super.key});

  @override
  State<AiTextSummarizerScreen> createState() => _AiTextSummarizerScreenState();
}

class _AiTextSummarizerScreenState extends State<AiTextSummarizerScreen> {
  final _controller = TextEditingController();
  final _service = TextSummarizerService();
  final FlutterTts _tts = FlutterTts();

  SummaryLength _length = SummaryLength.medium;
  SummaryResult? _result;
  bool _isSpeaking = false;
  bool _isLoadingFile = false;
  String? _attachedFileName;

  @override
  void initState() {
    super.initState();
    _tts.setLanguage('en-US');
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

  void _summarize() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() => _result = _service.summarize(text, _length));
  }

  Future<void> _speakSummary() async {
    final result = _result;
    if (result == null || result.summary.isEmpty) return;
    setState(() => _isSpeaking = true);
    await _tts.speak(result.summary);
  }

  Future<void> _stopSpeaking() async {
    await _tts.stop();
    setState(() => _isSpeaking = false);
  }

  Future<void> _copySummary() async {
    final result = _result;
    if (result == null || result.summary.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: result.summary));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Summary copied to clipboard.')),
    );
  }

  Future<void> _attachFile() async {
    try {
      final picked = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'pdf'],
      );
      if (picked == null || picked.files.single.path == null) return;

      final path = picked.files.single.path!;
      final name = picked.files.single.name;
      setState(() => _isLoadingFile = true);

      String extractedText;
      if (name.toLowerCase().endsWith('.pdf')) {
        extractedText = await ReadPdfText.getPDFtext(path);
      } else {
        extractedText = await File(path).readAsString();
      }

      if (!mounted) return;
      setState(() {
        _isLoadingFile = false;
        _attachedFileName = name;
        _result = null;
      });

      if (extractedText.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No readable text found in that file (a scanned/image-only PDF can\'t be read this way).'),
          ),
        );
        return;
      }

      _controller.text = extractedText;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loaded "$name" — tap Summarize when ready.')),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingFile = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not read that file. Please try a different .txt or .pdf file.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = _result;

    return Scaffold(
      appBar: AppBar(title: const Text('AI Text Summarizer')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome, color: Theme.of(context).colorScheme.onSecondaryContainer),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Works fully on your device — no internet needed, nothing you type or attach ever leaves your phone.',
                      style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _isLoadingFile ? null : _attachFile,
              icon: _isLoadingFile
                  ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.attach_file),
              label: Text(_isLoadingFile
                  ? 'Reading file...'
                  : (_attachedFileName != null ? 'Attached: $_attachedFileName' : 'Attach a .txt or .pdf File')),
            ),
            const SizedBox(height: 12),
            Semantics(
              textField: true,
              label: 'Text to summarize',
              hint: 'Paste an article, email, or notes here, or attach a file above',
              child: TextField(
                controller: _controller,
                maxLines: 8,
                decoration: const InputDecoration(
                  hintText: 'Paste any long text here, or attach a .txt / .pdf file above...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Summary Length', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            SegmentedButton<SummaryLength>(
              segments: const [
                ButtonSegment(value: SummaryLength.short, label: Text('Short')),
                ButtonSegment(value: SummaryLength.medium, label: Text('Medium')),
                ButtonSegment(value: SummaryLength.long, label: Text('Long')),
              ],
              selected: {_length},
              onSelectionChanged: (selection) => setState(() => _length = selection.first),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _summarize,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Summarize'),
            ),
            if (result != null) ...[
              const SizedBox(height: 28),
              if (result.summary.isEmpty)
                const Text('Please paste or attach at least a couple of full sentences to summarize.')
              else ...[
                Semantics(
                  liveRegion: true,
                  label:
                      'Summary ready. Reduced from ${result.originalWordCount} words to ${result.summaryWordCount} words, ${result.percentShorter} percent shorter.',
                  child: ExcludeSemantics(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.compress, size: 16, color: Theme.of(context).colorScheme.onPrimaryContainer),
                          const SizedBox(width: 6),
                          Text(
                            '${result.originalWordCount} → ${result.summaryWordCount} words (${result.percentShorter}% shorter)',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Summary', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(result.summary, style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isSpeaking ? null : _speakSummary,
                        icon: const Icon(Icons.volume_up),
                        label: const Text('Read Aloud'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isSpeaking ? _stopSpeaking : null,
                        icon: const Icon(Icons.stop),
                        label: const Text('Stop'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _copySummary,
                    icon: const Icon(Icons.copy_outlined),
                    label: const Text('Copy Summary to Clipboard'),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Key Points', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                ...result.keyPoints.map(
                  (point) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('•  '),
                        Expanded(child: Text(point)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text('Top Keywords', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: result.topKeywords
                      .map((k) => Chip(label: Text(k), backgroundColor: Theme.of(context).colorScheme.surfaceVariant))
                      .toList(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
