import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:bmi_calculator/features/bmi/domain/repositories/bmi_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

class CalculateBmiUseCase {
  final BmiRepository repository;

  CalculateBmiUseCase(this.repository);

  Future<Either<Failure, Bmi>> execute ({
    required double weight,
    required double height,
  }) async {
    return await repository.calculateBmi(weightKg: weight, heightCm: height);
  }

}