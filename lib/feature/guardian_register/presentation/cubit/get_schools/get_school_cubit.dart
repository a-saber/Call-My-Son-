import 'package:call_son/feature/guardian_register/presentation/cubit/get_schools/get_school_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/guardian_auth_repo_imp.dart';

class GetSchoolsCubit extends Cubit<GetSchoolsState> {
  GetSchoolsCubit(this.authRepo) : super(GetSchoolsInitial());
  final GuardianAuthRepoImplementation authRepo;
  static GetSchoolsCubit get(context) => BlocProvider.of(context);

  Future<void> getSchools() async
  {
    emit(GetSchoolsLoading());

    var response = await authRepo.getSchools();
    response.fold((failure)
    {
      emit(GetSchoolsError(failure.errorMessage));
    }, (result) async
    {
      emit(GetSchoolsSuccess(result));
    }
    );
  }
}
