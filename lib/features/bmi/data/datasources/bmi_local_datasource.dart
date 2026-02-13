import 'package:bmi_calculator/features/bmi/domain/entities/bmi.dart';
import 'package:bmi_calculator/features/bmi/domain/entities/bmi_category.dart';

abstract class BmiLocalDatasource {
  Future<Bmi> calculateBmi({
    required double weight,
    required double height,
  });
}

class BmiLocalDatasourceImpl implements BmiLocalDatasource {
  @override Future<Bmi> calculateBmi({
    required double weight,
    required double height,
  }) async {

    //Convert height to meters
    final heightInMeters = height/100;

    //BMI formula
    final bmiValue = weight / (heightInMeters * heightInMeters);

    //Determine weight category
    BmiCategory category;
    if(bmiValue < 18.5) { category = BmiCategory.underweight;}
    else if (bmiValue < 25) {category = BmiCategory.normal;}
    else if (bmiValue < 30) {category = BmiCategory.overweight;}
    else {category = BmiCategory.obesity;}

    return Bmi(
      bmiValue: bmiValue,
      category: category,
    );
  }
}