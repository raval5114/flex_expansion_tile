import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_expansion_tile/flex_expansion_tile.dart';

void main() {
  testWidgets('FlexExpansionTile expands and collapses', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FlexExpansionTile(
            title: Text('Test Tile'),
            children: [Text('Child')],
          ),
        ),
      ),
    );

    expect(find.text('Child'), findsNothing);
    await tester.tap(find.text('Test Tile'));
    await tester.pumpAndSettle();
    expect(find.text('Child'), findsOneWidget);
  });
}
