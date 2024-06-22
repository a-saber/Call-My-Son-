class LevelModel
{
  String? id;
  String? name;


  LevelModel({
    this.id,
    this.name,
  });

  LevelModel.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
  }

  Map<String, dynamic> toJson()
  {
    return
      {
        'name' : name,
      };
  }
}

