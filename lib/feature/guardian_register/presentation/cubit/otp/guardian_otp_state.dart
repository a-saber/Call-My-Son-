part of 'guardian_otp_cubit.dart';

@immutable
abstract class GuardianOtpState {}

class OtpInitial extends GuardianOtpState {}
//send code
class SendCodeLoading extends GuardianOtpState {}
class SendCodeSuccess extends GuardianOtpState {}
class SendCodeError extends GuardianOtpState {
  final String error;
  SendCodeError(this.error);
}
class GetCodeSuccessState extends GuardianOtpState {}

//verify code
class VerifyCodeLoading extends GuardianOtpState {}
class VerifyCodeSuccess extends GuardianOtpState {}
class VerifyCodeError extends GuardianOtpState {
  final String error;
  VerifyCodeError(this.error);
}

