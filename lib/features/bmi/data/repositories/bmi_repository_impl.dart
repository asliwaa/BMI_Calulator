import 'package:bmi_calculator/core/error/failure.dart';
import 'package:bmi_calculator/features/bmi/data/datasources/bmi_local_datasource.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:bmi_calculator/features/bmi/domain/repositories/bmi_repository.dart';
import 'package:dartz/dartz.dart';

class BmiRepositoryImpl implements BmiRepository {
  final BmiLocalDatasource localDatasource;

  BmiRepositoryImpl({
    required this.localDatasource
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
}