part of 'call_cubit.dart';

abstract class CallState {}

class CallInitial extends CallState {}

class CallLoading extends CallState {}
class CallSuccess extends CallState
{
  String id;
  CallSuccess(this.id);
}
class CallError extends CallState
{
  String error;
  CallError(this.error);
}