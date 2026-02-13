import '../../../../core/enums/unit_system.dart';

class ConvertValuesUseCase {
  ConvertedValues call({
    required double weight, 
    required double height, 
    required UnitSystem targetSystem
  }) {
    double newWeight;
    double newHeight;

    if (targetSystem == UnitSystem.imperial) {
      //Metric -> Imperial
      newWeight = weight * 2.20462;
      newHeight = height / 2.54;
    } else {
      //Imperial -> Metric
      newWeight = weight / 2.20462;
      newHeight = height * 2.54;
    }

    return ConvertedValues(weight: newWeight, height: newHeight);
  }
}

class ConvertedValues {
  final double weight;
  final double height;
  ConvertedValues({required this.weight, required this.height});
}