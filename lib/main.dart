import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'features/bmi/presentation/pages/bmi_page.dart';
import 'core/app_colors.dart'; // Import kolorów

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData.dark().copyWith(
        primaryColor: AppColors.background,
        scaffoldBackgroundColor: AppColors.background,
        
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          centerTitle: true,
        ),
        
        cardTheme: CardThemeData(
          color: AppColors.cardBackground,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
      
      home: const BmiPage(),
    );
  }
}