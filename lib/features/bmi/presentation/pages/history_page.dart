import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/enums/unit_system.dart';
import '../bloc/bmi_bloc.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BmiBloc>().add(LoadHistory());

    return Scaffold(
      appBar: AppBar(title: const Text("Your results:")),
      body: BlocBuilder<BmiBloc, BmiState>(
        builder: (context, state) {
          if (state.history.isEmpty) {
            return const Center(child: Text("No results yet.", style: TextStyle(color: Colors.white)));
          }

          return ListView.builder(
            itemCount: state.history.length,
            itemBuilder: (context, index) {
              final item = state.history[index];
              
              //Unit check
              final isMetric = item.unitSystem == UnitSystem.metric;
              final weightUnit = isMetric ? "kg" : "lbs";
              final heightUnit = isMetric ? "cm" : "in";

              final categoryName = item.category.split('.').last.toUpperCase();

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: AppColors.cardBackground,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //BMI result
                      Column(
                        children: [
                          Text("BMI", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getColor(item.bmiValue),
                            ),
                            child: Text(
                              item.bmiValue.toStringAsFixed(1),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      
                      //Category
                      Text(
                        categoryName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                      ),

                      //Parameters
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("${item.weight.toStringAsFixed(1)} $weightUnit", style: const TextStyle(color: Colors.white, fontSize: 16)),
                          Text("${item.height.toStringAsFixed(1)} $heightUnit", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }
}