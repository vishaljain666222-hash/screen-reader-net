# Screen Reader Academy

An accessible Android app for learning **NVDA, JAWS, and Narrator** — with
text-based courses for Microsoft Word, Excel, PowerPoint, and Google Chrome,
each ending in a quiz.

This is a complete Flutter source project. It is **not yet a compiled APK** —
this chat environment doesn't have the Android/Flutter SDK to build one. The
steps below take you from this code to a real, installable app.

## What's included

```
lib/
  models/models.dart          - Course, Lesson, Shortcut, Quiz data classes
  data/content_data.dart      - All course content (Word, Excel, PowerPoint, Chrome)
  services/auth_service.dart      - v1 on-device email/password accounts
  services/progress_service.dart  - Local quiz-score tracking (SharedPreferences)
  screens/
    splash_screen.dart
    auth/login_screen.dart, signup_screen.dart
    home_screen.dart          - search bar + course shortcuts
    course_detail_screen.dart - lesson list + best score + quiz entry
    lesson_screen.dart         - NVDA / JAWS / Narrator tabs with shortcuts
    quiz_screen.dart, quiz_result_screen.dart
    about_screen.dart, contact_screen.dart
  widgets/
    app_drawer.dart   - toggle nav: Home, About, Contact Us, Log Out
    course_card.dart
  main.dart
pubspec.yaml
```

### Features already built
- **Mandatory registration**: users can't reach Home without signing up or
  logging in. **v1 uses a simple on-device account system** (email/password
  stored, hashed, in SharedPreferences) so the app works immediately with
  zero backend setup. "Continue with Google" is present in the UI and shows
  a "coming soon" message — see "Adding real Google Sign-In" below to wire
  up the real thing later.
- **Toggle navigation drawer** with Home / About / Contact Us / Log Out.
- **Home screen** with a live search bar that filters courses as you type,
  plus shortcut cards for Word, Excel, PowerPoint, and Chrome.
- **Text-based lessons**, split per screen reader (NVDA / JAWS / Narrator)
  as separate tabs, each with an explanation plus a shortcut-key list.
- **End-of-course quizzes** (multiple choice, one question at a time, with
  immediate feedback) that save your best score locally so you can track
  progress over time.
- **Accessibility built in throughout**: `Semantics` labels on cards and
  shortcut tiles, live regions for feedback/errors so screen readers
  announce them automatically, 48dp minimum touch targets, and use of
  native accessible widgets (`RadioListTile`, `TextFormField`, `Drawer`)
  rather than custom-drawn controls wherever possible.

## Fastest path: build the APK with GitHub Actions (no local install needed)

This repo includes `.github/workflows/build.yml`, which builds a release
APK on GitHub's servers every time you push. To use it:

1. Push this project to a GitHub repository (empty repo, then upload/push
   all these files, including the hidden `.github` folder).
2. Go to the repo's **Actions** tab — a "Build Android APK" run should
   start automatically (or click **Run workflow** if not).
3. Once it finishes (a few minutes), open the run and download the
   **screenreader-academy-apk** artifact — that's your `app-release.apk`.
4. Transfer it to an Android phone (email, Drive, USB) and tap to install
   (you'll need to allow "install unknown apps" for whichever app you used
   to open it — Android will prompt you the first time).

No Flutter/Android SDK install needed on your own machine for this path.

## What you still need to do (only if building locally instead)

### 1. Install Flutter
Follow https://docs.flutter.dev/get-started/install for your OS, then run:
```
flutter doctor
```
and resolve anything it flags (Android SDK, licenses, etc).

### 2. Create the platform folders
This project currently only has the `lib/` (Dart) source and `pubspec.yaml`.
Generate the Android/iOS scaffolding with:
```
flutter create --org com.yourcompany --project-name screenreader_academy .
```
Run this **inside** the `screenreader_academy` folder — it will add the
missing `android/`, `ios/`, etc. folders without touching your `lib/` code.

### 3. Get dependencies
```
flutter pub get
```

### 4. (Optional, v2) Adding real Google Sign-In via Firebase
v1 doesn't need this — accounts already work on-device. Do this later, when
you want real "Continue with Google":
1. Create a project at https://console.firebase.google.com
2. Add an Android app to it using the package name you chose in step 2
   (`com.yourcompany.screenreader_academy`), download `google-services.json`,
   and place it in `android/app/`.
3. In the Firebase console, go to **Authentication → Sign-in method** and
   enable **Email/Password** and **Google**.
4. Install the FlutterFire CLI and run configuration:
   ```
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
   This generates `lib/firebase_options.dart`. Then uncomment the two
   Firebase lines at the top of `lib/main.dart`:
   ```dart
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   ```
5. For Google Sign-In on Android specifically, add your app's SHA-1
   (debug and release) fingerprints in the Firebase console under
   Project Settings → Your apps, or Google Sign-In will fail silently.

### 5. Run it
```
flutter run
```

### 6. Build a release APK
```
flutter build apk --release
```
The APK will be at `build/app/outputs/flutter-apk/app-release.apk`.
For the Play Store, build an `.aab` instead:
```
flutter build appbundle --release
```

## Testing accessibility
- **On device**: turn on TalkBack (Settings → Accessibility → TalkBack) and
  swipe through every screen — drawer, search, course cards, lesson tabs,
  shortcut list, and the quiz — confirming everything is reachable and
  announced sensibly.
- Check color contrast and touch target sizes with Android's
  **Accessibility Scanner** app.
- The quiz result and error messages use `Semantics(liveRegion: true)` so
  they're announced automatically — verify this with TalkBack rather than
  assuming it from the code.

## Extending the content
All course text lives in `lib/data/content_data.dart` as plain Dart objects
— no UI code changes are needed to add a new course, lesson, or quiz
question. To add a 5th course (say, Outlook), copy the shape of `_wordCourse`
and add it to the `courses` list at the top of the file.

## Extending progress tracking
`ProgressService` currently stores best quiz scores on-device only
(`shared_preferences`). If you want scores synced across devices, swap its
`load()`/`recordAttempt()` bodies to read/write a `users/{uid}/progress`
collection in Cloud Firestore (already added as a dependency in
`pubspec.yaml`) instead of `SharedPreferences`.

## Contact form
`contact_screen.dart` currently just shows a "message sent" confirmation
locally — wire the `_submit()` method to a real backend (e.g. a Cloud
Function that emails your support inbox, or a Firestore `contact_messages`
collection) before shipping.
