import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'package:flutter_route_kit/main.dart';
import 'package:flutter_route_kit/widgets/widgets.dart';

void main() {
  testWidgets('Bottom navigation switches between the 3 screens', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome to Flutter Route Kit'), findsOneWidget);
    expect(find.byIcon(Icons.notifications_none), findsOneWidget);

    await tester.tap(find.byIcon(Icons.explore_outlined).last);
    await tester.pumpAndSettle();

    expect(
      find.text('Discovery screen. Browse sections or features here.'),
      findsOneWidget,
    );

    await tester.tap(find.byIcon(Icons.person_outline).last);
    await tester.pumpAndSettle();

    expect(
      find.text('Account screen. Manage user details and preferences here.'),
      findsOneWidget,
    );
  });

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
}
