import 'package:call_son/feature/school/data/repo/school_repo_imp.dart';
import 'package:call_son/feature/school_register/data/repo/auth_repo_imp.dart';
import 'package:get_it/get_it.dart';

import '../../feature/guardian/data/repo/guardian_repo_imp.dart';
import '../../feature/guardian_history/data/repo/guardian_history_repo_imp.dart';
import '../../feature/guardian_register/data/repo/guardian_auth_repo_imp.dart';

final getIt = GetIt.instance;

void setupForgotPassSingleton() {
  getIt.registerSingleton<SchoolAuthRepoImplementation>(SchoolAuthRepoImplementation());
  getIt.registerSingleton<GuardianAuthRepoImplementation>(GuardianAuthRepoImplementation());
  getIt.registerSingleton<GuardianRepoImplementation>(GuardianRepoImplementation());
  getIt.registerSingleton<SchoolRepoImplementation>(SchoolRepoImplementation());
  getIt.registerSingleton<GuardianHistoryRepoImplementation>(GuardianHistoryRepoImplementation());

}
