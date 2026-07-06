import 'package:flutter/material.dart';
import '../data/catalog_data.dart';
import '../models/models.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String initialQuery;

  const SearchResultsScreen({super.key, this.initialQuery = ''});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late final TextEditingController _controller;
  late String _query;

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery;
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Course> get _results {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return [];
    return CatalogData.courses.where((course) {
      final category = CatalogData.categories.firstWhere(
        (c) => c.id == course.categoryId,
        orElse: () => const CourseCategory(id: '', name: ''),
      );
      return course.name.toLowerCase().contains(q) ||
          course.tagline.toLowerCase().contains(q) ||
          category.name.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _results;
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          textField: true,
          label: 'Search all courses',
          child: TextField(
            controller: _controller,
            autofocus: widget.initialQuery.isEmpty,
            textInputAction: TextInputAction.search,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Search courses...',
              hintStyle: TextStyle(color: Colors.white70),
              border: InputBorder.none,
            ),
            onChanged: (value) => setState(() => _query = value),
          ),
        ),
      ),
      body: SafeArea(
        child: _query.trim().isEmpty
            ? const Center(child: Text('Start typing to search all 51 courses.'))
            : results.isEmpty
                ? Center(child: Text('No courses found for "$_query".'))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: results.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final course = results[index];
                      return CourseCard(
                        course: course,
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course))),
                      );
                    },
                  ),
      ),
    );
  }
}
