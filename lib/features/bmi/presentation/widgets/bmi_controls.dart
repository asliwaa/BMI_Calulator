import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bmi_bloc.dart';

class BmiControls extends StatelessWidget {
  const BmiControls({Key? key}) : super(key: key);

  @override Widget build(BuildContext context) {
    return BlocBuilder<BmiBloc, BmiState>(
      builder: (context, state) {
        return Column(
          children: [
            SwitchListTile(
              title: const Text("Metric units (kg/cm)"),
              value: state.isMetric,
              onChanged: (_) => context.read<BmiBloc>().add(UnitSystemChanged()),  
            ),
            const SizedBox(height: 20),

            //Weight
            _ControlPanel(
              label: "Weight (${state.isMetric ? 'kg' : 'lbs'})",
              value: state.weight,
              onChanged: (val) => context.read<BmiBloc>().add(WeightChanged(val)),
              stepSmall: 0.1,
              stepLarge: 1.0,
            ),

            const SizedBox(height: 20),

            //Height
            _ControlPanel(
              label: "Height (${state.isMetric ? 'cm' : 'inch'})",
              value: state.height,
              onChanged: (val) => context.read<BmiBloc>().add(HeightChanged(val)),
              stepSmall: 1.0,
              stepLarge: 10.0,
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                context.read<BmiBloc>().add(CalculateBmiPressed());
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: const Text("CALCULATE BMI", style: TextStyle(fontSize: 18)),
            ),
          ],
          );
      },
    );
  }
}

class _ControlPanel extends StatelessWidget {
  final String label;
  final double value;
  final Function(double) onChanged;
  final double stepSmall;
  final double stepLarge;

  const _ControlPanel({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.stepSmall,
    required this.stepLarge,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Minusy
                IconButton(icon: const Icon(Icons.keyboard_double_arrow_left), onPressed: () => onChanged(value - stepLarge)),
                IconButton(icon: const Icon(Icons.remove), onPressed: () => onChanged(value - stepSmall)),
                
                // Wyświetlacz wartości (Input)
                SizedBox(
                  width: 100,
                  child: TextFormField(
                    // Klucz sprawia, że pole odświeży się, gdy zmieni się wartość w stanie
                    key: Key(value.toString()), 
                    initialValue: value.toStringAsFixed(1),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    onChanged: (val) {
                      final parsed = double.tryParse(val);
                      if (parsed != null) onChanged(parsed);
                    },
                  ),
                ),

                // Plusy
                IconButton(icon: const Icon(Icons.add), onPressed: () => onChanged(value + stepSmall)),
                IconButton(icon: const Icon(Icons.keyboard_double_arrow_right), onPressed: () => onChanged(value + stepLarge)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}