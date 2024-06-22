import 'package:call_son/core/shared_models/level_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/auth_repo_imp.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.authRepo) : super(RegisterInitial());
  final SchoolAuthRepoImplementation authRepo;
  static RegisterCubit get(context) => BlocProvider.of(context);

  void addDoc({
    required String name,
    required List<LevelModel> levels,
    required bool ssnRequired,
  }) async
  {
    emit(AddDocLoading());

    var response = await authRepo.addDoc(
      name: name,
      levels: levels,
      ssnRequired: ssnRequired
    );
    response.fold((failure)
    {
      emit(AddDocError(failure.errorMessage));
    }, (result) async
    {
      emit(AddDocSuccess());
    }
    );
  }
}
