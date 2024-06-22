part of 'guardian_cubit.dart';

abstract class GuardianState {}

class GuardianInitial extends GuardianState {}

class AddDocLoading extends GuardianState {}
class AddDocSuccess extends GuardianState {}
class AddDocError extends GuardianState
{
  String error;
  AddDocError(this.error);
}
class AddKidLoading extends GuardianState {}
class AddKidSuccess extends GuardianState {}
class AddKidError extends GuardianState
{
  String error;
  AddKidError(this.error);
}