part of 'register_cubit.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class AddDocLoading extends RegisterState {}
class AddDocSuccess extends RegisterState {}
class AddDocError extends RegisterState
{
  String error;
  AddDocError(this.error);
}

