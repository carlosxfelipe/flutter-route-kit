import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_route_kit/main.dart';
import 'package:flutter_route_kit/router/auth_session.dart';
import 'package:flutter_route_kit/screens/screens.dart';
import 'package:flutter_route_kit/theme/theme.dart';
import 'package:flutter_route_kit/widgets/widgets.dart';

void main() {
  testWidgets(
    'Login redirects to Home and bottom navigation switches screens',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
      expect(find.text('Create account'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'user@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        '123456',
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
      await tester.pumpAndSettle();

      expect(find.text('Welcome to Flutter Route Kit'), findsOneWidget);
      expect(find.byIcon(Icons.notifications_none), findsOneWidget);

      await tester.tap(find.byIcon(Icons.explore_outlined).last);
      await tester.pumpAndSettle();

      expect(find.text('AppButton Variants'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.person_outline).last);
      await tester.pumpAndSettle();

      expect(
        find.text('Account screen. Manage user details and preferences here.'),
        findsOneWidget,
      );
    },
  );

  testWidgets('AppHeader renders title, rightIcon, badge and actions', (
    WidgetTester tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppHeader(
            title: 'Dashboard',
            rightIcon: Icons.settings_outlined,
            rightIconBadgeCount: 3,
            onRightIconPressed: () => tapped = true,
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.byType(Badge), findsOneWidget);
    expect(find.byIcon(Icons.notifications_none), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    expect(tapped, isTrue);
  });

  testWidgets('AppHeader caps notification badge count at 9+ by default', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: AppHeader(
            title: 'Notifications',
            rightIcon: Icons.notifications_none,
            rightIconBadgeCount: 334,
          ),
        ),
      ),
    );

    expect(find.text('9+'), findsOneWidget);
    expect(find.text('334'), findsNothing);
  });

  testWidgets('MyApp follows system brightness for light and dark themes', (
    WidgetTester tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    final darkContext = tester.element(find.byType(NavigationBar));
    expect(Theme.of(darkContext).brightness, Brightness.dark);

    tester.platformDispatcher.platformBrightnessTestValue = Brightness.light;
    await tester.pumpAndSettle();

    final lightContext = tester.element(find.byType(NavigationBar));
    expect(Theme.of(lightContext).brightness, Brightness.light);
  });

  testWidgets('AppSearchHeader emits changes and clears input', (
    WidgetTester tester,
  ) async {
    String? latestQuery;
    var cleared = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppSearchHeader(
            hintText: 'Search routes...',
            onChanged: (value) => latestQuery = value,
            onClear: () => cleared = true,
          ),
        ),
      ),
    );

    expect(find.text('Search routes...'), findsOneWidget);
    expect(find.byIcon(Icons.close), findsNothing);

    await tester.enterText(find.byType(TextField), 'profile');
    await tester.pump();

    expect(latestQuery, 'profile');
    expect(find.byIcon(Icons.close), findsOneWidget);

    await tester.tap(find.byIcon(Icons.close));
    await tester.pump();

    expect(latestQuery, '');
    expect(cleared, isTrue);
    expect(find.byIcon(Icons.close), findsNothing);
  });

  testWidgets('AppButton renders variants, icons and disabled/loading states', (
    WidgetTester tester,
  ) async {
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              AppButton(
                label: 'Continue',
                leftIcon: Icons.arrow_back,
                rightIcon: Icons.arrow_forward,
                variant: AppButtonVariant.outlined,
                onPressed: () => taps++,
              ),
              AppButton(
                label: 'Disabled',
                isDisabled: true,
                onPressed: () => taps++,
              ),
              AppButton(
                label: 'Loading',
                isLoading: true,
                onPressed: () => taps++,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Continue'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.tap(find.text('Continue'));
    await tester.tap(find.text('Disabled'));
    await tester.tap(find.byType(CircularProgressIndicator));
    await tester.pump();

    expect(taps, 1);
  });

  testWidgets('AppListCard renders props and handles onTap', (
    WidgetTester tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppListCard(
            icon: Icons.settings_outlined,
            title: 'Settings',
            subtitle: 'App preferences',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('App preferences'), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);

    await tester.tap(find.text('Settings'));
    expect(tapped, isTrue);
  });

  testWidgets('AppBannerCard renders title, description and onTap', (
    WidgetTester tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppBannerCard(
            icon: Icons.info_outline,
            title: 'Announcement',
            description: 'New features are available.',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Announcement'), findsOneWidget);
    expect(find.text('New features are available.'), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);

    await tester.tap(find.text('Announcement'));
    expect(tapped, isTrue);
  });

  test('AuthSession toggles authentication state and notifies listeners', () {
    final session = AuthSession();
    var notifications = 0;
    session.addListener(() => notifications++);

    expect(session.isAuthenticated, isFalse);

    session.signIn();
    expect(session.isAuthenticated, isTrue);
    expect(notifications, 1);

    session.signIn();
    expect(notifications, 1);

    session.signOut();
    expect(session.isAuthenticated, isFalse);
    expect(notifications, 2);
  });

  testWidgets('LoginScreen blocks pop when form has unsaved input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(
      tester.widget<PopScope<Object?>>(find.byType(PopScope<Object?>)).canPop,
      isTrue,
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'user@example.com',
    );
    await tester.pump();

    expect(
      tester.widget<PopScope<Object?>>(find.byType(PopScope<Object?>)).canPop,
      isFalse,
    );

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(find.text('Discard credentials?'), findsOneWidget);
  });

  testWidgets('AppEmptyState renders content and triggers action callback', (
    WidgetTester tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppEmptyState(
            icon: Icons.inbox_outlined,
            title: 'Nothing here',
            description: 'Add an item to get started.',
            actionLabel: 'Add item',
            onActionPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Nothing here'), findsOneWidget);
    expect(find.text('Add an item to get started.'), findsOneWidget);

    await tester.tap(find.text('Add item'));
    expect(tapped, isTrue);
  });

  testWidgets('AppTextField toggles password visibility', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: AppTextField(
            label: 'Secret',
            obscureText: true,
            enableVisibilityToggle: true,
          ),
        ),
      ),
    );

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('showAppBottomSheet displays title and child', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => AppButton(
              label: 'Open',
              onPressed: () => showAppBottomSheet<void>(
                context: context,
                title: 'Options',
                child: const Text('Sheet body'),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();

    expect(find.text('Options'), findsOneWidget);
    expect(find.text('Sheet body'), findsOneWidget);
  });

  testWidgets('AppAvatar extracts initials and shows fallback icon', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Row(
            children: [
              AppAvatar(name: 'Carlos Araujo'),
              AppAvatar(),
            ],
          ),
        ),
      ),
    );

    expect(find.text('CA'), findsOneWidget);
    expect(find.byIcon(Icons.person_outline), findsOneWidget);
  });

  testWidgets('ThemeSwitcher updates themeModeNotifier with English options', (
    WidgetTester tester,
  ) async {
    themeModeNotifier.value = ThemeMode.system;

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: ThemeSwitcher())),
    );

    expect(find.text('Light'), findsOneWidget);
    expect(find.text('Dark'), findsOneWidget);
    expect(find.text('System'), findsOneWidget);

    await tester.tap(find.text('Dark'));
    await tester.pump();
    expect(themeModeNotifier.value, ThemeMode.dark);
    expect(themeModeNotifier.value.label, 'Dark');

    await tester.tap(find.text('Light'));
    await tester.pump();
    expect(themeModeNotifier.value, ThemeMode.light);
    expect(themeModeNotifier.value.label, 'Light');

    await tester.tap(find.text('System'));
    await tester.pump();
    expect(themeModeNotifier.value, ThemeMode.system);
    expect(themeModeNotifier.value.label, 'System');
  });
}
