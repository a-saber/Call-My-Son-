import 'package:call_son/core/shared_models/school_model.dart';
import 'package:flutter/cupertino.dart';

import 'level_model.dart';


class KidRegisterData
{
  TextEditingController name = TextEditingController();
  KidModel kid = KidModel();
  KidRegisterData()
  {
    kid.schoolData.add(SchoolModel());
  }
}
class KidModel
{
  String? id;
  String? name;
  LevelModel? levelModel;
  List<SchoolModel?> schoolData=[];


  KidModel({
    this.id,
    this.name,
  });


  KidModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson()
  {
    return
      {
        'id' : id,
        'name' : name,
      };
  }

}