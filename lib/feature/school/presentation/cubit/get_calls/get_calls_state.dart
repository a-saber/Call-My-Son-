
import '../../../../../core/shared_models/call_model.dart';

abstract class GetCallsState {}

class GetCallsInitial extends GetCallsState {}

class GetCallsLoading extends GetCallsState {}

class GetCallsSuccess extends GetCallsState
{
  CallData callData;
  GetCallsSuccess(this.callData);
}

class GetCallsError extends GetCallsState
{
  String error;
  GetCallsError(this.error);
}
