import 'package:bmi_calculator/core/error/failure.dart';
import 'package:bmi_calculator/features/bmi/data/datasources/bmi_local_datasource.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:bmi_calculator/features/bmi/domain/repositories/bmi_repository.dart';
import 'package:dartz/dartz.dart';
import '../datasources/bmi_history_datasource.dart';
import '../../../../core/enums/unit_system.dart';

class BmiRepositoryImpl implements BmiRepository {
  final BmiLocalDatasource localDatasource;
  final BmiHistoryDataSource historyDataSource;

  BmiRepositoryImpl({
    required this.localDatasource,
    required this.historyDataSource,
  });

  @override Future<Either<Failure, Bmi>> calculateBmi({
    required double weightKg,
    required double heightCm,
  }) async {
    try {
      final result = await localDatasource.calculateBmi (
        weight: weightKg,
        height: heightCm,
      );
      return Right(result);
    } catch (e) {
      return Left(CalculationFailure());
    }
  }

  @override
  Future<void> saveBmiResult(Bmi bmi, double weight, double height, UnitSystem unitSystem) async {
    try {
      await historyDataSource.saveResult(bmi, weight, height, unitSystem);
    } catch (e) {
      print("Result saving error: $e");
    }
  }
}