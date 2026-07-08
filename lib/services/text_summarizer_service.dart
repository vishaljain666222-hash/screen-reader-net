/// A completely on-device text summarizer — no API key, no network call,
/// no ongoing cost. Uses classic extractive summarization: score every
/// sentence by how many important (frequent, non-filler) words it
/// contains, then keep the highest-scoring sentences in their original
/// order so the summary still reads naturally.
class SummaryResult {
  final String summary;
  final List<String> keyPoints;
  final List<String> topKeywords;
  final int originalWordCount;
  final int summaryWordCount;

  const SummaryResult({
    required this.summary,
    required this.keyPoints,
    required this.topKeywords,
    required this.originalWordCount,
    required this.summaryWordCount,
  });

  int get percentShorter =>
      originalWordCount == 0 ? 0 : (100 - (summaryWordCount / originalWordCount * 100)).round();
}

enum SummaryLength { short, medium, long }

class TextSummarizerService {
  // Common English filler/function words excluded from "importance" scoring
  // — this is what lets real content words (nouns, verbs, key terms) rise
  // to the top instead of "the", "and", "of", etc.
  static const Set<String> _stopWords = {
    'a', 'an', 'the', 'and', 'or', 'but', 'if', 'then', 'so', 'because',
    'as', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between',
    'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to',
    'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again',
    'further', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all',
    'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such',
    'no', 'nor', 'not', 'only', 'own', 'same', 'than', 'too', 'very', 's',
    't', 'can', 'will', 'just', 'don', 'should', 'now', 'is', 'are', 'was',
    'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do',
    'does', 'did', 'doing', 'it', 'its', 'this', 'that', 'these', 'those',
    'i', 'me', 'my', 'we', 'our', 'you', 'your', 'he', 'him', 'his', 'she',
    'her', 'they', 'them', 'their', 'what', 'which', 'who', 'whom',
  };

  int _sentenceCountFor(SummaryLength length, int totalSentences) {
    final target = switch (length) {
      SummaryLength.short => (totalSentences * 0.2).ceil(),
      SummaryLength.medium => (totalSentences * 0.4).ceil(),
      SummaryLength.long => (totalSentences * 0.6).ceil(),
    };
    return target.clamp(1, totalSentences);
  }

  SummaryResult summarize(String text, SummaryLength length) {
    final cleanedText = text.trim();
    final originalWordCount = _wordCount(cleanedText);

    final sentences = _splitIntoSentences(cleanedText);
    if (sentences.isEmpty) {
      return SummaryResult(
        summary: '',
        keyPoints: const [],
        topKeywords: const [],
        originalWordCount: originalWordCount,
        summaryWordCount: 0,
      );
    }

    final wordFrequency = _buildWordFrequency(cleanedText);
    final sentenceScores = <int, double>{};
    for (var i = 0; i < sentences.length; i++) {
      sentenceScores[i] = _scoreSentence(sentences[i], wordFrequency);
    }

    final howMany = _sentenceCountFor(length, sentences.length);
    final rankedIndices = sentenceScores.keys.toList()
      ..sort((a, b) => sentenceScores[b]!.compareTo(sentenceScores[a]!));
    final topIndices = rankedIndices.take(howMany).toList()..sort();

    final summarySentences = topIndices.map((i) => sentences[i].trim()).toList();
    final summary = summarySentences.join(' ');

    // Key points: same top sentences, but as short standalone bullets.
    final keyPoints = summarySentences;

    // Top keywords: the most frequent meaningful words, capitalised nicely.
    final sortedWords = wordFrequency.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topKeywords = sortedWords
        .take(8)
        .map((e) => e.key[0].toUpperCase() + e.key.substring(1))
        .toList();

    return SummaryResult(
      summary: summary,
      keyPoints: keyPoints,
      topKeywords: topKeywords,
      originalWordCount: originalWordCount,
      summaryWordCount: _wordCount(summary),
    );
  }

  int _wordCount(String text) =>
      text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;

  List<String> _splitIntoSentences(String text) {
    // Split on '.', '!', or '?' followed by whitespace or end-of-string.
    // Not perfect (abbreviations like "Dr." can trip it), but reliable
    // enough for real-world pasted text without any external NLP package.
    final raw = text.split(RegExp(r'(?<=[.!?])\s+'));
    return raw.map((s) => s.trim()).where((s) => s.split(' ').length >= 3).toList();
  }

  Map<String, int> _buildWordFrequency(String text) {
    final words = text
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9\s']"), ' ')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty && !_stopWords.contains(w) && w.length > 2);

    final freq = <String, int>{};
    for (final w in words) {
      freq[w] = (freq[w] ?? 0) + 1;
    }
    return freq;
  }

  double _scoreSentence(String sentence, Map<String, int> wordFrequency) {
    final words = sentence
        .toLowerCase()
        .replaceAll(RegExp(r"[^a-z0-9\s']"), ' ')
        .split(RegExp(r'\s+'))
        .where((w) => w.isNotEmpty);

    if (words.isEmpty) return 0;

    var score = 0.0;
    var count = 0;
    for (final w in words) {
      final f = wordFrequency[w];
      if (f != null) {
        score += f;
        count++;
      }
    }
    // Normalize by sentence length so long sentences don't win purely by
    // containing more words — this keeps the summary concise and punchy.
    return count == 0 ? 0 : score / words.length;
  }
}
