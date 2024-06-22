
import 'package:call_son/core/shared_models/guardian_model.dart';

abstract class GetVerifiedGuardiansState {}

class GetGuardiansInitial extends GetVerifiedGuardiansState {}

class GetGuardiansLoading extends GetVerifiedGuardiansState {}

class GetGuardiansSuccess extends GetVerifiedGuardiansState
{
  List<GuardianModel> guardians;
  GetGuardiansSuccess(this.guardians);
}

class GetGuardiansError extends GetVerifiedGuardiansState
{
  String error;
  GetGuardiansError(this.error);
}
