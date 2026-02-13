import 'package:bmi_calculator/core/error/failure.dart';
import 'package:bmi_calculator/features/bmi/data/datasources/bmi_local_datasource.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi_history_record.dart';
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

  @override
  Future<Either<Failure, List<BmiHistoryRecord>>> getHistory() async {
    try {
      final data = await historyDataSource.getHistory();
      
      final records = data.map((e) {
        final unitString = e['unit_system'] as String;
        final unitEnum = unitString == "UnitSystem.metric" ? UnitSystem.metric : UnitSystem.imperial;

        return BmiHistoryRecord(
          id: e['id'] as int,
          bmiValue: e['bmi_value'] as double,
          category: e['category'] as String,
          weight: e['weight'] as double,
          height: e['height'] as double,
          unitSystem: unitEnum,
        );
      }).toList();

      return Right(records);
    } catch (e) {
      return Left(CacheFailure(message: "DB error"));
    }
  }
}