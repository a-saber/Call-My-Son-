import 'dart:math';

import 'package:call_son/core/cache_helper/cache_data.dart';
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
import 'guardian_repo.dart';

class GuardianRepoImplementation extends GuardianRepo {
  static late GuardianModel guardianModel;

  @override
  Future<Either<Failure, String>> callUp({required CallModel callModel, required SchoolModel schoolModel}) async {
    try {
      if (
      checkLocation(
        lat1: double.parse(callModel.guardianLat!),
        lon1: double.parse(callModel.guardianLong!),
        lon2: double.parse(schoolModel.long!),
        lat2: double.parse(schoolModel.lat!))
      )
      {
        GuardianParent.guardianModel.id = CacheData.id;
        var verifyResponse = await FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
            .doc(schoolModel.id).collection(ConstantsManager.guardianCollection)
            .doc(GuardianParent.guardianModel.id).collection(ConstantsManager.kidsCollection)
            .doc(callModel.kidId).get();
        var verifyResponseData = verifyResponse.data()as Map<String, dynamic>;
        if(!verifyResponseData['verified'])
        {
          return left(DataFailure('Sorry, ${schoolModel.name} did not verify your request'));
        }
        callModel.guardianId=GuardianParent.guardianModel.id;
        final batch = FirebaseFirestore.instance.batch();
        callModel.id = await FirebaseFirestore.instance.collection(ConstantsManager.callCollection).doc().id;
        batch.set(
          FirebaseFirestore.instance.collection(ConstantsManager.callCollection).doc(callModel.id),
          callModel.toJson()
        );
        await batch.commit();
        if(callModel.id==null)
        {
          return left(DataFailure('Check Your internet connection'));
        }
        else
        {
          return right(callModel.id!);
        }
      }
      else
      {
        return left(DataFailure('the distance is too far please come closer'));
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  bool checkLocation({
    required double lat1,
    required double lon1,
    required double lon2,
    required double lat2,
  })
  {
    return LocationManager.getDistanceFromLatLonInM(lat1: lat1, lon1: lon1, lon2: lon2, lat2: lat2) < 100;
  }

  @override
  Future<Either<Failure, GuardianModel>> getData()async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection).doc(GuardianParent.guardianModel.id).get();
      guardianModel = GuardianModel.fromJson(response.data()!);
      await Future.forEach(guardianModel.kidsID, (kidID) async
      {
        var kidResponse = await FirebaseFirestore.instance.collection(ConstantsManager.kidsCollection).doc(kidID).get();
        KidModel kidModel = KidModel.fromJson(kidResponse.data()!);
        var kidSchoolResponse = await FirebaseFirestore.instance
            .collection(ConstantsManager.kidsCollection).doc(kidID)
            .collection(ConstantsManager.schoolCollection).get();
        await Future.forEach(kidSchoolResponse.docs, (school) async
        {
          var levelId = await FirebaseFirestore.instance
              .collection(ConstantsManager.kidsCollection).doc(kidID)
              .collection(ConstantsManager.schoolCollection).doc(school.id).get();
          var schoolCollection = await FirebaseFirestore.instance
              .collection(ConstantsManager.schoolCollection).doc(school.id).get();
          SchoolModel schoolModel = SchoolModel.fromJson(schoolCollection.data()!);
          schoolModel.kidCurrentLevel = levelId.data()!['levelId'];
          kidModel.schoolData.add(schoolModel);
        });
        guardianModel.kidsModels.add(kidModel);
      });
      GuardianParent.guardianModel = guardianModel;
      return right(guardianModel);
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
