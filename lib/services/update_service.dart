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

enum UpdateCheckStatus { updateAvailable, upToDate, error }

class UpdateCheckResult {
  final UpdateCheckStatus status;
  final UpdateInfo? info;
  final String? errorMessage;
  final String currentVersion;

  const UpdateCheckResult({
    required this.status,
    required this.currentVersion,
    this.info,
    this.errorMessage,
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

  /// Full result, including *why* no update was found (up to date vs. an
  /// actual error) — used by the manual "Check for Updates" button so the
  /// user always gets a clear answer instead of silence.
  Future<UpdateCheckResult> checkForUpdateVerbose() async {
    final currentVersion = await _currentVersion();
    try {
      final response = await http
          .get(Uri.parse(_releasesLatestUrl), headers: {'Accept': 'application/vnd.github+json'})
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        return UpdateCheckResult(
          status: UpdateCheckStatus.error,
          currentVersion: currentVersion,
          errorMessage: 'Could not check for updates right now (server said ${response.statusCode}).',
        );
      }

      final Map<String, dynamic> json = jsonDecode(response.body);
      final tagName = (json['tag_name'] as String?) ?? '';
      final latestVersion = tagName.startsWith('v') ? tagName.substring(1) : tagName;
      if (latestVersion.isEmpty) {
        return UpdateCheckResult(
          status: UpdateCheckStatus.error,
          currentVersion: currentVersion,
          errorMessage: 'Could not read the latest version information.',
        );
      }

      if (!_isNewer(latestVersion, currentVersion)) {
        return UpdateCheckResult(status: UpdateCheckStatus.upToDate, currentVersion: currentVersion);
      }

      final assets = (json['assets'] as List?) ?? [];
      String? downloadUrl;
      for (final asset in assets) {
        final name = asset['name'] as String? ?? '';
        if (name.endsWith('.apk')) {
          downloadUrl = asset['browser_download_url'] as String?;
          break;
        }
      }
      if (downloadUrl == null) {
        return UpdateCheckResult(
          status: UpdateCheckStatus.error,
          currentVersion: currentVersion,
          errorMessage: 'Found a newer version but no APK file was attached to it.',
        );
      }

      return UpdateCheckResult(
        status: UpdateCheckStatus.updateAvailable,
        currentVersion: currentVersion,
        info: UpdateInfo(
          versionName: latestVersion,
          downloadUrl: downloadUrl,
          releaseNotes: (json['body'] as String?)?.trim().isNotEmpty == true
              ? json['body'] as String
              : 'Bug fixes and improvements.',
        ),
      );
    } catch (e) {
      return UpdateCheckResult(
        status: UpdateCheckStatus.error,
        currentVersion: currentVersion,
        errorMessage: 'Could not check for updates — check your internet connection and try again.',
      );
    }
  }

  /// Simple version used for the silent, automatic check on app open —
  /// returns null for both "up to date" and "error" so it never bothers
  /// the user unless there's actually something to install.
  Future<UpdateInfo?> checkForUpdate() async {
    final result = await checkForUpdateVerbose();
    return result.status == UpdateCheckStatus.updateAvailable ? result.info : null;
  }

  Future<String> _currentVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.version;
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
