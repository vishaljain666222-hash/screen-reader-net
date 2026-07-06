import 'package:flutter/material.dart';
import '../data/catalog_data.dart';
import '../models/models.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class CategoryListingScreen extends StatelessWidget {
  final CourseCategory category;

  const CategoryListingScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final courses = CatalogData.byCategory(category.id);

    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: SafeArea(
        child: courses.isEmpty
            ? const Center(child: Text('No courses in this category yet.'))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: courses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final course = courses[index];
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
