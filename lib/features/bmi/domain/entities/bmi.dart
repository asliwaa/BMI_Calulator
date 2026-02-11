import 'package:equatable/equatable.dart';
import 'bmi_category.dart';

class Bmi extends Equatable {
  final double bmiValue;
  final BmiCategory category;

  const Bmi({
    required this.bmiValue,
    required this.category,
  });

  @override List<Object?> get props => [bmiValue, category];
}