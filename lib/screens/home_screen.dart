import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/catalog_data.dart';
import '../models/models.dart';
import '../services/update_service.dart';
import '../widgets/course_card.dart';
import 'accessible_tools_screen.dart';
import 'category_listing_screen.dart';
import 'course_detail_screen.dart';
import 'search_results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  static const Map<String, IconData> _categoryIcons = {
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkForUpdate());
  }

  Future<void> _checkForUpdate() async {
    final update = await UpdateService().checkForUpdate();
    if (!mounted || update == null) return;
    showDialog(
      context: context,
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
          TextButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text('Later')),
          FilledButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await launchUrl(Uri.parse(update.downloadUrl), mode: LaunchMode.externalApplication);
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }

  void _openSearch(String query) {
    if (query.trim().isEmpty) return;
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchResultsScreen(initialQuery: query)));
  }

  @override
  Widget build(BuildContext context) {
    final bestsellers = CatalogData.bestsellers;

    return Scaffold(
      appBar: AppBar(title: const Text('Accessible AI Academy')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ---- Search bar ----
            Semantics(
              textField: true,
              label: 'Search all courses',
              hint: 'Type a course name or category and press search',
              child: TextField(
                controller: _searchController,
                textInputAction: TextInputAction.search,
                onSubmitted: _openSearch,
                decoration: InputDecoration(
                  hintText: 'Search 51 courses (e.g. Excel, AI, GST)',
                  prefixIcon: const Icon(Icons.search),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    tooltip: 'Search',
                    onPressed: () => _openSearch(_searchController.text),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ---- Free Accessible Tools banner ----
            Semantics(
              button: true,
              label: 'Free Accessible Tools. AI Text Summarizer and Talking Calculator, at no cost.',
              child: Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const AccessibleToolsScreen())),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: ExcludeSemantics(
                      child: Row(
                        children: [
                          Icon(Icons.accessibility_new, color: Theme.of(context).colorScheme.onPrimaryContainer, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Free Accessible Tools',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'AI Text Summarizer & Talking Calculator — always free',
                                  style: TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onPrimaryContainer),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // ---- Payments coming soon banner ----
            Semantics(
              label:
                  'Online payments are coming soon. You can still browse every course, add it to your wishlist, and ask to be notified.',
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ExcludeSemantics(
                  child: Row(
                    children: [
                      Icon(Icons.rocket_launch_outlined, color: Theme.of(context).colorScheme.onSecondaryContainer),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Online Payments Coming Soon — browse freely, wishlist your favourites!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // ---- Category grid ----
            Text('Browse Categories', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.5,
              children: CatalogData.categories.map((category) {
                final count = CatalogData.byCategory(category.id).length;
                return Semantics(
                  button: true,
                  label: '${category.name}, $count courses',
                  child: Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CategoryListingScreen(category: category)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: ExcludeSemantics(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(_categoryIcons[category.id] ?? Icons.school_outlined,
                                  size: 28, color: Theme.of(context).colorScheme.primary),
                              const SizedBox(height: 8),
                              Text(
                                category.name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 2),
                              Text('$count courses', style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 28),

            // ---- Bestseller combo strip ----
            Text('Bestseller Combo Programs', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            SizedBox(
              height: 210,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bestsellers.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final course = bestsellers[index];
                  return SizedBox(
                    width: 260,
                    child: CourseCard(
                      course: course,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => CourseDetailScreen(course: course)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
