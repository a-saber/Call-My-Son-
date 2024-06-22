import 'package:call_son/feature/school/data/repo/school_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_verified_guardians_state.dart';

class GetVerifiedGuardiansCubit extends Cubit<GetVerifiedGuardiansState> {
  GetVerifiedGuardiansCubit(this.schoolRepo) : super(GetGuardiansInitial());
  final SchoolRepoImplementation schoolRepo;
  static GetVerifiedGuardiansCubit get(context) => BlocProvider.of(context);

  void getGuardians() async
  {
    emit(GetGuardiansLoading());
    var response = await schoolRepo.getVerifiedGuardians();
    response.fold((failure)
    {
      emit(GetGuardiansError(failure.errorMessage));
    }, (result) async
    {
      emit(GetGuardiansSuccess(result));
    }
    );
  }
}
