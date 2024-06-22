import 'package:call_son/feature/school/data/repo/school_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_not_verified_guardians_state.dart';


class GetNotVerifiedGuardiansCubit extends Cubit<GetNotVerifiedGuardiansState> {
  GetNotVerifiedGuardiansCubit(this.schoolRepo) : super(GetGuardiansInitial());
  final SchoolRepoImplementation schoolRepo;
  static GetNotVerifiedGuardiansCubit get(context) => BlocProvider.of(context);

  void getGuardians() async
  {
    emit(GetGuardiansLoading());
    var response = await schoolRepo.getNotVerifiedGuardians();
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
