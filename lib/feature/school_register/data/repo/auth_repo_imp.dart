import 'package:call_son/core/cache_helper/cache_data.dart';
import 'package:call_son/core/cache_helper/cashe_helper.dart';
import 'package:call_son/core/errors/failures.dart';
import 'package:call_son/core/main_repos/school.dart';
import 'package:call_son/core/resources_manager/app_router.dart';
import 'package:call_son/core/resources_manager/constants_manager.dart';
import 'package:call_son/core/shared_functions/firebase.dart';
import 'package:call_son/core/shared_models/level_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:call_son/feature/school_register/data/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/cache_helper/cache_helper_keys.dart';

class SchoolAuthRepoImplementation extends SchoolAuthRepo {

  @override
  Future<Either<Failure, String>> sendCode({
    required String phone,
    required BuildContext context,
  }) async {
    String code = "";
    try {
      FirebaseManager.sendCode(
        phone: phone,
        context: context,
        route: AppRouter.kSchoolVerifyView,
      ).then((value) {
        code = value;
      });
      if (code != '') return right(code);
      return left(DataFailure('please try again'));
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verify({
    required String code,
    required String smsCode,
  }) async {
    try {
      bool verified = false;
      UserCredential user =
          await FirebaseManager.verifyCode(code: code, smsCode: smsCode);
      if (user.user != null) {
        verified = true;
        SchoolParent.schoolModel = SchoolModel(id: user.user!.uid, phone: user.user!.phoneNumber);
      }
      if (verified) {
        return right(verified);
      } else {
        return left(DataFailure('Code is not correct'));
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addDoc({
    required String name,
    required List<LevelModel> levels,
    required bool ssnRequired,
  }) async {
    SchoolParent.schoolModel.name = name;
    SchoolParent.schoolModel.levels = levels;
    SchoolParent.schoolModel.ssnRequired = ssnRequired;
    SchoolParent.schoolModel.id = await FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
    .doc().id;
    try {
      final batch = FirebaseFirestore.instance.batch();
      batch.set(
        FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection).doc(SchoolParent.schoolModel.id),
          SchoolParent.schoolModel.toJson()
      );
      levels.forEach((element)
      {
        batch.set(
          FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection).doc(SchoolParent.schoolModel.id).collection(ConstantsManager.levelCollection).doc(),
          element.toJson()
        );
      });
      CacheData.id = SchoolParent.schoolModel.id;
      CacheData.type = true;
      await CacheHelper.saveData(key: CacheHelperKeys.id, value: CacheData.id );
      await CacheHelper.saveData(key: CacheHelperKeys.type, value: CacheData.type);
      await batch.commit();
      return right(true);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
