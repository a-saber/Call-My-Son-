import 'package:call_son/core/resources_manager/assets_manager.dart';
import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:call_son/feature/school/data/repo/school_repo_imp.dart';
import 'package:call_son/feature/school/presentation/cubit/get_verified_guardians/get_verified_guardians_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/main_repos/school.dart';
import '../../../../core/resources_manager/app_router.dart';
import '../cubit/get_calls/get_calls_cubit.dart';
import '../cubit/get_not_verified_guardians/get_not_verified_guardians_cubit.dart';

class SchoolHomeView extends StatelessWidget {
  const SchoolHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    List<SchoolHomeItemData> data =
    [
      SchoolHomeItemData(title:  'Guardians', image: AssetsManager.g, onTap: ()
      {
        GoRouter.of(context).push(AppRouter.kSchoolGuardiansView);
      }),
      SchoolHomeItemData(title:  'Calls', image: AssetsManager.mic, onTap: ()
      {
        GoRouter.of(context).push(AppRouter.kSchoolCallsView);
      }),
      SchoolHomeItemData(title:  'Students', image: AssetsManager.kid, onTap: (){}),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:
              [
                Row(
                  children:
                  [
                    Expanded(
                      child: SchoolHomeItemBuilder(data: data[0])
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                        child: SchoolHomeItemBuilder(data: data[1])
                    ),
                  ],
                ),
                SizedBox(height: 35,),
                Row(
                  children:
                  [
                    Expanded(
                        child: SchoolHomeItemBuilder(data: data[2])
                    ),

                  ],
                )
              ],
            )
          ),
        )
      ),
    );
  }
}


class SchoolHomeItemData
{
  final String title;
  final String image;
  final void Function()? onTap;
  SchoolHomeItemData({ required this.title, required this.image, required this.onTap});
}

class SchoolHomeItemBuilder extends StatelessWidget {
  const SchoolHomeItemBuilder({super.key,required this.data});
  final SchoolHomeItemData data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.onTap,
      child: Column(
        children: [
          Container(
            height: 100,width: 100,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorsManager.formFillColor
            ),
            child: SvgPicture.asset(data.image, color: ColorsManager.primary,),
          ),
          SizedBox(height: 5,),
          Text(data.title)
        ],
      ),
    );
  }
}
