# Flutter Route Kit

[![Flutter](https://img.shields.io/badge/Flutter-3.50.0-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.14.0-0175C2?logo=dart&logoColor=white)](https://dart.dev)

Flutter starter template with `go_router`, bottom navigation shell, reusable Material 3 components, authentication flow, and system light/dark themes.

## Features & Included Components

- **Navigation:** `go_router` persistent bottom bar shell (`Home`, `Explore`, `Profile`).
- **Auth Flow:** `LoginScreen` with form validation, `PopScope`, and toggleable session.
- **Reusable Widgets:** `AppHeader`, `SearchHeader`, `AppButton`, `AppListCard`, and `AppBannerCard`.
- **Demos & Theming:** Interactive component showcase in `Explore` and automatic system Light/Dark mode.

## Setup

Install dependencies after cloning:

```bash
flutter pub get
```

## Use `lib/` in Another Flutter Project

Because `lib/` uses `go_router` and `material_ui` (with relative imports so it works regardless of your package name), install them first in your target project:

```bash
flutter pub add go_router material_ui
```

Then replace `lib/` using `degit`:

```bash
rm -rf lib && npx --yes degit carlosxfelipe/flutter-route-kit/lib lib --force
```

> If you created the project with `flutter create`, update or remove the default counter test in `test/widget_test.dart`, since `MyHomePage` is replaced by this template.

## Authentication Toggle

By default, the app starts on `/login` (`LoginScreen` accepts any non-empty email and password). To skip the login flow and start directly on `/home`, change `_requireAuth` in `lib/router/app_router.dart`:

```dart
const bool _requireAuth = false;
```

## Running the App

List available devices and IDs:

```bash
flutter devices
```

Run on Web (Chrome):

```bash
flutter run -d chrome
```

Launch the iOS Simulator first if none is running:

```bash
flutter emulators --launch apple_ios_simulator
```

Run on iOS (matches an iPhone simulator or connected iPhone by name prefix):

```bash
flutter run -d iphone
```

Launch the Android emulator (`Medium_Phone`):

```bash
flutter emulators --launch Medium_Phone
```

Run on Android (or any specific device by ID from `flutter devices`):

```bash
flutter run -d <device-id>
```

## Formatting, Lint & Tests

Format Dart code:

```bash
dart format .
```

Run static analysis / lint:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```
