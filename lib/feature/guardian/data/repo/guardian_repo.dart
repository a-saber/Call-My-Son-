import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:dartz/dartz.dart';
import 'package:call_son/core/errors/failures.dart';

abstract class GuardianRepo
{
  Future<Either<Failure, GuardianModel>> getData();

  Future<Either<Failure, String>> callUp({
    required CallModel callModel,
    required SchoolModel schoolModel
  });
}