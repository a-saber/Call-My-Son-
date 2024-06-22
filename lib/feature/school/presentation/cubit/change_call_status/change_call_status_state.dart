
abstract class ChangeCallStatusState {}

class ChangeCallStatusInitial extends ChangeCallStatusState {}

class ChangeCallStatusLoading extends ChangeCallStatusState {}

class ChangeCallStatusSuccess extends ChangeCallStatusState
{
  bool accepted;
  ChangeCallStatusSuccess(this.accepted);
}

class ChangeCallStatusError extends ChangeCallStatusState
{
  String error;
  ChangeCallStatusError(this.error);
}
