part of 'bmi_bloc.dart';

enum BmiStatus {
  initial,
  loading,
  success,
  failure
}

class BmiState extends Equatable {
  final double weight;
  final double height;
  final UnitSystem unitSystem;

  final BmiStatus status;
  final Bmi? bmiResult;
  final String? errorMessage;

  const BmiState({
    this.weight = 70.0,
    this.height = 170.0,
    this.unitSystem = UnitSystem.metric,
    this.status = BmiStatus.initial,
    this.bmiResult,
    this.errorMessage,
  });

  BmiState copyWith({
    double? weight,
    double? height,
    UnitSystem? unitSystem,
    BmiStatus? status,
    Bmi? bmiResult,
    String? errorMessage,
  }) {
    return BmiState(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      unitSystem: unitSystem?? this.unitSystem,
      status: status ?? this.status,
      bmiResult: bmiResult ?? this.bmiResult,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override List<Object?> get props => [
    weight,
    height,
    unitSystem,
    status,
    bmiResult,
    errorMessage
  ];

  bool get isMetric => unitSystem == UnitSystem.metric;
}