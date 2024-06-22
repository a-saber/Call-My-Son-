import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:dartz/dartz.dart';

import 'package:call_son/core/errors/failures.dart';

abstract class SchoolRepo
{

  Future<Either<Failure, List<GuardianModel>>> getVerifiedGuardians();

  Future<Either<Failure, List<GuardianModel>>> getNotVerifiedGuardians();

  Future<Either<Failure, void>> changeGuardianVerification({
    required String guardianId,
    required bool isVerify,
  });

  Future<Either<Failure, bool>> changeCallStatus({
    required String callId,
    required bool accepted,
    String? reply
  });

  Future<Either<Failure, CallData>> getCalls();


}