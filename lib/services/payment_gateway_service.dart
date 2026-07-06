import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

/// Result of a payment attempt. Even in the stub implementation, real
/// integrations (Razorpay/PayU/Stripe/Google Play Billing) will return
/// something shaped like this, so callers don't need to change later.
class PaymentResult {
  final bool success;
  final String message;
  final String? transactionId;

  const PaymentResult({required this.success, required this.message, this.transactionId});
}

/// The payment gateway is intentionally NOT implemented yet — see the
/// Master Plan, Section 6.2. This interface is the seam a real provider
/// (Razorpay, PayU, Stripe, Google Play Billing) plugs into later without
/// any other part of the app needing to change.
abstract class PaymentGatewayService {
  Future<PaymentResult> initiatePayment(Course course);
  Future<PaymentResult> verifyPayment(String transactionId);
  Future<PaymentResult> refund(String transactionId);
}

/// Stub implementation used until a real gateway is wired in. Every method
/// clearly fails with an explanatory message rather than silently
/// pretending to succeed, so it can never be mistaken for a working
/// checkout during testing.
class StubPaymentGatewayService implements PaymentGatewayService {
  @override
  Future<PaymentResult> initiatePayment(Course course) async {
    return const PaymentResult(
      success: false,
      message: 'Online payments are not enabled yet. This is a placeholder for the real payment gateway.',
    );
  }

  @override
  Future<PaymentResult> verifyPayment(String transactionId) async {
    return const PaymentResult(success: false, message: 'No real payment gateway is connected yet.');
  }

  @override
  Future<PaymentResult> refund(String transactionId) async {
    return const PaymentResult(success: false, message: 'No real payment gateway is connected yet.');
  }
}

/// Logs every "Buy Now" tap (course id + timestamp) locally, and stores
/// "Notify Me" requests — so real purchase-intent data is already being
/// collected before checkout goes live, per the Master Plan.
class DemandTrackingService {
  static const _buyNowLogKey = 'buy_now_log_v1';
  static const _notifyMeKey = 'notify_me_requests_v1';

  Future<void> logBuyNowTap(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = await _loadBuyNowLog(prefs);
    entries.add(BuyNowLogEntry(courseId: courseId, timestamp: DateTime.now()));
    await prefs.setString(_buyNowLogKey, jsonEncode(entries.map((e) => e.toJson()).toList()));
  }

  Future<List<BuyNowLogEntry>> _loadBuyNowLog(SharedPreferences prefs) async {
    final raw = prefs.getString(_buyNowLogKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => BuyNowLogEntry.fromJson(e)).toList();
  }

  Future<void> addNotifyMeRequest(String courseId) async {
    final prefs = await SharedPreferences.getInstance();
    final requests = await loadNotifyMeRequests();
    if (requests.any((r) => r.courseId == courseId)) return; // already requested
    requests.add(NotifyMeRequest(courseId: courseId, requestedAt: DateTime.now()));
    await prefs.setString(_notifyMeKey, jsonEncode(requests.map((e) => e.toJson()).toList()));
  }

  Future<List<NotifyMeRequest>> loadNotifyMeRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_notifyMeKey);
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => NotifyMeRequest.fromJson(e)).toList();
  }

  Future<bool> hasRequestedNotify(String courseId) async {
    final requests = await loadNotifyMeRequests();
    return requests.any((r) => r.courseId == courseId);
  }
}
