import 'package:get/get.dart';


import '../cache_helper/cache_data.dart';
import '../cache_helper/cache_helper_keys.dart';
import '../cache_helper/cashe_helper.dart';
import 'ar.dart';
import 'en.dart';
import 'translation_key_manager.dart';

class AppLocalization implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        CacheHelperKeys.keyAR: ar,
        CacheHelperKeys.keyEN: en,
      };

  static Future setLanguage() async
  {
    CacheData.lang = await CacheHelper.getData(key: CacheHelperKeys.langKey);

    if (CacheData.lang == null) {
      await CacheHelper.saveData(
          key: CacheHelperKeys.langKey, value: CacheHelperKeys.keyEN);
      await Get.updateLocale(TranslationKeyManager.localeEN);
      CacheData.lang = CacheHelperKeys.keyEN;
    }
  }
}
