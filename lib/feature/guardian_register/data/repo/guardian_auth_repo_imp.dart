import 'package:call_son/core/cache_helper/cache_data.dart';
import 'package:call_son/core/cache_helper/cache_helper_keys.dart';
import 'package:call_son/core/cache_helper/cashe_helper.dart';
import 'package:call_son/core/errors/failures.dart';
import 'package:call_son/core/main_repos/guardian.dart';
import 'package:call_son/core/resources_manager/app_router.dart';
import 'package:call_son/core/resources_manager/constants_manager.dart';
import 'package:call_son/core/shared_functions/firebase.dart';
import 'package:call_son/core/shared_functions/location.dart';
import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/core/shared_models/level_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/shared_models/guardian_model.dart';
import 'guardian_auth_repo.dart';

class GuardianAuthRepoImplementation extends GuardianAuthRepo {

  @override
  Future<Either<Failure, String>> sendCode({
    required String phone,
    required BuildContext context,
  }) async
  {
    String code = "";
    try {
      FirebaseManager.sendCode(phone: phone, context: context,route: AppRouter.kGuardianVerifyView).then((value) {
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
  }) async
  {
    try {
      bool verified = false;
      UserCredential user =
          await FirebaseManager.verifyCode(code: code, smsCode: smsCode);
      if (user.user != null) {
        verified = true;
        GuardianParent.guardianModel = GuardianModel(id: user.user!.uid, phone: user.user!.phoneNumber);
      }
      if (verified) {
        return right(verified);
      } else {
        return left(DataFailure('Code is not correct'));
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        print(e.toString());
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addGuardianDoc({
    required String name,
    required List<KidModel> kids,
    required String ssn,
  }) async
  {
    GuardianParent.guardianModel.name = name;
    GuardianParent.guardianModel.ssn = ssn;
    GuardianParent.guardianModel.id = await FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection)
    .doc().id;
    try {
      final batch = FirebaseFirestore.instance.batch();
      await addKids(batch:batch, kids:kids);
      await batch.commit();
      CacheData.type = false;
      CacheData.id = GuardianParent.guardianModel.id;
      await CacheHelper.saveData(key: CacheHelperKeys.id, value: CacheData.id);
      await CacheHelper.saveData(key: CacheHelperKeys.type, value: CacheData.type);
      return right(0);
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future addKids({
    required WriteBatch batch,
    required List<KidModel> kids,
  }) async
  {
    List<String> kidsID=[];
    batch.set(
        FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection).doc(GuardianParent.guardianModel.id),
        GuardianParent.guardianModel.toJson()
    );
    await Future.forEach(kids,(element) async
    {
      var docId = await  FirebaseFirestore.instance.collection(ConstantsManager.kidsCollection).doc().id;
      kidsID.add(docId);
      element.id = docId;
      batch.set(
          FirebaseFirestore.instance.collection(ConstantsManager.kidsCollection).doc(docId),
          element.toJson()
      );
      await Future.forEach(element.schoolData, (school)
      {
        batch.set(
          FirebaseFirestore.instance.collection(ConstantsManager.kidsCollection).doc(docId)
          .collection(ConstantsManager.schoolCollection).doc(school!.id),
          {
            'levelId':school.currentLevelModel!.id
          });
        batch.set(FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection).doc(school.id)
            .collection(ConstantsManager.guardianCollection).doc(GuardianParent.guardianModel.id),
            {"k":"l"});
        batch.set(
          FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection).doc(school.id)
          .collection(ConstantsManager.guardianCollection).doc(GuardianParent.guardianModel.id)
            .collection(ConstantsManager.kidsCollection).doc(element.id),
          {
            'levelId': school.currentLevelModel!.id,
            'verified': false
          });
      });
    });
    batch.update(
        FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection).doc(GuardianParent.guardianModel.id),
        {'kidsID':kidsID}
    );
  }

  @override
  Future<Either<Failure, List<SchoolModel>>> getSchools() async
  {
    List<SchoolModel> schools=[];
    try
    {
      var schoolsResponse = await FirebaseFirestore.instance
          .collection(ConstantsManager.schoolCollection).get();
      await Future.forEach(
        schoolsResponse.docs,
        (element) async{
        SchoolModel schoolModel = SchoolModel.fromJson(element.data());
        var levelsResponse = await FirebaseFirestore.instance
            .collection(ConstantsManager.schoolCollection).doc(schoolModel.id)
        .collection(ConstantsManager.levelCollection).get();
        await Future.forEach(levelsResponse.docs, (levelMap)
        {
          LevelModel levelModel = LevelModel.fromJson(levelMap.data());
          levelModel.id = levelMap.id;
          schoolModel.levels.add(levelModel);
        });
        schools.add(schoolModel);
      });
      if (schools.isEmpty)
      {
        return left(DataFailure('No Schools'));
      }
      else
      {
        return right(schools);
      }
    } 
    catch (e) 
    {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

}
