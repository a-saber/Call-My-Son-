
import 'package:call_son/core/shared_models/guardian_model.dart';

abstract class DataState {}

class DataInitial extends DataState {}

class DataLoading extends DataState {}
class DataSuccess extends DataState
{
  GuardianModel guardian;
  DataSuccess(this.guardian);
}
class DataError extends DataState
{
  String error;
  DataError(this.error);
}