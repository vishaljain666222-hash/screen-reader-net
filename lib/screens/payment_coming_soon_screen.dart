import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import '../services/payment_gateway_service.dart';
import '../services/wishlist_service.dart';

class PaymentComingSoonScreen extends StatefulWidget {
  final Course course;

  const PaymentComingSoonScreen({super.key, required this.course});

  @override
  State<PaymentComingSoonScreen> createState() => _PaymentComingSoonScreenState();
}

class _PaymentComingSoonScreenState extends State<PaymentComingSoonScreen> {
  bool _notifyRequested = false;
  bool _checkingStatus = true;

  @override
  void initState() {
    super.initState();
    DemandTrackingService().hasRequestedNotify(widget.course.id).then((requested) {
      if (mounted) setState(() {
        _notifyRequested = requested;
        _checkingStatus = false;
      });
    });
  }

  Future<void> _notifyMe() async {
    await DemandTrackingService().addNotifyMeRequest(widget.course.id);
    if (!mounted) return;
    setState(() => _notifyRequested = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You're on the list — we'll notify you when payments go live!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    final wishlist = context.watch<WishlistService>();
    final isWishlisted = wishlist.isWishlisted(course.id);

    return Scaffold(
      appBar: AppBar(title: const Text('Buy Now')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),
              Semantics(
                label: 'Payment for ${course.name}, price ${course.formattedPrice} rupees, is coming soon',
                child: ExcludeSemantics(
                  child: Icon(Icons.rocket_launch_outlined, size: 88, color: Theme.of(context).colorScheme.primary),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                course.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                '₹${course.formattedPrice} · ${course.duration}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Text(
                "Online payments are coming soon! We're putting the finishing touches on secure checkout.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: (_checkingStatus || _notifyRequested) ? null : _notifyMe,
                  icon: Icon(_notifyRequested ? Icons.check_circle : Icons.notifications_active_outlined),
                  label: Text(_notifyRequested ? "You're on the list" : 'Notify Me When Available'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => wishlist.toggle(course.id),
                  icon: Icon(isWishlisted ? Icons.favorite : Icons.favorite_border),
                  label: Text(isWishlisted ? 'Added to Wishlist' : 'Add to Wishlist'),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () async {
                  await launchUrl(Uri.parse('mailto:support@accessibleknowledgehub.example?subject=Enroll%20in%20${Uri.encodeComponent(course.name)}'));
                },
                child: const Text('Prefer to enrol manually? Contact us'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
