import 'package:fitness_app/widgets/BottomNavBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 

void main() {
  testWidgets('CustomBottomNavigationBar builds correctly with given index', (WidgetTester tester) async {
    // Define a test key to identify the widget in the test environment
    const testKey = Key('custom-bottom-nav-bar');

    // Build the CustomBottomNavigationBar widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
           
          selectedIndex: 0,
          onItemTapped: (_) {},
        ),
      ),
    ));

    // Check if the CustomBottomNavigationBar is in the widget tree
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Correct item is selected based on selectedIndex', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 1, // Set to Profile tab
          onItemTapped: (_) {},
        ),
      ),
    ));

    // Check if the 'Profile' tab is selected
    expect(tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar)).currentIndex, 1);
  });

  testWidgets('onItemTapped callback is called when an item is tapped', (WidgetTester tester) async {
    int tappedIndex = -1;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: 0,
          onItemTapped: (index) {
            tappedIndex = index; // Update tappedIndex on tap
          },
        ),
      ),
    ));

    // Tap on the 'Profile' tab
    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle(); // Rebuild the widget after the state change

    // Check if the tappedIndex is updated to the index of the 'Profile' tab
    expect(tappedIndex, 1);
  });
}
