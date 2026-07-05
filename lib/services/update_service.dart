import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

/// Describes an available update, if any.
class UpdateInfo {
  final String versionName; // e.g. "1.0.1"
  final String downloadUrl; // direct .apk download link
  final String releaseNotes;

  const UpdateInfo({
    required this.versionName,
    required this.downloadUrl,
    required this.releaseNotes,
  });
}

/// Checks GitHub Releases for a version newer than the one currently
/// installed. No backend of our own needed — GitHub's public Releases API
/// is free to call for a public repo and doesn't require a token for reads.
///
/// HOW THIS STAYS IN SYNC WITH RELEASES: every time the build workflow runs,
/// it publishes a new GitHub Release tagged like "v1.0.1" with the APK
/// attached. This service just asks "what's the latest tag?" and compares
/// it to the version baked into this build (from pubspec.yaml).
class UpdateService {
  static const _owner = 'vishaljain666222-hash';
  static const _repo = 'screen-reader-net';
  static const _releasesLatestUrl =
      'https://api.github.com/repos/$_owner/$_repo/releases/latest';

  Future<UpdateInfo?> checkForUpdate() async {
    try {
      final currentVersion = await _currentVersion();
      final response = await http
          .get(Uri.parse(_releasesLatestUrl), headers: {'Accept': 'application/vnd.github+json'})
          .timeout(const Duration(seconds: 8));

      if (response.statusCode != 200) return null;

      final Map<String, dynamic> json = jsonDecode(response.body);
      final tagName = (json['tag_name'] as String?) ?? '';
      final latestVersion = tagName.startsWith('v') ? tagName.substring(1) : tagName;
      if (latestVersion.isEmpty) return null;

      if (!_isNewer(latestVersion, currentVersion)) return null;

      final assets = (json['assets'] as List?) ?? [];
      String? downloadUrl;
      for (final asset in assets) {
        final name = asset['name'] as String? ?? '';
        if (name.endsWith('.apk')) {
          downloadUrl = asset['browser_download_url'] as String?;
          break;
        }
      }
      if (downloadUrl == null) return null;

      return UpdateInfo(
        versionName: latestVersion,
        downloadUrl: downloadUrl,
        releaseNotes: (json['body'] as String?)?.trim().isNotEmpty == true
            ? json['body'] as String
            : 'Bug fixes and improvements.',
      );
    } catch (_) {
      // Any network hiccup or unexpected shape just means "no update
      // detected right now" — never blocks the user from using the app.
      return null;
    }
  }

  Future<String> _currentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version; // versionName portion only, e.g. "1.0.0"
  }

  /// Simple dotted-version comparison ("1.2.10" > "1.2.9"), without pulling
  /// in a semver package for one small comparison.
  bool _isNewer(String remote, String local) {
    final r = remote.split('.').map((p) => int.tryParse(p) ?? 0).toList();
    final l = local.split('.').map((p) => int.tryParse(p) ?? 0).toList();
    final length = r.length > l.length ? r.length : l.length;
    for (var i = 0; i < length; i++) {
      final rv = i < r.length ? r[i] : 0;
      final lv = i < l.length ? l[i] : 0;
      if (rv != lv) return rv > lv;
    }
    return false;
  }
}
