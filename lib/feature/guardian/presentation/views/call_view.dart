import 'package:call_son/core/core_widgets/default_button/default_button.dart';
import 'package:call_son/core/core_widgets/defualt_drop_down/default_drop_down.dart';
import 'package:call_son/core/core_widgets/pop_up/my_snack_bar.dart';
import 'package:call_son/core/main_repos/guardian.dart';
import 'package:call_son/core/shared_functions/location.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/feature/guardian/presentation/cubit/data/data_cubit.dart';
import 'package:call_son/feature/guardian/presentation/cubit/data/data_state.dart';
import 'package:call_son/feature/guardian/presentation/views/result_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/resources_manager/app_router.dart';
import '../../../../core/shared_models/call_model.dart';
import '../../../../core/shared_models/school_model.dart';
import '../../../guardian_history/presentation/cubit/history/history_cubit.dart';
import '../cubit/call/call_cubit.dart';

class CallView extends StatefulWidget {
  const CallView({super.key});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  @override
  void initState() {
    LocationManager.getPermission(context: context);
    DataCubit.get(context).getData();
    super.initState();
  }
KidsWantCall kidCalled = KidsWantCall();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataCubit, DataState>(
      listener: (context, state) {},
      builder: (context, state)
      {
        if (state is DataSuccess)
        {

          return Scaffold(
              appBar: AppBar(
                title: Text("Home"),
                actions:
                [

                ],
              ),
              drawer: DrawerBody(),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 20),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                      [

                        Column(
                          children:
                          [
                            KidsDropDown(
                                text: 'Kid',
                                textEditingController: kidCalled.kidController,
                                kids: state.guardian.kidsModels,
                                value: kidCalled.currentKidModel,
                                onChanged: (KidModel? kid)
                                {
                                  kidCalled.currentKidModel = kid;
                                  kidCalled.currentSchoolModel =null;
                                  setState(() {});
                                }
                            ),
                            if(kidCalled.currentKidModel !=null)
                              SizedBox(height: 20,),
                            if(kidCalled.currentKidModel !=null)
                              SchoolsDropDown(
                                  value: kidCalled.currentSchoolModel,
                                  text: 'kid school',
                                  textEditingController: kidCalled.kidController,
                                  schools: List.generate(kidCalled.currentKidModel!.schoolData.length, (index) => kidCalled.currentKidModel!.schoolData[index]!),
                                  onChanged: (SchoolModel? schoolModel)
                                  {
                                    kidCalled.currentSchoolModel = schoolModel;
                                    setState(() {});
                                  }
                              ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        DefaultButton(
                          onTap: () async
                          {
                            Position? current = await LocationManager.getCurrentLocation();
                            if (current != null) {
                              CallCubit.get(context).callUp(
                                callModel: CallModel(
                                  levelId: kidCalled.currentSchoolModel!.kidCurrentLevel,
                                  kidId: kidCalled.currentKidModel!.id,
                                  schoolId: kidCalled.currentSchoolModel!.id,
                                  createdAt: DateTime.now().toString(),
                                  guardianLat: current.latitude.toString(),
                                  guardianLong: current.longitude.toString()
                                ),
                                schoolModel: kidCalled.currentSchoolModel!
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultView(kid: kidCalled.currentKidModel!.name!, school: kidCalled.currentSchoolModel!.name!)));
                            }
                            else {
                              callMySnackBar(context: context, text: 'try again');
                            }
                          },
                          text: "Call",
                        ),
                      ],
                    ),
                  ),
                ),
              )
          );
        }
        else if(state is DataLoading)
        {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        else if(state is DataError)
        {
          return Scaffold(body: Center(child: Text(state.error)),);
        }
        else
        {
          return Scaffold(body: SizedBox(),);
        }
      },
    );
  }
}
class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width*0.5,
        child: Column(
          children:
          [
            TextButton(
              onPressed: ()
              {
                GoRouter.of(context).push(AppRouter.kGuardianHistoryView);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                [
                  Icon(Icons.history),
                  SizedBox(width: 5,),
                  Text('History'),
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
// IconButton(
//   onPressed: ()
//   {
//     kidsWantSchool.add(KidsWantCall());
//     setState(() {});
//   },
//   icon: Icon(Icons.add)
// ),
// List<KidsWantCall> kidsWantSchool =
// [
//   KidsWantCall(),
// ];
// Expanded(
//   child: ListView.separated(
//     itemBuilder: (context, index)
//     {
//
//       return Row(
//         children:
//         [
//           Expanded(
//             child: KidsDropDown(
//                 text: 'Kid',
//                 textEditingController: kidCalled.kidController,
//                 kids: state.guardian.kidsModels,
//                 value: kidCalled.currentKidModel,
//                 onChanged: (KidModel? kid)
//                 {
//                   kidCalled.currentKidModel = kid;
//                   setState(() {});
//                 }
//             ),
//           ),
//           if(kidCalled.currentKidModel !=null)
//           SizedBox(width: 10,),
//           if(kidCalled.currentKidModel !=null)
//             Expanded(
//               child: SchoolsDropDown(
//                   value: kidCalled.currentSchoolModel,
//                   text: 'kid school',
//                   textEditingController: kidCalled.kidController,
//                   schools: List.generate(kidCalled.currentKidModel!.kidSchoolData.length, (index) => kidsWantSchool[index].currentKidModel!.kidSchoolData[index].schoolModel!),
//                   onChanged: (SchoolModel? schoolModel)
//                   {
//                     kidCalled.currentSchoolModel = schoolModel;
//                     setState(() {});
//                   }
//               ),
//             ),
//         ],
//       );
//     },
//     separatorBuilder: (context, index)=> SizedBox(height: 20,),
//     itemCount: kidsWantSchool.length
//   ),
// ),
/*
Expanded(
                                  child: KidsDropDown(
                                      text: 'Kid',
                                      textEditingController: kidsWantSchool[index].kidController,
                                      kids: state.guardian.kidsModels,
                                      value: kidsWantSchool[index].currentKidModel,
                                      onChanged: (KidModel? kid)
                                      {
                                        kidsWantSchool[index].currentKidModel = kid;
                                        setState(() {});
                                      }
                                  ),
                                ),
                                if(kidsWantSchool[index].currentKidModel !=null)
                                SizedBox(width: 10,),
                                if(kidsWantSchool[index].currentKidModel !=null)
                                  Expanded(
                                    child: SchoolsDropDown(
                                        value: kidsWantSchool[index].currentSchoolModel,
                                        text: 'kid school',
                                        textEditingController: kidsWantSchool[index].kidController,
                                        schools: List.generate(kidsWantSchool[index].currentKidModel!.kidSchoolData.length, (index) => kidsWantSchool[index].currentKidModel!.kidSchoolData[index].schoolModel!),
                                        onChanged: (SchoolModel? schoolModel)
                                        {
                                          kidsWantSchool[index].currentSchoolModel = schoolModel;
                                          setState(() {});
                                        }
                                    ),
                                  ),
 */