import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_route_kit/main.dart';
import 'package:flutter_route_kit/widgets/widgets.dart';

void main() {
  testWidgets(
    'Login redirects to Home and bottom navigation switches screens',
    (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);

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

  testWidgets('AppHeader renders title, rightIcon and actions', (
    WidgetTester tester,
  ) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppHeader(
            title: 'Dashboard',
            rightIcon: Icons.settings_outlined,
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
    expect(find.byIcon(Icons.notifications_none), findsOneWidget);
    expect(find.byIcon(Icons.settings_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.settings_outlined));
    expect(tapped, isTrue);
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

  testWidgets('SearchHeader emits changes and clears input', (
    WidgetTester tester,
  ) async {
    String? latestQuery;
    var cleared = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: SearchHeader(
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
}
