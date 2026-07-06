import 'package:flutter/material.dart';
import '../data/catalog_data.dart';
import 'category_listing_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const Map<String, IconData> _icons = {
    'combo': Icons.workspace_premium_outlined,
    'office': Icons.description_outlined,
    'marketing': Icons.campaign_outlined,
    'ai': Icons.auto_awesome_outlined,
    'finance': Icons.show_chart,
    'business': Icons.business_center_outlined,
    'accounting': Icons.receipt_long_outlined,
    'communication': Icons.record_voice_over_outlined,
    'accessibility': Icons.accessibility_new,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: CatalogData.categories.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final category = CatalogData.categories[index];
            final count = CatalogData.byCategory(category.id).length;
            return Card(
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(_icons[category.id] ?? Icons.school_outlined,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                title: Text(category.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                subtitle: Text('$count course${count == 1 ? '' : 's'}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => CategoryListingScreen(category: category))),
              ),
            );
          },
        ),
      ),
    );
  }
}
