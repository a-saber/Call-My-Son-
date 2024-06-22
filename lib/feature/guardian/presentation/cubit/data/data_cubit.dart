import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/guardian_repo_imp.dart';
import 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit(this.repo) : super(DataInitial());
  final GuardianRepoImplementation repo;
  static DataCubit get(context) => BlocProvider.of(context);

  void getData() async
  {
    print('object');
    emit(DataLoading());
    var response = await repo.getData();
    response.fold((failure)
    {
      print(failure.errorMessage);
      emit(DataError(failure.errorMessage));
    }, (result) async
    {
      emit(DataSuccess(result));
    }
    );
  }
}
