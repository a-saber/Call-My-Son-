
import 'package:call_son/core/shared_models/call_model.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}
class HistorySuccess extends HistoryState
{
  CallData callData;
  HistorySuccess(this.callData);
}
class HistoryError extends HistoryState
{
  String error;
  HistoryError(this.error);
}