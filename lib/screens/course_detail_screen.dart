import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/models.dart';
import '../services/payment_gateway_service.dart';
import '../services/wishlist_service.dart';
import 'payment_coming_soon_screen.dart';

class CourseDetailScreen extends StatelessWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  Future<void> _onBuyNow(BuildContext context) async {
    await DemandTrackingService().logBuyNowTap(course.id);
    if (!context.mounted) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => PaymentComingSoonScreen(course: course)));
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = context.watch<WishlistService>();
    final isWishlisted = wishlist.isWishlisted(course.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(course.name, style: const TextStyle(fontSize: 18)),
        actions: [
          Semantics(
            button: true,
            label: 'Share this course',
            child: IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () {
                Share.share(
                  'Check out "${course.name}" on Accessible AI Academy — ${course.duration}, ₹${course.formattedPrice}. ${course.tagline}',
                );
              },
            ),
          ),
          Semantics(
            button: true,
            label: isWishlisted ? 'Remove from wishlist' : 'Add to wishlist',
            child: IconButton(
              icon: Icon(isWishlisted ? Icons.favorite : Icons.favorite_border),
              onPressed: () => wishlist.toggle(course.id),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (course.isBestseller)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Theme.of(context).colorScheme.secondary, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            'Bestseller Combo Program',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Text(course.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(course.tagline, style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _infoChip(context, Icons.schedule, 'Duration', course.duration),
                      _infoChip(context, Icons.currency_rupee, 'Price', '₹${course.formattedPrice}', isPrice: true),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('Full Syllabus', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text(
                    '${course.syllabus.length} modules',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  ...course.syllabus.asMap().entries.map((entry) {
                    final index = entry.key;
                    final module = entry.value;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 16,
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        title: Text(module),
                      ),
                    );
                  }),
                  const SizedBox(height: 100), // room above the sticky button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: Semantics(
              button: true,
              label: 'Buy Now, ${course.name}, ₹${course.formattedPrice}',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF59E0B),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                onPressed: () => _onBuyNow(context),
                child: ExcludeSemantics(child: Text('Buy Now · ₹${course.formattedPrice}')),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoChip(BuildContext context, IconData icon, String label, String value, {bool isPrice = false}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isPrice ? scheme.secondaryContainer : scheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: isPrice ? scheme.onSecondaryContainer : scheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 11, color: isPrice ? scheme.onSecondaryContainer : scheme.onSurfaceVariant)),
              Text(value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isPrice ? scheme.onSecondaryContainer : scheme.onSurfaceVariant,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
