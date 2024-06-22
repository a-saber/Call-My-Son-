import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/core/shared_models/school_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/guardian_auth_repo_imp.dart';
part 'guardian_state.dart';

class GuardianCubit extends Cubit<GuardianState> {
  GuardianCubit(this.authRepo) : super(GuardianInitial());
  final GuardianAuthRepoImplementation authRepo;
  static GuardianCubit get(context) => BlocProvider.of(context);

  Future<void> addGuardianDoc({
    required String name,
    required List<KidRegisterData> kids,
    required String ssn,
  }) async
  {
    emit(AddDocLoading());

    var response = await authRepo.addGuardianDoc(
        name: name,
        kids: register(kids:kids),
        ssn: ssn,
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

  List<KidModel> register({
    required List<KidRegisterData> kids,
  })
  {
    return List.generate(
      kids.length,
      (index)
      {
        KidModel? kid = kids[index].kid;
        kid.name = kids[index].name.text;
        return kid;
      }
    );
  }

}
