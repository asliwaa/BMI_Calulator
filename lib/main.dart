import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'features/bmi/presentation/pages/bmi_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const BmiCalculatorApp());
}


class MyBmiCalculatorApp extends StatelessWidget {
  const MyBmiCalculatorApp({super.key});

  @override Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BmiPage();
    );
  }
}