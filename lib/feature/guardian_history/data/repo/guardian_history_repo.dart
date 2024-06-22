import 'package:call_son/core/shared_models/call_model.dart';
import 'package:dartz/dartz.dart';
import 'package:call_son/core/errors/failures.dart';

import '../../../../core/shared_models/guardian_model.dart';

abstract class GuardianHistoryRepo
{
  Future<Either<Failure, CallData>> getCalls();
}