/// Core data models for Accessible AI Academy — a course marketplace app.

/// One of the 9 course categories used throughout the app (plus the
/// separate "Bestseller Combo Programs" strip on Home).
class CourseCategory {
  final String id;
  final String name;

  const CourseCategory({required this.id, required this.name});
}

/// A single paid course, matching the master plan's minimum data fields:
/// id, name, category, duration, price, tagline, syllabus, isBestseller,
/// isComboProgram.
class Course {
  final String id;
  final String name;
  final String categoryId;
  final String duration;
  final int priceInInr;
  final String tagline;
  final List<String> syllabus;
  final bool isBestseller;
  final bool isComboProgram;

  const Course({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.duration,
    required this.priceInInr,
    required this.tagline,
    required this.syllabus,
    this.isBestseller = false,
    this.isComboProgram = false,
  });

  String get formattedPrice {
    // Simple thousands-separator formatting for INR, e.g. 9999 -> "9,999".
    final s = priceInInr.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 2 == 1 && posFromEnd != s.length) {
        // Indian digit grouping: last 3 digits, then groups of 2.
      }
    }
    // Use a straightforward Indian-style grouping implementation instead:
    return _indianGrouping(priceInInr);
  }

  static String _indianGrouping(int value) {
    final str = value.toString();
    if (str.length <= 3) return str;
    final lastThree = str.substring(str.length - 3);
    var rest = str.substring(0, str.length - 3);
    final groups = <String>[];
    while (rest.length > 2) {
      groups.insert(0, rest.substring(rest.length - 2));
      rest = rest.substring(0, rest.length - 2);
    }
    if (rest.isNotEmpty) groups.insert(0, rest);
    return '${groups.join(',')},$lastThree';
  }
}

/// A logged "Buy Now" tap, kept locally for demand tracking until a real
/// payment gateway is wired in (see PaymentGatewayService).
class BuyNowLogEntry {
  final String courseId;
  final DateTime timestamp;

  const BuyNowLogEntry({required this.courseId, required this.timestamp});

  Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'timestamp': timestamp.toIso8601String(),
      };

  factory BuyNowLogEntry.fromJson(Map<String, dynamic> json) => BuyNowLogEntry(
        courseId: json['courseId'],
        timestamp: DateTime.parse(json['timestamp']),
      );
}

/// A learner's request to be notified once real payments go live.
class NotifyMeRequest {
  final String courseId;
  final DateTime requestedAt;

  const NotifyMeRequest({required this.courseId, required this.requestedAt});

  Map<String, dynamic> toJson() => {
        'courseId': courseId,
        'requestedAt': requestedAt.toIso8601String(),
      };

  factory NotifyMeRequest.fromJson(Map<String, dynamic> json) => NotifyMeRequest(
        courseId: json['courseId'],
        requestedAt: DateTime.parse(json['requestedAt']),
      );
}
