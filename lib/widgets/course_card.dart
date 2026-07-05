import 'package:flutter/material.dart';
import '../models/models.dart';

/// One tappable "shortcut" tile for a course (Word, Excel, PowerPoint, Chrome).
/// Uses a Semantics wrapper with a button role and a clear combined label so
/// screen readers announce the course name and description as one unit.
class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final IconData icon;

  const CourseCard({
    super.key,
    required this.course,
    required this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${course.title}. ${course.description}',
      child: Card(
        elevation: 1,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ExcludeSemantics(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: Icon(icon, size: 28, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course.title, style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 4),
                        Text(
                          course.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
