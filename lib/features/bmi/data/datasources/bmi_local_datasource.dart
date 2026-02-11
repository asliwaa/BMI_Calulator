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

    if(heightInMeters <= 0) {
      throw Exception('Height must be greater than 0');
    }

    //BMI formula
    final bmi = weight / (heightInMeters * heightInMeters);

    //Determine weight category
    BmiCategory category;
    if(bmi < 18.5) { category = BmiCategory.underweight;}
    else if (bmi < 25) {category = BmiCategory.normal;}
    else if (bmi < 30) {category = BmiCategory.overweight;}
    else {category = BmiCategory.obesity;}

    return Bmi(
      bmiValue: double.parse(bmi.toStringAsFixed(2)),
      category: category,
    );
  }
}