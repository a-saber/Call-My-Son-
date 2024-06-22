import 'package:call_son/core/resources_manager/app_router.dart';
import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/core/shared_models/level_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../errors/failures.dart';
import '../resources_manager/constants_manager.dart';

class FirebaseManager
{


  static Future<SchoolModel?> getSchoolById(String id) async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
          .doc(id).get();
      return SchoolModel.fromJson(response.data()!);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  static Future<GuardianModel?> getGuardianById(String id) async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection)
          .doc(id).get();
      return GuardianModel.fromJson(response.data()!);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  static Future<KidModel?> getKidById(String id) async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.kidsCollection)
          .doc(id).get();
      return KidModel.fromJson(response.data()!);
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  static Future<LevelModel?> getKidSchoolLevel({required String schoolId, required String kidId}) async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.kidsCollection)
          .doc(kidId).collection(ConstantsManager.schoolCollection).doc(schoolId).get();
      LevelModel? level = await getLevelById(schoolId: schoolId, levelId: response.data()!['levelId']);
      return level;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  static Future<LevelModel?> getLevelById({required String schoolId, required String levelId}) async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
          .doc(schoolId).collection(ConstantsManager.levelCollection).doc(levelId).get();
      LevelModel level = LevelModel.fromJson(response.data()!);
      level.id = response.id;
      return level;
    }
    catch(e)
    {
      print(e.toString());
      return null;
    }
  }
  static Future<CallModel?> getCallById(String id) async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.callCollection)
          .doc(id).get();
      return CallModel.fromJson(response.data()!);
    }
    catch(e)
    {
      return null;
    }
  }

  static Future<void> addDoc({required String collection, required model}) async
  {
    return await FirebaseFirestore.instance
        .collection(collection)
        .doc(model.id)
        .set(model.toJson());
  }
  static Future<String> sendCode({
    required String phone,
    required BuildContext context,
    required String route,
  }) async
  {
    String code='';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        code=verificationId;
        GoRouter.of(context).push(route);
        print("*****************************$code****************************");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},

    );
    return code;
  }
  static Future<UserCredential> verifyCode({
    required String code,
    required String smsCode,
  }) async
  {
    PhoneAuthCredential credential = PhoneAuthProvider
        .credential(
      verificationId: code,
      smsCode: smsCode,
    );
    final FirebaseAuth auth=FirebaseAuth.instance;
    UserCredential userModel=await auth.signInWithCredential(credential);
    return userModel;
  }
}