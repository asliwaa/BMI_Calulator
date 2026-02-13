import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bmi_history_record.dart';
import '../repositories/bmi_repository.dart';

class GetHistoryUseCase implements UseCase<List<BmiHistoryRecord>, NoParams> {
  final BmiRepository repository;

  GetHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<BmiHistoryRecord>>> call(NoParams params) async {
    return await repository.getHistory();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}