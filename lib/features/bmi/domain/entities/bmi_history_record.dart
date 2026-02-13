import 'package:equatable/equatable.dart';
import '../../../../core/enums/unit_system.dart';

class BmiHistoryRecord extends Equatable {
  final int id;
  final double bmiValue;
  final String category;
  final double weight;
  final double height;
  final UnitSystem unitSystem;

  const BmiHistoryRecord({
    required this.id,
    required this.bmiValue,
    required this.category,
    required this.weight,
    required this.height,
    required this.unitSystem,
  });

  @override
  List<Object?> get props => [id, bmiValue, category, weight, height, unitSystem];
}