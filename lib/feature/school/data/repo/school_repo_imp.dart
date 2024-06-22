import 'package:call_son/core/errors/failures.dart';
import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/constants_manager.dart';
import 'package:call_son/core/shared_functions/firebase.dart';
import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/main_repos/school.dart';
import 'school_repo.dart';

class SchoolRepoImplementation extends SchoolRepo
{

  @override
  Future<Either<Failure, bool>> changeCallStatus({
    required String callId,
    required bool accepted,
    String? reply
  }) async
  {
    try{
    await FirebaseFirestore.instance.
    collection(ConstantsManager.callCollection).doc(callId)
    .update({
      "status": accepted ? '1' : '0',
      "reply": reply ?? '',
      "editedAt":DateTime.now().toString()
    });
    return right(accepted);
    }
    catch(e)
    {
      print(e.toString());
      if (e is DioException)
      {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> changeGuardianVerification({
    required String guardianId,
    required bool isVerify
  }) async
  {
    try {
      await FirebaseFirestore.instance.
      collection(ConstantsManager.schoolCollection).doc(SchoolParent.schoolModel.id)
          .collection(ConstantsManager.guardianCollection).doc(guardianId)
          .update({
        "verified": isVerify,
      });
      return right(0);
    }
    catch(e)
    {
      print(e.toString());
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GuardianModel>>> getVerifiedGuardians() async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
          .doc(SchoolParent.schoolModel.id).collection(ConstantsManager.guardianCollection)
          .where('verified', isEqualTo: true).get();
      if(response.docs.isNotEmpty)
      {
        List<GuardianModel> guardians=[];
        response.docs.forEach((element) async
        {
          print(element.id);
          GuardianModel? guardianModel = await FirebaseManager.getGuardianById(element.id);
          if(guardianModel != null)
          {
            guardians.add(guardianModel);
          }
        });
        return right(guardians);
      }
      else
      {
        return left(DataFailure('No Data'));
      }
    }
    catch(e)
    {
      print(e.toString());
      if (e is DioException)
      {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));

    }

  }

  @override
  Future<Either<Failure, List<GuardianModel>>> getNotVerifiedGuardians() async
  {
    try
    {
      var response = await FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
      .doc(SchoolParent.schoolModel.id).collection(ConstantsManager.guardianCollection)
      .where('verified', isEqualTo: false).get();
      if(response.docs.isNotEmpty)
      {
        List<GuardianModel> guardians=[];
        response.docs.forEach((element) async
        {
          GuardianModel? guardianModel = await FirebaseManager.getGuardianById(element.id);
          if(guardianModel != null)
          {
            guardians.add(guardianModel);
          }
        });
        return right(guardians);
      }
      else
      {
        return left(DataFailure('No Data'));
      }
    }
    catch(e)
    {
      print(e.toString());
      if (e is DioException)
      {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));

    }
  }



  @override
  Future<Either<Failure, CallData>> getCalls() async
  {
    try
    {
      CallData callData= CallData();
      print(SchoolParent.schoolModel.callsId.length);
      var schoolCallsResponse = await FirebaseFirestore.instance
          .collection(ConstantsManager.callCollection)
          .where('schoolId', isEqualTo: SchoolParent.schoolModel.id)
          .orderBy('dateTime', descending: true).snapshots()
          .listen((event) async {
            await Future.forEach(
                event.docs,
                    (callResponse) async{
                  CallModel? call = CallModel.fromJson(callResponse.data());
                  call.guardianModel = await FirebaseManager.getGuardianById(call.guardianId!);
                  call.kidModel = await FirebaseManager.getKidById(call.kidId!);
                  call.kidModel!.levelModel = await FirebaseManager.getKidSchoolLevel(
                      schoolId: SchoolParent.schoolModel.id!,
                      kidId: call.kidId!
                  );
                  if(call.status == '0')
                  {
                    callData.rejectedCalls.add(call);
                  }
                  else if(call.status == '1')
                  {
                    callData.acceptedCalls.add(call);
                  }
                  else
                  {
                    callData.waitingCalls.add(call);
                  }
                });
          });
      return right(callData);
    }
      catch(e)
      {
        print(e.toString());
        if (e is DioException)
        {
          return left(ServerFailure.fromDioError(e));
        }
        return left(ServerFailure(e.toString()));

      }

  }

}


/*
// await Future.forEach(SchoolParent.schoolModel.callsId,(element) async
      // {
      //   var response = await FirebaseFirestore.instance.collection(ConstantsManager.callCollection).doc(element).get();
      //   CallModel? call = CallModel.fromJson(response.data()!);
      //   call.guardianModel = await FirebaseManager.getGuardianById(call.guardianId!);
      //   call.kidModel = await FirebaseManager.getKidById(call.kidId!);
      //   call.kidModel!.levelModel = await FirebaseManager.getKidSchoolLevel(schoolId: SchoolParent.schoolModel.id!, kidId: call.kidId!);
      //   if(call.status == '0')
      //   {
      //     callData.rejectedCalls.add(call);
      //   }
      //   else if(call.status == '1')
      //   {
      //     callData.acceptedCalls.add(call);
      //   }
      //   else
      //   {
      //     callData.waitingCalls.add(call);
      //   }
      // });
 */