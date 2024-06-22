import 'package:call_son/core/core_widgets/more/default_add_row.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/guardian_register_ui/guardian_register_ui_cubit.dart';
import 'package:call_son/feature/guardian_register/presentation/views/widgets/register_button.dart';
import 'package:flutter/material.dart';
import '../../cubit/get_schools/get_school_cubit.dart';
import 'guardian_data.dart';
import 'guardian_kids_data.dart';


class GuardianRegViewBody extends StatefulWidget {
  const GuardianRegViewBody({super.key, required this.scaffoldKey});
  final GlobalKey scaffoldKey;
  @override
  State<GuardianRegViewBody> createState() => _GuardianRegViewBodyState();
}

class _GuardianRegViewBodyState extends State<GuardianRegViewBody> {
  @override
  void initState() {
    GetSchoolsCubit.get(context).getSchools();
    super.initState();
  }
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GuardianData(),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: DefaultAddRow(
                  text: "Kids",
                  icon: Icons.add_circle,
                  onPressed: GuardianRegisterUiCubit.get(context).addNewChild
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GuardianKidsData(),
              SizedBox(
                height: 30,
              ),
              RegisterButton(
                formKey: formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}





