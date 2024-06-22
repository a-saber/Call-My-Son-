import 'package:call_son/core/resources_manager/app_router.dart';
import 'package:call_son/core/resources_manager/constants_manager.dart';
import 'package:call_son/feature/guardian/presentation/cubit/data/data_cubit.dart';
import 'package:call_son/feature/guardian_history/data/repo/guardian_history_repo_imp.dart';
import 'package:call_son/feature/guardian_history/presentation/cubit/history/history_cubit.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/get_schools/get_school_cubit.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/otp/guardian_otp_cubit.dart';
import 'package:call_son/feature/school/presentation/cubit/change_guardian_verification/change_guardian_verification_cubit.dart';
import 'package:call_son/feature/school/presentation/cubit/get_calls/get_calls_cubit.dart';
import 'package:call_son/feature/school/presentation/cubit/get_verified_guardians/get_verified_guardians_cubit.dart';
import 'package:call_son/feature/school_register/data/repo/auth_repo_imp.dart';
import 'package:call_son/feature/school_register/presentation/cubit/otp/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/guardian/data/repo/guardian_repo_imp.dart';
import '../../feature/guardian/presentation/cubit/call/call_cubit.dart';
import '../../feature/guardian_register/data/repo/guardian_auth_repo_imp.dart';
import '../../feature/guardian_register/presentation/cubit/guardian/guardian_cubit.dart';
import '../../feature/guardian_register/presentation/cubit/guardian_register_ui/guardian_register_ui_cubit.dart';
import '../../feature/school/data/repo/school_repo_imp.dart';
import '../../feature/school/presentation/cubit/change_call_status/change_call_status_cubit.dart';
import '../../feature/school/presentation/cubit/get_not_verified_guardians/get_not_verified_guardians_cubit.dart';
import '../../feature/school_register/presentation/cubit/location/location_cubit.dart';
import '../../feature/school_register/presentation/cubit/register/register_cubit.dart';
import '../service/service_locator.dart';
class MyApp extends StatelessWidget {
  const MyApp._internal();
  static const MyApp _instance = MyApp._internal(); // singleton
  factory MyApp() => _instance;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context)=>LocationCubit(getIt.get<SchoolAuthRepoImplementation>())),
        BlocProvider(create: (context)=>GuardianRegisterUiCubit()),
        BlocProvider(create: (context)=>RegisterCubit(getIt.get<SchoolAuthRepoImplementation>())),
        BlocProvider(create: (context)=>OtpCubit(getIt.get<SchoolAuthRepoImplementation>())),
        BlocProvider(create: (context)=>GuardianCubit(getIt.get<GuardianAuthRepoImplementation>())),
        BlocProvider(create: (context)=>CallCubit(getIt.get<GuardianRepoImplementation>())),
        BlocProvider(create: (context)=>DataCubit(getIt.get<GuardianRepoImplementation>())),
        BlocProvider(create: (context)=>GuardianOtpCubit(getIt.get<GuardianAuthRepoImplementation>())),
        BlocProvider(create: (context)=>GetVerifiedGuardiansCubit(getIt.get<SchoolRepoImplementation>())),
        BlocProvider(create: (context)=>GetNotVerifiedGuardiansCubit(getIt.get<SchoolRepoImplementation>())),
        BlocProvider(create: (context)=>ChangeGuardianVerificationCubit(getIt.get<SchoolRepoImplementation>())),
        BlocProvider(create: (context)=>GetCallsCubit(getIt.get<SchoolRepoImplementation>())),
        BlocProvider(create: (context)=>ChangeCallStatusCubit(getIt.get<SchoolRepoImplementation>())),
        BlocProvider(create: (context)=>HistoryCubit(getIt.get<GuardianHistoryRepoImplementation>())),
        BlocProvider(create: (context)=>GetSchoolsCubit(getIt.get<GuardianAuthRepoImplementation>())),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: ConstantsManager.appTitle,
        // locale: Locale(CacheData.lang!),
        // translations: AppLocalization(),
        theme:ConstantsManager.theme,
        debugShowCheckedModeBanner: false,
      )
    );
  }
}