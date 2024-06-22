import 'package:call_son/feature/school_register/data/repo/auth_repo_imp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit(this.authRepo) : super(OtpInitial());
  final SchoolAuthRepoImplementation authRepo;
  static OtpCubit get(context) => BlocProvider.of(context);
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
