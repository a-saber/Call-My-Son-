import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repo/guardian_auth_repo_imp.dart';
part 'guardian_otp_state.dart';

class GuardianOtpCubit extends Cubit<GuardianOtpState> {
  GuardianOtpCubit(this.authRepo) : super(OtpInitial());
  final GuardianAuthRepoImplementation authRepo;
  static GuardianOtpCubit get(context) => BlocProvider.of(context);
  String codeId="";
  bool verified=false;
  void sendCode({
    required String phone,
    required BuildContext context,
  }) async
  {
    emit(SendCodeLoading());

    var response = await authRepo.sendCode(
      phone: phone,
      context: context,
    );
    response.fold((failure)
    {
      emit(SendCodeError(failure.errorMessage));
    }, (result) async
    {
      codeId=result;
      print("*****************");
      print("888888888888888888$codeId 88888888888888888888888");
      emit(SendCodeSuccess());
      emit(SendCodeSuccess());
    }
    );
  }
  String? code;
  getCode(String code){
    code=code;
    emit(GetCodeSuccessState());
  }
  Future verifyCode() async
  {
    emit(VerifyCodeLoading());

    var response = await authRepo.verify(
      code: codeId,
      smsCode: code!,
    );
    response.fold((failure)
    {
      emit(VerifyCodeError(failure.errorMessage));
    }, (result) async
    {
      verified=result;
      print("---------------------");
      print(verified);
      emit(VerifyCodeSuccess());
    }
    );
  }
}
