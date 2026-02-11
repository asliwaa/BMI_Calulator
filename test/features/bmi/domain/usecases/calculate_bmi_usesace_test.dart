import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi_category.dart';
import 'package:bmi_calculator/features/bmi/domain/repositories/bmi_repository.dart';
import 'package:bmi_calculator/features/bmi/domain/usecases/calculate_bmi_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBmiRepository extends Mock 
  implements BmiRepository {}

void main () {
  late CalculateBmiUseCase useCase;
  late MockBmiRepository mockBmiRepository;

  setUp(() {
    mockBmiRepository = MockBmiRepository();
    useCase = CalculateBmiUseCase(mockBmiRepository);
  });

  final double tWeight = 70.0;
  final double tHeight = 170.0;

  const tBmiResult = Bmi(
    bmiValue: 24.2,
    category: BmiCategory.normal
  );

  test (
    'should calucalte BMI using the repository',
    () async {
      //arrange
      when(() => mockBmiRepository.calculateBmi(weightKg: tWeight, heightCm: tHeight))
      .thenAnswer((_) async => const Right(tBmiResult));
      //act
      final result = await useCase(BmiParams(weight: tWeight, height: tHeight));
      //assert
      expect(result, Right(tBmiResult));

      verify(() => mockBmiRepository.calculateBmi(weightKg: tWeight, heightCm: tHeight));

      verifyNoMoreInteractions(mockBmiRepository);
    },
  );
}