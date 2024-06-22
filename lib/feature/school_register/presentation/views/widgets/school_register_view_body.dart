import 'package:call_son/core/core_widgets/default_button/default_button.dart';
import 'package:call_son/core/core_widgets/default_form/default_form_field.dart';
import 'package:call_son/core/core_widgets/icon_container/icon_container.dart';
import 'package:call_son/core/core_widgets/more/default_add_item_row.dart';
import 'package:call_son/core/core_widgets/more/default_add_row.dart';
import 'package:call_son/core/core_widgets/more/default_switch.dart';
import 'package:call_son/core/core_widgets/pop_up/my_snack_bar.dart';
import 'package:call_son/core/resources_manager/assets_manager.dart';
import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/shared_models/level_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/resources_manager/app_router.dart';
import '../../cubit/register/register_cubit.dart';

class SchoolRegisterViewBody extends StatefulWidget {
  const SchoolRegisterViewBody({super.key});

  @override
  State<SchoolRegisterViewBody> createState() => _SchoolRegisterViewBodyState();
}

class _SchoolRegisterViewBodyState extends State<SchoolRegisterViewBody> {
  bool ssn = false;
  List<TextEditingController> levels = [TextEditingController()];
  TextEditingController name = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconContainer(image: AssetsManager.school),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: DefaultFormField(
                  labelText: 'Organization Name',
                  textInputType: TextInputType.text,
                  controller: name,
                  suffixIcon: Icon(
                    Icons.title,
                    color: ColorsManager.primary,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: DefaultSwitch(
                  text: "SSN Required",
                  switchVal: ssn,
                  onChanged: (val) {
                    setState(() {
                      ssn = val;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: DefaultAddRow(
                  text: "Levels",
                  icon: Icons.add_circle,
                  onPressed: () {
                    setState(() {
                      levels.add(TextEditingController());
                    });
                  },
                ),
              ),
              SizedBox(
                height: 28,
              ),
              ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    DefaultAddItemRow(
                      controller: levels[index],
                      onTapButton: () {
                        setState(() {
                          if (levels.length > 1) {
                            levels.removeAt(index);
                          }
                        });
                      },
                    ),
                separatorBuilder: (context, index) =>
                    SizedBox(
                      height: 28,
                    ),
                itemCount: levels.length,
              ),
              SizedBox(
                height: 30,
              ),
              BlocConsumer<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if(state is AddDocError)
                  {
                    callMySnackBar(context: context, text: state.error);
                  }
                  else if(state is AddDocSuccess)
                  {
                    callMySnackBar(context: context, text: 'Register success');
                    GoRouter.of(context).push(AppRouter.kSchoolHomeView);
                  }
                },
                builder: (context, state) {
                  if(state is AddDocLoading)
                  {
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 38),
                    child: DefaultButton(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).addDoc(
                                name: name.text,
                                levels: List.generate(levels.length, (index) =>
                                    LevelModel(name: levels[index].text)),
                                ssnRequired: ssn
                            );
                          }
                        },
                        text: "Register"),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
