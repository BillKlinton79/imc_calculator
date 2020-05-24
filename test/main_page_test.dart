import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imc_calculator/main.dart';

void main() {
  testWidgets('Renders', (WidgetTester tester) async {
    await _createWidget(tester);

    Finder appBarText = find.text('Calculadora de IMC');
    Finder icon = find.byIcon(Icons.person_outline);
    Finder textFormFieldPesoText = find.text("Peso (Kg)");
    Finder textFormFieldAlturaText = find.text("Altura (Cm)");
    Finder raisedButtonText = find.text("Calcular");
    Finder resultText = find.text("Informe seus dados!");

    expect(appBarText, findsOneWidget);
    expect(icon, findsOneWidget);
    expect(textFormFieldPesoText, findsOneWidget);
    expect(textFormFieldAlturaText, findsOneWidget);
    expect(raisedButtonText, findsOneWidget);
    expect(resultText, findsOneWidget);
  });

  testWidgets('Button Calcular Valid', (tester) async {
    await _createWidget(tester);

    Finder resultText = find.text("Informe seus dados!");
    expect(resultText, findsOneWidget);

    await tester.enterText(find.byKey(Key("peso")), "73");
    await tester.enterText(find.byKey(Key("altura")), "1.85");
    await tester.tap(find.text("Calcular"));

    await tester.pump();

    expect(resultText, findsNothing);
  });

  testWidgets('Peso required', (tester) async {
    await _createWidget(tester);

    await tester.enterText(
        find.widgetWithText(TextFormField, "Altura (Cm)"), "1.89");
    await tester.tap(find.text("Calcular"));
    await tester.pump();

    Finder requiredText = find.text("Insira seu peso!!");

    expect(requiredText, findsOneWidget);
  });

  testWidgets('Altura required', (tester) async {
    await _createWidget(tester);

    await tester.enterText(
        find.widgetWithText(TextFormField, "Peso (Kg)"), "1.89");

    await tester.tap(find.text("Calcular"));

    await tester.pump();

    Finder requiredText = find.text("Insira sua altura!!");

    expect(requiredText, findsOneWidget);
  });

  testWidgets('Reset Fields', (tester) async {
    await _createWidget(tester);

    Finder resultText = find.text("Informe seus dados!");
    expect(resultText, findsOneWidget);

    await tester.enterText(find.byKey(Key("peso")), "73");
    await tester.enterText(find.byKey(Key("altura")), "1.85");
    await tester.tap(find.text("Calcular"));

    await tester.pump();

    expect(resultText, findsNothing);

    await tester.tap(find.byIcon(Icons.refresh));

    await tester.pump();

    expect(find.text("73"), findsNothing);
    expect(find.text("1.85"), findsNothing);
    expect(resultText, findsOneWidget);
  });
}

Future<void> _createWidget(WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(
    title: "Flutter Widget Test Demo",
    home: Home(),
  ));

  await tester.pump();
}
