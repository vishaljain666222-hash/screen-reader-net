# Accessible AI Academy

A Flutter course-marketplace app for Accessible Knowledge Hub — browse
51 real courses across 9 categories, view full syllabi, and tap Buy Now.
Online payments aren't live yet, so Buy Now currently leads to a polished
"Payment Coming Soon" screen with Notify Me / Add to Wishlist actions.

This app builds and ships via GitHub Actions — see below for how updates
get released. Existing installs get an in-app "Update available" popup
automatically; nothing about that mechanism changed in this rebuild.

## What's in this version

- **Splash → Onboarding (3 slides, first run only) → Login/Sign-up → Main app**
- **Bottom navigation**: Home, Categories, Tools, Wishlist, Profile
- **Home**: search bar, "Free Accessible Tools" banner, 9-category grid, Bestseller Combo Programs strip, "Payments Coming Soon" banner
- **Accessible Tools** (always free, no purchase needed): Read Aloud (text-to-speech reader), Talking Calculator, Screen Reader Shortcuts quick-reference (NVDA/JAWS/Narrator/TalkBack/VoiceOver), Color Contrast Checker, and quick links to the phone's system accessibility settings
- **Category Listing** → **Course Detail** (full syllabus, duration, price, sticky Buy Now, Share, Wishlist heart — with spoken "Added/Removed from wishlist" announcements)
- **Buy Now → Payment Coming Soon screen** (Notify Me / Add to Wishlist / contact-us fallback)
- **Search** across all 51 courses by name, tagline, or category
- **Wishlist / My Courses**, **Profile** (with Accessibility Settings + About/Contact/Support)
- **Accessibility Settings**: text-size slider (up to 200%), High Contrast Mode, screen-reader hints toggle
- **PaymentGatewayService**: a clearly stubbed interface (`initiatePayment` / `verifyPayment` / `refund`) ready for a real provider (Razorpay/PayU/Stripe/Google Play Billing) later, with every Buy Now tap logged locally for demand tracking
- **In-app update checker** (unchanged): checks GitHub Releases on open, plus a manual "Check for Updates" button in About

## Course catalog

All 51 courses live in `lib/data/catalog_data.dart` as plain Dart data —
id, name, category, duration, price, tagline, and full syllabus per
course. Nothing is placeholder/sample content; it's transcribed directly
from the Accessible AI Academy Master Plan.

To add, remove, or edit a course, edit that file directly — no other code
needs to change. Categories are defined in `CatalogData.categories` at the
top of the same file.

## Releasing an update (keeps existing users' auto-update working)

This repo's `.github/workflows/build.yml` is triggered manually
(workflow_dispatch) with three inputs: `version_name` (e.g. `2.0.0`),
`version_code` (must increase each time), and `release_notes`. It:

1. Scaffolds the Android platform folder fresh via `flutter create`
2. Signs the release APK with the persistent keystore (stored as repo secrets)
3. Sets the app's display name and ensures the internet permission is present
4. Publishes a GitHub Release tagged `vX.Y.Z` with the signed APK attached

Existing users' installed app checks `GET /repos/.../releases/latest` on
open (see `lib/services/update_service.dart`) and shows an "Update
available" popup pointing at that release's APK — so as long as each
release uses a higher `version_name` than the last, nobody needs to
manually reinstall.

## Local development

```
flutter create --platforms=android --org com.screenreaderacademy.app .
flutter pub get
flutter run
```

(The `android/` and `ios/` folders aren't committed — the CI workflow
regenerates them fresh on every build, per Flutter's own recommended
approach for retrofitting platforms onto an existing project.)

## Not yet implemented (see Master Plan Section 9 — Future Roadmap)

- Real payment gateway integration behind `PaymentGatewayService`
- Push notifications for the Notify Me list once payments go live
- Certificates of completion / learning-progress tracker
- Hindi and other regional language support
- Google Sign-In (currently a "coming soon" placeholder — see
  `lib/services/auth_service.dart` for the local-account v1 implementation
  and the commented-out Firebase upgrade path)
