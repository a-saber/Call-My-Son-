
import 'package:call_son/core/shared_models/kid_model.dart';

class GuardianModel
{
  String? id;
  String? name;
  String? phone;
  String? ssn;
  List kidsID=[];
  List<KidModel> kidsModels=[];
  List callsID=[];

  GuardianModel({
    this.id,
    this.name,
    this.phone,
    this.ssn,
  });


  GuardianModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    ssn = json['ssn'];
    kidsID = json['kidsID'];
    callsID = json['callsID']??[];
  }

  Map<String, dynamic> toJson()
  {
    return
      {
        'name' : name,
        'id' : id,
        'phone' : phone??'0100536984',
        'ssn' : ssn??'',
        'kidsID' : kidsID,
        'callsID' : callsID,
      };
  }

}

class VerifyGuardianModel
{
  String? id;
  GuardianModel? guardianModel;
  bool? verified;

  VerifyGuardianModel({
    this.id,
    this.verified,
  });


  VerifyGuardianModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson()
  {
    return
      {
        'name' : verified,
        'id' : id,
      };
  }

}