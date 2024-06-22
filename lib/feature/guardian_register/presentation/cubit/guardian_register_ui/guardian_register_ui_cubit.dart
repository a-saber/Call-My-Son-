import 'package:call_son/core/shared_models/school_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared_models/kid_model.dart';
import '../../../../../core/shared_models/level_model.dart';
import 'guardian_register_ui_state.dart';

class GuardianRegisterUiCubit extends Cubit<GuardianRegisterUiState> {
  GuardianRegisterUiCubit() : super(GuardianRegisterUiInitial());
  static GuardianRegisterUiCubit get(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  List<KidRegisterData> kids=
  [
    KidRegisterData()
  ];

  void addNewChild()
  {
    kids.add(KidRegisterData());
    emit(NewChild());
  }
  void removeChild(int index)
  {
    if(kids.length != 1)
    {
      kids.removeAt(index);
      emit(RemoveChild());
    }
  }

  void addSchool({required int kidIndex})
  {
    kids[kidIndex].kid.schoolData.add(SchoolModel());
    emit(AddSchool());
  }
  void chooseSchool({required int kidIndex, required int schoolIndex, required SchoolModel schoolModel})
  {
    SchoolModel school = SchoolModel(
      id: schoolModel.id,
      name: schoolModel.name,
      phone: schoolModel.phone,
      lat: schoolModel.lat,
      long: schoolModel.long,
      image: schoolModel.image,
      ssnRequired: schoolModel.ssnRequired,
    );
    school.levels = schoolModel.levels;
    kids[kidIndex].kid.schoolData[schoolIndex] =school;

    emit(ChooseSchool());
  }
  void chooseLevel({required int kidIndex, required int schoolIndex, required int levelIndex})
  {
    kids[kidIndex].kid.schoolData[schoolIndex]!.currentLevelModel = LevelModel(
      name: kids[kidIndex].kid.schoolData[schoolIndex]!.levels[levelIndex].name,
      id: kids[kidIndex].kid.schoolData[schoolIndex]!.levels[levelIndex].id,
    );
    emit(ChooseLevel());
  }
  void removeSchool({required int kidIndex, required int schoolIndex})
  {
    if(kids[kidIndex].kid.schoolData.length !=1) {
      kids[kidIndex].kid.schoolData.removeAt(schoolIndex);
      emit(RemoveSchool());
    }
  }

}
