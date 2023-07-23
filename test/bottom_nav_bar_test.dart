import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bottom_nav_bar/bottom_nav_bar.dart';

void main() {
  group('BottomNavBar', () {
    testWidgets('calls onTap callback with correct index when item is tapped',
      (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BottomNavBar(
              selectedIndex: 0,
              backgroundColor: Colors.blue,
              selectedColor: Colors.red,
              items: [
                BottomNavBarItem(icon: Icons.home, label: 'Home'),
                BottomNavBarItem(icon: Icons.search, label: 'Search'),
                BottomNavBarItem(icon: Icons.person, label: 'Profile'),
              ],
              onTap: (index) {
                tappedIndex = index;
              },
            ),
          ),
        ),
      );

      // Tap on the 'Search' item.
      await tester.tap(find.byIcon(Icons.search));
      // Rebuild the widget after the state has changed.
      await tester.pump();

      // Check that onTap callback is called with the right index.
      expect(tappedIndex, 1);
    });
  });
}
