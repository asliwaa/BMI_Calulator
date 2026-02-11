import 'package:get_it/get_it.dart';
import 'features/bmi/data/datasources/bmi_local_datasource.dart';
import 'features/bmi/data/repositories/bmi_repository_impl.dart';
import 'features/bmi/domain/repositories/bmi_repository.dart';
import 'features/bmi/domain/usecases/calculate_bmi_usecase.dart';
import 'features/bmi/presentation/bloc/bmi_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //BLoC
  //Factory -> new instance for every request
  serviceLocator.registerFactory(() => BmiBloc(calculateBmiUseCase: serviceLocator()),);
  //Use cases
  //LazySingleton -> one instance which is reused
  serviceLocator.registerLazySingleton(() => CalculateBmiUseCase(serviceLocator()),);
  //Repository
  serviceLocator.registerLazySingleton<BmiRepository> (() => BmiRepositoryImpl(localDatasource: serviceLocator()),);
  //Data sources
  serviceLocator.registerLazySingleton<BmiLocalDatasource> (() => BmiLocalDatasourceImpl(),);


}