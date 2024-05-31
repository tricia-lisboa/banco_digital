import 'package:flutter_test/flutter_test.dart';

import 'package:banco_digital/main.dart';

void main() {
  testWidgets('Login to Principal screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(BancoDigitalApp());

    // Verify that we are on the login screen initially.
    expect(find.text('Login'), findsOneWidget);

    // Tap the 'Entrar' button and trigger a frame.
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    // Verify that we are on the principal screen.
    expect(find.text('Principal'), findsOneWidget);
  });
}
