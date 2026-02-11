import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors.dart';
import '../bloc/bmi_bloc.dart';

class BmiControls extends StatelessWidget {
  const BmiControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BmiBloc, BmiState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SwitchListTile(
                title: Text(
                  state.isMetric 
                      ? "METRIC (kg / cm)" 
                      : "IMPERIAL (lbs / inch)",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
                activeColor: AppColors.accent,
                value: state.isMetric,
                onChanged: (_) => context.read<BmiBloc>().add(UnitSystemChanged()),
              ),
            ),
            
            const SizedBox(height: 20),

            // WEIGHT and HEIHT panels
            Row(
              children: [
                Expanded(
                  child: _ControlPanel(
                    label: "WEIGHT",
                    unit: state.isMetric ? "kg" : "lbs",
                    value: state.weight,
                    onChanged: (val) => context.read<BmiBloc>().add(WeightChanged(val)),
                    stepSmall: 0.1,
                    stepLarge: 1.0,
                  ),
                ),
                Expanded(
                  child: _ControlPanel(
                    label: "HEIGHT",
                    unit: state.isMetric ? "cm" : "in",
                    value: state.height,
                    onChanged: (val) => context.read<BmiBloc>().add(HeightChanged(val)),
                    stepSmall: 1.0,
                    stepLarge: 10.0,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30),
            
            //CALCULATE BMI button
            GestureDetector(
              onTap: () {
                context.read<BmiBloc>().add(CalculateBmiPressed());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: AppColors.accent.withOpacity(0.5), blurRadius: 10, offset: const Offset(0, 5))
                  ]
                ),
                child: const Center(
                  child: Text(
                    "CALCULATE BMI",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

//Widget template for weight and height panels
class _ControlPanel extends StatelessWidget {
  final String label;
  final String unit;
  final double value;
  final Function(double) onChanged;
  final double stepSmall;
  final double stepLarge;

  const _ControlPanel({
    required this.label,
    required this.unit,
    required this.value,
    required this.onChanged,
    required this.stepSmall,
    required this.stepLarge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 15)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value.toStringAsFixed(1),
                  style: const TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white),
                ),
                Text(unit, style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
            const SizedBox(height: 15),
            
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _RoundButton(
                    icon: Icons.keyboard_double_arrow_left, 
                    onPressed: () => onChanged(value - stepLarge),
                  ),
                  const SizedBox(width: 5),
                  _RoundButton(
                    icon: Icons.remove, 
                    onPressed: () => onChanged(value - stepSmall),
                  ),
                  const SizedBox(width: 10),
                  _RoundButton(
                    icon: Icons.add, 
                    onPressed: () => onChanged(value + stepSmall),
                  ),
                  const SizedBox(width: 5),
                  _RoundButton(
                    icon: Icons.keyboard_double_arrow_right, 
                    onPressed: () => onChanged(value + stepLarge),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Round button
class _RoundButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _RoundButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      onPressed: onPressed,
      constraints: const BoxConstraints.tightFor(width: 40.0, height: 40.0),
      shape: const CircleBorder(),
      fillColor: AppColors.buttonGray,
      child: Icon(icon, color: Colors.white),
    );
  }
}