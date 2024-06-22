import 'package:call_son/feature/school/data/repo/school_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/shared_models/call_model.dart';
import 'get_calls_state.dart';



class GetCallsCubit extends Cubit<GetCallsState> {
  GetCallsCubit(this.schoolRepo) : super(GetCallsInitial());
  final SchoolRepoImplementation schoolRepo;
  static GetCallsCubit get(context) => BlocProvider.of(context);

  late CallData callData;
  Future getCalls() async
  {
    emit(GetCallsLoading());
    var response = await schoolRepo.getCalls();
    response.fold((failure)
    {
      emit(GetCallsError(failure.errorMessage));
    }, (result)
    {
      callData = result;
      emit(GetCallsSuccess(result));
    }
    );
  }
  Future editCalls({required int index, required bool accepted})async
  {
    CallModel callModel = callData.waitingCalls[index];
    callData.waitingCalls.removeAt(index);
    if(accepted)
      callData.acceptedCalls.add(callModel);
    else
      callData.rejectedCalls.add(callModel);
    emit(GetCallsSuccess(callData));
  }
}
