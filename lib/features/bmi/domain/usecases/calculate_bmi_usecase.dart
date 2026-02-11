import 'package:bmi_calculator/core/usecases/usecase.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:bmi_calculator/features/bmi/domain/repositories/bmi_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';

class CalculateBmiUseCase implements UseCase<Bmi, BmiParams> {
  final BmiRepository repository;

  CalculateBmiUseCase(this.repository);

  @override Future<Either<Failure, Bmi>> call(BmiParams params) async {
    return await repository.calculateBmi(weightKg: params.weight, heightCm: params.height);
  }
}

class BmiParams extends Equatable {
  final double weight;
  final double height;

  const BmiParams({
    required this.weight,
    required this.height
  });

  @override List<Object?> get props => [weight, height];
}