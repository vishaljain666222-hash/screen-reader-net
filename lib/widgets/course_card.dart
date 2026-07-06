import 'package:flutter/material.dart';
import '../data/catalog_data.dart';
import '../models/models.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;

  const CourseCard({super.key, required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final category = CatalogData.categories.firstWhere(
      (c) => c.id == course.categoryId,
      orElse: () => const CourseCategory(id: '', name: ''),
    );

    return Semantics(
      button: true,
      label:
          '${course.name}. ${course.tagline}. Duration ${course.duration}. Price ${course.formattedPrice} rupees. Category ${category.name}.',
      child: Card(
        margin: EdgeInsets.zero,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ExcludeSemantics(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (course.isBestseller)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Theme.of(context).colorScheme.secondary),
                          const SizedBox(width: 4),
                          Text(
                            'Bestseller',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Text(
                    course.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.tagline,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _chip(context, Icons.schedule, course.duration),
                      _chip(context, Icons.currency_rupee, course.formattedPrice, isPrice: true),
                      _chip(context, Icons.category_outlined, category.name),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, IconData icon, String label, {bool isPrice = false}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isPrice ? scheme.secondaryContainer : scheme.surfaceVariant,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: isPrice ? scheme.onSecondaryContainer : scheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isPrice ? FontWeight.bold : FontWeight.normal,
              color: isPrice ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
