import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/bmi.dart';
import '../../domain/usecases/calculate_bmi_usecase.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  final CalculateBmiUseCase calculateBmiUseCase;

  BmiBloc ({required this.calculateBmiUseCase}) : super(const BmiState()) {
    on<WeightChanged>((event, emit) {
      emit(state.copyWith(weight: event.weight, status: BmiStatus.initial));
    });

    on<HeightChanged>((event, emit) {
      emit(state.copyWith(height: event.height, status: BmiStatus.initial));
    });

    on<UnitSystemChanged>((event, emit) {
      double newWeight;
      double newHeight;

      if (state.isMetric) {
        newWeight = state.weight * 2.20462;
        newHeight = state.height / 2.54;
      } else {
        newWeight = state.weight / 2.20462;
        newHeight = state.height * 2.54;
      }

      newWeight = double.parse(newWeight.toStringAsFixed(2));
      newHeight = double.parse(newHeight.toStringAsFixed(2));

      emit(state.copyWith(
        isMetric: !state.isMetric,
        weight: newWeight,     
        height: newHeight, 
        status: BmiStatus.initial,
      ));
    });

    on<CalculateBmiPressed>((event, emit) async {
      emit(state.copyWith(status: BmiStatus.loading));

      double weightToSend = state.weight;
      double heightToSend = state.height;

      if(!state.isMetric) {
        weightToSend = state.weight / 2.20462;
        heightToSend = state.height * 2.54;
      }

      final params = BmiParams(weight: weightToSend, height: heightToSend);

      final result = await calculateBmiUseCase(params);

      result.fold(
        (failure) => emit(state.copyWith(
          status: BmiStatus.failure,
          errorMessage: "Calculation Error"
        )),
        (bmi) => emit(state.copyWith(
          status: BmiStatus.success,
          bmiResult: bmi
        ))
      );
    });
  }
}