import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/bmi_bloc.dart';
import '../widgets/bmi_controls.dart';
import '../widgets/bmi_gauge.dart';

class BmiPage extends StatelessWidget {
  const BmiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
      ),
      //Injects BLoC using ServiceLocator -> makes BmiBloc available to widget tree
      body: BlocProvider(
        create: (_) => serviceLocator<BmiBloc>(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              const BmiControls(),

              const SizedBox(height: 30),

              //rebuild ui based on the current state
              BlocBuilder<BmiBloc, BmiState>(
                builder: (context, state) {
                  if (state.status == BmiStatus.loading) {
                    return const CircularProgressIndicator();
                  } else if (state.status == BmiStatus.failure) {
                    return Text(state.errorMessage ?? "Error ocurred", style: const TextStyle(color: Colors.red));
                  } else if (state.status == BmiStatus.success && state.bmiResult != null) {
                    return SizedBox(
                      height: 300,
                      child: BmiGauge(bmiResult: state.bmiResult!),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}