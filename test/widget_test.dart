import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:pocket/app.dart';

void main() {
  testWidgets('Pocket app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: PocketApp()));

    expect(find.byType(PocketApp), findsOneWidget);
  });
}
