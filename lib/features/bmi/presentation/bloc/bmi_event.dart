part of 'bmi_bloc.dart';

abstract class BmiEvent extends Equatable {
  const BmiEvent();

  @override List<Object> get props => [];
}

class WeightChanged extends BmiEvent {
  final double weight;
  const WeightChanged(this.weight);

  @override List<Object> get props => [weight];
}

class HeightChanged extends BmiEvent {
  final double height;
  const HeightChanged(this.height);

  @override List<Object> get props => [height];
}

class UnitSystemChanged extends BmiEvent {}

class CalculateBmiPressed extends BmiEvent {}

class LoadHistory extends BmiEvent {}