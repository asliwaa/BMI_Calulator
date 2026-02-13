import 'package:bmi_calculator/core/enums/unit_system.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/bmi_history_record.dart';

abstract class BmiRepository {
  Future<Either<Failure, Bmi>> calculateBmi({
    required double weightKg,
    required double heightCm,
  });

  Future<void> saveBmiResult(
    Bmi bmi,
    double weight,
    double height,
    UnitSystem unitSystem
  );

  Future<Either<Failure, List<BmiHistoryRecord>>> getHistory();
}