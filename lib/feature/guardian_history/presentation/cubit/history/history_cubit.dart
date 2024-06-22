import 'package:call_son/feature/guardian_history/presentation/cubit/history/history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/guardian_history_repo_imp.dart';


class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit(this.historyRepo) : super(HistoryInitial());
  final GuardianHistoryRepoImplementation historyRepo;
  static HistoryCubit get(context) => BlocProvider.of(context);

  void getCalls() async
  {
    emit(HistoryLoading());
    var response = await historyRepo.getCalls();
    response.fold((failure)
    {
      print(failure.errorMessage);
      emit(HistoryError(failure.errorMessage));
    }, (result)
    {
      emit(HistorySuccess(result));
    }
    );
  }
}
