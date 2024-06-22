
import 'package:call_son/core/core_widgets/default_button/default_button.dart';
import 'package:call_son/core/resources_manager/assets_manager.dart';
import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/feature/school_register/presentation/cubit/location/location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/localization/translation_key_manager.dart';
import '../../../../core/main_repos/school.dart';
import '../../../../core/resources_manager/app_router.dart';
import '../../../../core/resources_manager/style_manager.dart';
import '../../data/repo/auth_repo_imp.dart';
class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {


  @override
  void initState() {
    LocationCubit.get(context).init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationKeyManager.location.tr),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {},
        builder: (context, state)
        {
          var cubit = LocationCubit.get(context);
          return Builder(
              builder: (context)
              {
                if(cubit.kGooglePlex == null)
                {
                  return Center(child: const CircularProgressIndicator());
                }
                return Column(
                  children:
                  [
                    DefaultCheckBox(
                      selected: cubit.useCurrent,
                      text: 'Current Location',
                      icon: AssetsManager.current,
                      onTap: (){cubit.chooseUserCurrent(true);},
                    ),
                    SizedBox(height: 20,),
                    DefaultCheckBox(
                      selected: cubit.useAnother,
                      text: 'Pick another location',
                      icon: AssetsManager.searchLocation,
                      onTap: ()
                      {
                        cubit.chooseAnotherLocation(true);
                      },
                    ),
                    SizedBox(height: 20,),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          GoogleMap(
                              onTap: cubit.mapOnTap,
                              markers: Set<Marker>.of(cubit.markers),
                              mapType: MapType.hybrid,
                              initialCameraPosition: cubit.kGooglePlex!,
                              onMapCreated: (GoogleMapController controller) {
                                cubit.controller.complete(controller);
                              },
                            ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0,right: 60, left: 60),
                            child:

                            InkWell(
                              onTap: ()
                              {
                                if(cubit.currentLocation != null || cubit.markers.isNotEmpty)
                                {
                                  if(cubit.useCurrent) {
                                    SchoolParent.schoolModel.long = cubit.currentLocation!.longitude.toString();
                                    SchoolParent.schoolModel.lat = cubit.currentLocation!.latitude.toString();
                                  }
                                  else
                                  {
                                    SchoolParent.schoolModel.long = cubit.markers[0].position.longitude.toString();
                                    SchoolParent.schoolModel.lat = cubit.markers[0].position.latitude.toString();
                                  }
                                  GoRouter.of(context).push(AppRouter.kSchoolRegView);
                                }
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ColorsManager.primary.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text('Continue',style: StyleManager.textStyle18.copyWith(
                                    color: ColorsManager.white,
                                  ),),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
              });
        },
      ),
    );
  }
}

class DefaultCheckBox extends StatelessWidget {
  const DefaultCheckBox({super.key, required this.selected, required this.text, required this.icon, required this.onTap});
  final bool selected;
  final String text;
  final String icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ColorsManager.primary
          )
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children:
          [
            SvgPicture.asset(icon),
            SizedBox(width: 5,),
            Expanded(child: Text(text,textAlign: TextAlign.start,)),
            SizedBox(width: 5,),
            Container(
              height: 25,width: 25,
              decoration: BoxDecoration(
                color: selected? ColorsManager.primary:Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                      color: ColorsManager.primary
                  ),
              ),
              child: Icon(Icons.check, color: Colors.white,),
            )


          ],
        ),
      ),
    );
  }
}
