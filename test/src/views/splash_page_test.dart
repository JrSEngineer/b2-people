import 'package:b2_people/src/app_module.dart';
import 'package:b2_people/src/app_widget.dart';
import 'package:b2_people/src/views/home_page.dart';
import 'package:b2_people/src/views/splash_page.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    'splash page should',
    () {
      testWidgets(
        'last for 3 seconds and navigate to home page',
        (tester) async {
          await tester.pumpWidget(
            ModularApp(
              module: AppModule(),
              child: const AppWidget(),
            ),
          );

          await tester.pump();

          expect(find.byType(SplashPage), findsOneWidget);

          await tester.pump(const Duration(seconds: 3));

          await tester.pumpAndSettle();

          expect(find.byType(HomePage), findsOneWidget);
        },
      );
    },
  );
}
