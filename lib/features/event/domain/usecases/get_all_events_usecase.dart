import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/domain/repository/event_repository.dart';

class GetAllEventUseCase implements UseCase<List<EventModel>, NoParams> {
  GetAllEventUseCase({
    required this.repository,
  });
  final EventRepository repository;

  @override
  Future<Either<Failure, List<EventModel>>> call(NoParams params) async {
    return await repository.getAllEvents();
  }
}
