import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:dartz/dartz.dart';
import 'package:call_son/core/errors/failures.dart';
import 'package:flutter/material.dart';

abstract class GuardianAuthRepo
{
  Future<Either<Failure, String>> sendCode({
    required String phone,
    required BuildContext context,
  });

  Future<Either<Failure, bool>> verify({
    required String code,
    required String smsCode
  });

  Future<Either<Failure, void>> addGuardianDoc({
    required String name,
    required List<KidModel> kids,
    required String ssn,
  });

  Future<Either<Failure, List<SchoolModel>>> getSchools();

}