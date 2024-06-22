import 'package:call_son/core/core_widgets/pop_up/my_snack_bar.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/guardian_register_ui/guardian_register_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/core_widgets/default_button/default_button.dart';
import '../../../../../core/resources_manager/app_router.dart';
import '../../../../../core/resources_manager/color_manager.dart';
import '../../../../../core/shared_models/kid_model.dart';
import '../../cubit/guardian/guardian_cubit.dart';
import '../../cubit/guardian_register_ui/guardian_register_ui_cubit.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key, required this.formKey,});

  final formKey;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuardianCubit, GuardianState>(
      listener: (context, state)
      {
        if(state is AddDocSuccess)
        {
          GoRouter.of(context).push(
            AppRouter.kCallView,
          );
        }
        if(state is AddDocError)
        {
          callMySnackBar(context: context, text: state.error, backgroundColor: ColorsManager.red);
        }
      },
      builder: (context, state) {
        return state is AddDocLoading  ?
        Center(
          child: CircularProgressIndicator(
            color: ColorsManager.primary,
          ),
        ) :
        BlocConsumer<GuardianRegisterUiCubit, GuardianRegisterUiState>(
          listener: (context, state) {},
          builder: (context, state) {
            return DefaultButton(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    GuardianCubit.get(context).addGuardianDoc(
                      name: GuardianRegisterUiCubit.get(context).nameController.text,
                      kids: GuardianRegisterUiCubit.get(context).kids,
                      ssn: GuardianRegisterUiCubit.get(context).ssnController.text,
                    );
                  }
                },
                text: "Register");
          },
        );
      },
    );
  }
}
