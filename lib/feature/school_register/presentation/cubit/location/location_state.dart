part of 'location_cubit.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class ChangeLocation extends LocationState {}

class GetLocationLoading extends LocationState {}
class GetLocationSuccess extends LocationState {}
class GetLocationError extends LocationState
{
  String error;
  GetLocationError(this.error);
}
