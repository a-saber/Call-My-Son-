import 'package:call_son/core/shared_models/level_model.dart';
import 'package:dartz/dartz.dart';

import 'package:call_son/core/errors/failures.dart';
import 'package:flutter/material.dart';

abstract class SchoolAuthRepo
{
  Future<Either<Failure, String>> sendCode({
    required String phone,
    required BuildContext context,
  });

  Future<Either<Failure, bool>> verify({
    required String code,
    required String smsCode
  });

  Future<Either<Failure, void>> addDoc({
    required String name,
    required List<LevelModel> levels,
    required bool ssnRequired,
  });

}