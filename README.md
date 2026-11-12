# flutter_route_kit

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

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

Format shell scripts with `shfmt`:

```bash
find . -maxdepth 3 -name "*.sh" -not -path "*/.*" -not -path "./build/*" -exec shfmt -i 2 -w {} +
```

Or without a local `shfmt` installation (using `uvx`):

```bash
find . -maxdepth 3 -name "*.sh" -not -path "*/.*" -not -path "./build/*" -exec uvx --from shfmt-py shfmt -i 2 -w {} +
```
