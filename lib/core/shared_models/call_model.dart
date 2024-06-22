import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:flutter/cupertino.dart';

enum CallStatus {Accepted, Waiting, Rejected}
class CallData
{
  List<CallModel> waitingCalls = [];
  List<CallModel> acceptedCalls = [];
  List<CallModel> rejectedCalls = [];
}
class KidsWantCall
{
  TextEditingController kidController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
  KidModel? currentKidModel;
  SchoolModel? currentSchoolModel;
}
class CallModel
{
  SchoolModel? schoolModel;
  GuardianModel? guardianModel;
  KidModel? kidModel;
  String? id;
  String? schoolId;
  String? guardianId;
  String? kidId;
  String? levelId;
  String? guardianLong;
  String? guardianLat;
  String? createdAt;
  String? editedAt;
  String? status;
  String? reply;

  CallModel({
    this.id,
    this.schoolId,
    this.kidId,
    this.guardianId,
    this.guardianLong,
    this.guardianLat,
    this.createdAt,
    this.editedAt,
    this.status,
    this.levelId,
    this.reply
  });

  // 0 => rejected
  // 2 => waiting
  // 1 => accepted

  CallModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    schoolId = json['schoolId'];
    guardianId = json['guardianId'];
    kidId = json['kidId'];
    guardianLong = json['guardianLong'];
    guardianLat = json['guardianLat'];
    createdAt = json['createdAt'];
    editedAt = json['editedAt'];
    status = json['status'];
    reply = json['reply'];
    levelId = json['levelId'];
  }

  Map<String, dynamic> toJson()
  {
    return
      {
        'schoolId' : schoolId,
        'id' : id,
        'guardianId' : guardianId,
        'kidId' : kidId,
        'guardianLong' : guardianLong,
        'guardianLat' : guardianLat,
        'createdAt' : createdAt,
        'editedAt' : editedAt,
        'status' : status??'2',
        'reply' : reply,
        'levelId' : levelId,
      };
  }

}