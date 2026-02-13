import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/enums/unit_system.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bmi.dart';
import '../repositories/bmi_repository.dart';

//Bridge between Presentation and Data
class CalculateBmiUseCase implements UseCase<Bmi, BmiParams> {
  final BmiRepository repository;

  CalculateBmiUseCase(this.repository);

  @override Future<Either<Failure, Bmi>> call(BmiParams params) async {
    //Check for zeros
    if (params.weight <= 0 || params.height <= 0) {
      return Left(CalculationFailure(message: "Height and weight must be greater than zero."));
    }

    double weightKg = params.weight;
    double heightCm = params.height;

    if (params.unitSystem == UnitSystem.imperial) {
      weightKg = params.weight / 2.20462;
      heightCm = params.height * 2.54;
    }
    
    final result = await repository.calculateBmi(
      weightKg: weightKg,
      heightCm: heightCm,
    );

    return result.fold(
      (failure) => Left(failure),
      (bmi) async {
        final roundedBmi = Bmi(
          bmiValue: double.parse(bmi.bmiValue.toStringAsFixed(2)),
          category: bmi.category,
        );

        await repository.saveBmiResult(roundedBmi, params.weight, params.height, params.unitSystem);

        return Right(roundedBmi);
      },
    );
  }
}

class BmiParams extends Equatable {
  final double weight;
  final double height;
  final UnitSystem unitSystem; // Dodajemy Enum

  const BmiParams({
    required this.weight,
    required this.height,
    required this.unitSystem,
  });

  @override
  List<Object?> get props => [weight, height, unitSystem];
}