import 'package:call_son/feature/school/data/repo/school_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'change_call_status_state.dart';



class ChangeCallStatusCubit extends Cubit<ChangeCallStatusState> {
  ChangeCallStatusCubit(this.schoolRepo) : super(ChangeCallStatusInitial());
  final SchoolRepoImplementation schoolRepo;
  static ChangeCallStatusCubit get(context) => BlocProvider.of(context);

  void changeCallStatus({
    required String callId,
    required bool accepted,
    String? reply
  }) async
  {
    emit(ChangeCallStatusLoading());
    var response = await schoolRepo.changeCallStatus(callId: callId, accepted: accepted, reply: reply);
    response.fold((failure)
    {
      emit(ChangeCallStatusError(failure.errorMessage));
    }, (result) async
    {
      emit(ChangeCallStatusSuccess(result));
    }
    );
  }
}
