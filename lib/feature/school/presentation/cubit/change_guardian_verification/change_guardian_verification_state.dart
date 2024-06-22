
abstract class ChangeGuardianVerificationState {}

class ChangeGuardianVerificationInitial extends ChangeGuardianVerificationState {}

class ChangeGuardianVerificationLoading extends ChangeGuardianVerificationState {}

class ChangeGuardianVerificationSuccess extends ChangeGuardianVerificationState {}

class ChangeGuardianVerificationError extends ChangeGuardianVerificationState
{
  String error;
  ChangeGuardianVerificationError(this.error);
}
