import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'features/bmi/presentation/pages/bmi_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const BmiCalculatorApp());
}


class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({super.key});

  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BmiPage(),
    );
  }
}