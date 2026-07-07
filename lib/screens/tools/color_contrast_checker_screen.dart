import 'dart:math';
import 'package:flutter/material.dart';

/// A free WCAG contrast checker — useful for anyone with low vision picking
/// readable colour combinations, or anyone creating accessible documents,
/// slides, or websites for others.
class ColorContrastCheckerScreen extends StatefulWidget {
  const ColorContrastCheckerScreen({super.key});

  @override
  State<ColorContrastCheckerScreen> createState() => _ColorContrastCheckerScreenState();
}

class _ColorContrastCheckerScreenState extends State<ColorContrastCheckerScreen> {
  Color _foreground = Colors.black;
  Color _background = Colors.white;

  static const List<Color> _swatches = [
    Colors.black,
    Colors.white,
    Color(0xFF5B21B6),
    Color(0xFFF59E0B),
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.grey,
    Color(0xFFF3EEFB),
    Color(0xFF1A1A1A),
  ];

  double get _luminance1 => _foreground.computeLuminance();
  double get _luminance2 => _background.computeLuminance();

  double get _contrastRatio {
    final lighter = max(_luminance1, _luminance2);
    final darker = min(_luminance1, _luminance2);
    return (lighter + 0.05) / (darker + 0.05);
  }

  String get _verdict {
    final ratio = _contrastRatio;
    if (ratio >= 7.0) return 'Passes AAA (best) for normal text';
    if (ratio >= 4.5) return 'Passes AA for normal text';
    if (ratio >= 3.0) return 'Passes AA for large text only';
    return 'Fails WCAG — too low contrast for reliable readability';
  }

  Color get _verdictColor {
    final ratio = _contrastRatio;
    if (ratio >= 4.5) return Colors.green[800]!;
    if (ratio >= 3.0) return Colors.orange[800]!;
    return Colors.red[800]!;
  }

  Widget _swatchPicker(String label, Color selected, ValueChanged<Color> onPick) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _swatches.map((color) {
            final isSelected = color.value == selected.value;
            return Semantics(
              button: true,
              label: '${label} color option',
              selected: isSelected,
              child: GestureDetector(
                onTap: () => onPick(color),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                      width: isSelected ? 3 : 1,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final ratio = _contrastRatio;
    return Scaffold(
      appBar: AppBar(title: const Text('Color Contrast Checker')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Pick a text colour and a background colour to check if they meet WCAG '
              'accessibility contrast guidelines — useful for low-vision readability, '
              'or for making your own documents and slides more accessible to others.',
            ),
            const SizedBox(height: 20),
            _swatchPicker('Text Colour', _foreground, (c) => setState(() => _foreground = c)),
            const SizedBox(height: 20),
            _swatchPicker('Background Colour', _background, (c) => setState(() => _background = c)),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _background,
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'Sample Text Preview',
                style: TextStyle(color: _foreground, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            Semantics(
              liveRegion: true,
              label: 'Contrast ratio ${ratio.toStringAsFixed(2)} to 1. $_verdict',
              child: ExcludeSemantics(
                child: Column(
                  children: [
                    Text('Contrast Ratio: ${ratio.toStringAsFixed(2)} : 1',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(_verdict, style: TextStyle(color: _verdictColor, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
