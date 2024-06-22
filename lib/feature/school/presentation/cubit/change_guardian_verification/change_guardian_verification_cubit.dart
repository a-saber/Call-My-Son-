import 'package:call_son/feature/school/data/repo/school_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_guardian_verification_state.dart';

class ChangeGuardianVerificationCubit extends Cubit<ChangeGuardianVerificationState> {
  ChangeGuardianVerificationCubit(this.schoolRepo) : super(ChangeGuardianVerificationInitial());
  final SchoolRepoImplementation schoolRepo;
  static ChangeGuardianVerificationCubit get(context) => BlocProvider.of(context);

  void changeGuardianVerification({
    required String guardianId,
    required bool isVerify
  }) async
  {
    emit(ChangeGuardianVerificationLoading());
    var response = await schoolRepo.changeGuardianVerification(guardianId: guardianId, isVerify: isVerify);
    response.fold((failure)
    {
      emit(ChangeGuardianVerificationError(failure.errorMessage));
    }, (result) async
    {
      emit(ChangeGuardianVerificationSuccess());
    }
    );
  }
}
