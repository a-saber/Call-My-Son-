import 'package:call_son/core/cache_helper/cashe_helper.dart';
import 'package:call_son/core/dio_helper/dio_helper.dart';
import 'package:call_son/core/localization/app_localization.dart';
import 'package:call_son/core/main_repos/school.dart';
import 'package:call_son/core/resources_manager/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/app/app.dart';
import 'core/cache_helper/cache_data.dart';
import 'core/cache_helper/cache_helper_keys.dart';
import 'core/service/service_locator.dart';
import 'firebase_options.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  await AppLocalization.setLanguage();
  setupForgotPassSingleton();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await CacheHelper.removeData(key: CacheHelperKeys.id, );
  // await CacheHelper.removeData(key: CacheHelperKeys.type);
  // await CacheHelper.saveData(key: CacheHelperKeys.id, value: '1aapTulCTyq9ImBLAblM');
  // await CacheHelper.saveData(key: CacheHelperKeys.type, value: false);
  CacheData.id = await CacheHelper.getData(key: CacheHelperKeys.id);
  CacheData.type = await CacheHelper.getData(key: CacheHelperKeys.type);

  runApp(MyApp());
}
