import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure([this.message = "ERROR"]);

  @override List<Object> get props => [message];
}

class CalculationFailure extends Failure {
  const CalculationFailure({String message = "Calculation error"}) : super(message);
}

class CacheFailure extends Failure {
   const CacheFailure({String message = "Cache memory error"}) : super(message);
}