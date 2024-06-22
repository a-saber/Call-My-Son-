import 'package:call_son/core/core_widgets/pop_up/my_snack_bar.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/guardian_register_ui/guardian_register_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core_widgets/default_button/remove_button.dart';
import '../../../../../core/core_widgets/default_form/default_form_field2.dart';
import '../../../../../core/core_widgets/more/default_add_row.dart';
import '../../../../../core/resources_manager/color_manager.dart';
import '../../cubit/guardian_register_ui/guardian_register_ui_cubit.dart';
import 'school_bottom_sheet.dart';

class GuardianKidsData extends StatelessWidget {
  const GuardianKidsData({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuardianRegisterUiCubit, GuardianRegisterUiState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GuardianRegisterUiCubit.get(context);
        return Column(
          children:
          [
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => Column(
                children: [
                  Row(
                    children:
                    [
                      Expanded(
                        child: DefaultFormField2(
                          hintText: "kid name",
                          textInputType: TextInputType.name,
                          controller: cubit.kids[index].name,
                          suffixIcon: Icon(
                            Icons.title_outlined,
                            color: ColorsManager.primary,
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      DefaultRemoveButton(
                        onTap: ()
                        {
                          cubit.removeChild(index);
                        }
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DefaultAddRow(
                        text: "Schools",
                        icon: Icons.add_circle,
                        onPressed: (){GuardianRegisterUiCubit.get(context).addSchool(kidIndex: index);}
                    ),
                  ),
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, schoolIndex)
                      {
                        return Column(
                          children:
                          [

                            Row(
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                              children:
                              [
                                Expanded(
                                  child: InkWell(
                                    onTap:()
                                    {
                                      showBottomSheet(
                                          context:context,
                                          backgroundColor: Colors.transparent,builder:  (context) {
                                        return SchoolsBottomSheetBody(
                                          isSearch: false,
                                          search: TextEditingController(),
                                          onTap: (schoolModel)
                                          {
                                            cubit.chooseSchool(kidIndex: index, schoolIndex: schoolIndex, schoolModel: schoolModel);
                                            Navigator.pop(context);
                                          },
                                        );
                                      });
                                    },
                                    child: DefaultFormField2(
                                      hintText: 'Choose School',
                                        enabled: false,
                                        controller: TextEditingController(
                                            text: cubit.kids[index].kid.schoolData[schoolIndex]!=null ?
                                            cubit.kids[index].kid.schoolData[schoolIndex]!.name :
                                            ''
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                    child: InkWell(
                                      onTap: ()
                                      {
                                        if(cubit.kids[index].kid.schoolData[schoolIndex]!.id==null)
                                        {
                                          callMySnackBar(backgroundColor: ColorsManager.red,context: context, text: 'Please choose school first');
                                        }
                                        else
                                        {
                                          showBottomSheet(
                                              context:context,
                                              backgroundColor: Colors.transparent,builder:  (context) {
                                            return Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: MediaQuery.of(context).size.height,
                                                    color: Colors.black.withOpacity(0.5),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: MediaQuery.of(context).size.height * 0.65,
                                                  decoration: BoxDecoration(
                                                    //color: Colors.white,
                                                      color: Theme.of(context).scaffoldBackgroundColor,
                                                      borderRadius: BorderRadius.only(
                                                        topRight: Radius.circular(20),
                                                        topLeft: Radius.circular(20),
                                                      )),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children:
                                                    [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets.symmetric(horizontal: 30),
                                                              width: double.infinity,
                                                              color: Colors.grey.withOpacity(0.2),
                                                              child: Text(
                                                                '${cubit.kids[index].kid.schoolData[schoolIndex]!.name} Levels',
                                                                style: TextStyle(
                                                                    color: Colors.grey,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 15,
                                                            ),
                                                            Expanded(
                                                              child: ListView.builder(
                                                                  itemCount: cubit.kids[index].kid.schoolData[schoolIndex]!.levels.length,
                                                                  itemBuilder: (context, levelIndex) => Padding(
                                                                    padding: const EdgeInsets.symmetric(
                                                                        horizontal: 30.0, vertical: 7),
                                                                    child: InkWell(
                                                                      onTap: ()
                                                                      {
                                                                        cubit.chooseLevel(kidIndex: index, schoolIndex: schoolIndex, levelIndex: levelIndex);
                                                                        Navigator.pop(context);
                                                                      },
                                                                      child: Column(
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                  Icons.school,
                                                                                  size: 20,
                                                                                  color: ColorsManager.primary
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Expanded(
                                                                                child: Text(
                                                                                  cubit.kids[index].kid.schoolData[schoolIndex]!.levels[levelIndex].name!,
                                                                                  style: TextStyle(
                                                                                      fontWeight:
                                                                                      FontWeight.bold,
                                                                                      color: Colors.black),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Divider()
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          });
                                        }
                                      },
                                      child: DefaultFormField2(
                                        hintText: 'Choose Level',
                                          enabled: false,
                                          controller: TextEditingController(
                                              text: cubit.kids[index].kid.schoolData[schoolIndex]!.currentLevelModel!=null ?
                                              cubit.kids[index].kid.schoolData[schoolIndex]!.currentLevelModel!.name :
                                              ''
                                          )
                                      ),
                                    ),
                                  ),
                                IconButton(
                                  onPressed: ()
                                  {
                                    cubit.removeSchool(kidIndex: index, schoolIndex: schoolIndex);
                                  },
                                  icon: Icon(
                                    Icons.cancel,
                                    color: cubit.kids[index].kid.schoolData.length !=1?
                                    ColorsManager.primary:
                                    ColorsManager.formFillColor,
                                    size: 35,
                                  )
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, schoolIndex)=>SizedBox(height: 10,),
                      itemCount: cubit.kids[index].kid.schoolData.length
                  )
                ],
              ),
              separatorBuilder: (context, index) => SizedBox(height: 15,),
              itemCount: cubit.kids.length,
            ),
          ],
        );
      },
    );
  }
}
