import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text('About Screen Reader Academy', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 16),
            const Text(
              'Screen Reader Academy is a free learning app that helps people who are blind or have '
              'low vision — and the people who support them — learn to use screen readers with confidence.\n\n'
              'Every course covers the same everyday tasks (using Word, Excel, PowerPoint, and Chrome) but explains '
              'them separately for NVDA, JAWS, and Narrator, since each screen reader has its own commands and behaviour.\n\n'
              'Lessons are written to be read directly by your screen reader — no images or complex layouts get in '
              'the way of the content. Each course ends with a short quiz so you can check what you\'ve learned.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            Text('Version 1.0.0', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
