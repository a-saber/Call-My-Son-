import 'package:call_son/core/cache_helper/cache_data.dart';
import 'package:call_son/core/cache_helper/cache_helper_keys.dart';
import 'package:call_son/core/main_repos/guardian.dart';
import 'package:call_son/core/resources_manager/app_router.dart';
import 'package:call_son/core/resources_manager/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/cache_helper/cashe_helper.dart';
import '../../../../../core/main_repos/school.dart';
import 'sliding_text.dart';

class SplashViewbody extends StatefulWidget {
  const SplashViewbody({Key? key}) : super(key: key);

  @override
  State<SplashViewbody> createState() => _SplashViewbodyState();
}

class _SplashViewbodyState extends State<SplashViewbody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: Image.asset(
            AssetsManager.icon,
            width: 150,
            height: 150,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        SlidingText(slidingAnimation: slidingAnimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 2),
      () async{

        if(CacheData.id != null && CacheData.type != null)
        {
          if(CacheData.type!)
          {
            SchoolParent.schoolModel.id = CacheData.id;
            GoRouter.of(context).push(AppRouter.kSchoolHomeView);
          }
          else
          {
            GuardianParent.guardianModel.id = CacheData.id;
            GoRouter.of(context).push(AppRouter.kCallView);
          }
        }
        else
        {
          GoRouter.of(context).push(AppRouter.kRegTypeView);
        }
       },
    );
  }
}
