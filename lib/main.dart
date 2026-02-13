import 'package:bmi_calculator/features/bmi/presentation/bloc/bmi_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/bmi/presentation/pages/bmi_page.dart';
import 'core/app_colors.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Ustawiamy fabrykę bazy danych na wersję Webową
    databaseFactory = databaseFactoryFfiWeb;
  }

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
      
      home: BlocProvider(
        create: (_) => di.serviceLocator<BmiBloc>(),
        child: const BmiPage(),
      ),
    );
  }
}