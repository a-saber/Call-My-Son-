import 'package:call_son/core/shared_models/call_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/guardian_repo_imp.dart';
part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  CallCubit(this.authRepo) : super(CallInitial());
  final GuardianRepoImplementation authRepo;
  static CallCubit get(context) => BlocProvider.of(context);

  void callUp({
    required CallModel callModel,
    required SchoolModel schoolModel,
  }) async
  {
    emit(CallLoading());
    var response = await authRepo.callUp(
      callModel: callModel,
      schoolModel: schoolModel
    );
    response.fold((failure)
    {
      print(failure.errorMessage);
      emit(CallError(failure.errorMessage));
    }, (result)
    {
      emit(CallSuccess(result));
    }
    );
  }
}
