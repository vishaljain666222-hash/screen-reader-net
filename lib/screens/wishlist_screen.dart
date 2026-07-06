import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/catalog_data.dart';
import '../services/wishlist_service.dart';
import '../widgets/course_card.dart';
import 'course_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistService>();
    final courses = CatalogData.courses.where((c) => wishlist.isWishlisted(c.id)).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist / My Courses')),
      body: SafeArea(
        child: courses.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.favorite_border, size: 64, color: Theme.of(context).colorScheme.outline),
                      const SizedBox(height: 16),
                      const Text(
                        'Nothing here yet. Tap the heart icon on any course to save it here.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
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
