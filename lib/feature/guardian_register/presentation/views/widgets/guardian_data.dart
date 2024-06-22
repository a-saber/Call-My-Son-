import 'package:call_son/feature/guardian_register/presentation/cubit/guardian_register_ui/guardian_register_ui_cubit.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/guardian_register_ui/guardian_register_ui_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core_widgets/default_form/default_form_field.dart';
import '../../../../../core/core_widgets/icon_container/icon_container.dart';
import '../../../../../core/resources_manager/assets_manager.dart';
import '../../../../../core/resources_manager/color_manager.dart';

class GuardianData extends StatelessWidget {
  const GuardianData({super.key,});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuardianRegisterUiCubit, GuardianRegisterUiState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GuardianRegisterUiCubit.get(context);
        return Column(
          children:
          [
            IconContainer(image: AssetsManager.guardian),
            DefaultFormField(
              labelText: 'Name',
              hintText: "tap name",
              textInputType: TextInputType.name,
              controller: cubit.nameController,
              suffixIcon: Icon(
                Icons.title_outlined,
                color: ColorsManager.primary,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            DefaultFormField(
              labelText: 'SSN',
              hintText: "tap ssn",
              textInputType: TextInputType.number,
              controller: cubit.ssnController,
              suffixIcon: Icon(
                Icons.lock_outline,
                color: ColorsManager.primary,
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        );
      },
    );
  }
}
