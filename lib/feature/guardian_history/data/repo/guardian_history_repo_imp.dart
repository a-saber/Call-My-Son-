import 'package:call_son/core/errors/failures.dart';
import 'package:call_son/core/resources_manager/constants_manager.dart';
import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/main_repos/guardian.dart';
import 'guardian_history_repo.dart';

class GuardianHistoryRepoImplementation extends GuardianHistoryRepo {

  @override
  Future<Either<Failure, CallData>> getCalls() async
  {
    try
    {
      CallData callData= CallData();
      var callsResponse = await FirebaseFirestore.instance
      .collection(ConstantsManager.callCollection)
      .where('guardianId', isEqualTo: GuardianParent.guardianModel.id)
      .orderBy('dateTime', descending: true)
      .get();

      if(callsResponse.docs.isEmpty)
      {
        return left(DataFailure('there are no calls yet'));
      }
      else
      {
        await Future.forEach(
          callsResponse.docs,
          (callMap) async{
            CallModel? call = CallModel.fromJson(callMap.data());
            await Future.forEach(
                GuardianParent.guardianModel.kidsModels,
              (kid) async
              {
                if(call.kidId == kid.id)
                {
                  call.kidModel = kid;
                  await Future.forEach(
                    kid.schoolData,
                    (school) {
                      if(school!.id == call.schoolId)
                      {
                        call.schoolModel = school;
                      }
                    });
                }
              });
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
          }
        );
      }
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
