import 'level_model.dart';

class SchoolModel
{
  String? id;
  String? name;
  String? phone;
  bool? ssnRequired;
  String? image;
  String? long;
  String? lat;
  List<LevelModel> levels =[];
  List callsId =[];
  LevelModel? currentLevelModel;
  String? kidCurrentLevel;

  SchoolModel({
    this.id,
    this.name,
    this.phone,
    this.long,
    this.lat,
    this.image,
    this.ssnRequired,
  });

  SchoolModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    long = json['long'];
    lat = json['lat'];
    image = json['image'];
    ssnRequired = json['ssnRequired'];
    callsId = json['callsId'];
  }

  Map<String, dynamic> toJson()
  {
    return
      {
        'name' : name,
        'id' : id,
        'phone' : phone,
        'long' : long,
        'lat' : lat,
        'image' : image,
        'ssnRequired' : ssnRequired,
        'callsId' : callsId,
      };
  }
}

