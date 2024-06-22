
import 'package:call_son/core/shared_models/guardian_model.dart';

abstract class GetNotVerifiedGuardiansState {}

class GetGuardiansInitial extends GetNotVerifiedGuardiansState {}

class GetGuardiansLoading extends GetNotVerifiedGuardiansState {}

class GetGuardiansSuccess extends GetNotVerifiedGuardiansState
{
  List<GuardianModel> guardians;
  GetGuardiansSuccess(this.guardians);
}

class GetGuardiansError extends GetNotVerifiedGuardiansState
{
  String error;
  GetGuardiansError(this.error);
}
