part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}
//send code
class SendCodeLoading extends OtpState {}
class SendCodeSuccess extends OtpState {}
class SendCodeError extends OtpState {
  final String error;
  SendCodeError(this.error);
}
class GetCodeSuccessState extends OtpState{}
//verify code
class VerifyCodeLoading extends OtpState {}
class VerifyCodeSuccess extends OtpState {}
class VerifyCodeError extends OtpState {
  final String error;
  VerifyCodeError(this.error);
}
