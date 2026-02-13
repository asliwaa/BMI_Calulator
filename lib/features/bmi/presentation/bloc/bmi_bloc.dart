import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/enums/unit_system.dart';
import '../../domain/entities/bmi.dart';
import '../../domain/usecases/calculate_bmi_usecase.dart';
import '../../domain/usecases/convert_values_usecase.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  final CalculateBmiUseCase calculateBmiUseCase;
  final ConvertValuesUseCase convertValuesUseCase;

  BmiBloc({
    required this.calculateBmiUseCase,
    required this.convertValuesUseCase,
  }) : super(const BmiState()) {
    
    on<WeightChanged>((event, emit) {
      emit(state.copyWith(weight: event.weight, status: BmiStatus.initial));
    });

    on<HeightChanged>((event, emit) {
      emit(state.copyWith(height: event.height, status: BmiStatus.initial));
    });

    on<UnitSystemChanged>((event, emit) {
      final newSystem = state.unitSystem == UnitSystem.metric 
          ? UnitSystem.imperial 
          : UnitSystem.metric;

      final converted = convertValuesUseCase(
        weight: state.weight,
        height: state.height,
        targetSystem: newSystem,
      );

      emit(state.copyWith(
        unitSystem: newSystem,
        weight: double.parse(converted.weight.toStringAsFixed(2)),
        height: double.parse(converted.height.toStringAsFixed(2)),
        status: BmiStatus.initial,
      ));
    });

    on<CalculateBmiPressed>((event, emit) async {
      emit(state.copyWith(status: BmiStatus.loading));

      final params = BmiParams(
        weight: state.weight,
        height: state.height,
        unitSystem: state.unitSystem,
      );

      final result = await calculateBmiUseCase(params);

      result.fold(
        (failure) => emit(state.copyWith(
          status: BmiStatus.failure,
          errorMessage: "Calculation error",
        )),
        (bmi) => emit(state.copyWith(
          status: BmiStatus.success,
          bmiResult: bmi,
        )),
      );
    });
  }
}