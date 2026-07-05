import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/content_data.dart';
import '../models/models.dart';
import '../services/update_service.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkForUpdate());
  }

  Future<void> _checkForUpdate() async {
    final update = await UpdateService().checkForUpdate();
    if (!mounted || update == null) return;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Update available'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Version ${update.versionName} is ready to install.'),
              const SizedBox(height: 12),
              Text(update.releaseNotes),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Later'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              final uri = Uri.parse(update.downloadUrl);
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }

  static const Map<String, IconData> _icons = {
    'word': Icons.description_outlined,
    'excel': Icons.grid_on_outlined,
    'powerpoint': Icons.slideshow_outlined,
    'chrome': Icons.public,
  };

  List<Course> get _filteredCourses {
    if (_query.trim().isEmpty) return ContentData.courses;
    final q = _query.toLowerCase();
    return ContentData.courses.where((c) {
      return c.title.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q) ||
          c.lessons.any((l) => l.title.toLowerCase().contains(q));
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openCourse(Course course) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final courses = _filteredCourses;

    return Scaffold(
      appBar: AppBar(title: const Text('Screen Reader Academy')),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'What would you like to learn today?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Semantics(
              textField: true,
              label: 'Search courses',
              hint: 'Type an app name, like Word or Chrome, to filter courses',
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: 'Search courses (e.g. Word, Excel, Chrome)',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          icon: const Icon(Icons.clear),
                          tooltip: 'Clear search',
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                        ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Courses',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Text-based lessons with keyboard shortcuts for NVDA, JAWS, and Narrator, finishing with a short quiz.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            if (courses.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    'No courses match "$_query". Try a different search term.',
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...courses.map(
                (course) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: CourseCard(
                    course: course,
                    icon: _icons[course.id] ?? Icons.school_outlined,
                    onTap: () => _openCourse(course),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
