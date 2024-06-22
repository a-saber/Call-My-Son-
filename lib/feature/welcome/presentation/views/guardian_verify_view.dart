import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/otp/guardian_otp_cubit.dart';
import 'package:call_son/feature/school_register/presentation/cubit/otp/otp_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/resources_manager/app_router.dart';
import '../../../../core/resources_manager/assets_manager.dart';
import 'widgets/welcome_view_body.dart';

class GuardianVerifyView extends StatefulWidget {
  const GuardianVerifyView({Key? key}) : super(key: key);

  @override
  State<GuardianVerifyView> createState() => _GuardianVerifyViewState();
}

class _GuardianVerifyViewState extends State<GuardianVerifyView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuardianOtpCubit, GuardianOtpState>(
  builder: (context, state) {
    var cubit=GuardianOtpCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsManager.icon,
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: StyleManager.textStyle20.copyWith(
                  color: ColorsManager.logoColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone before starting!",
                style: StyleManager.textStyle15,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                onChanged: (val) {
                  cubit.getCode(val);
                },
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child:ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      cubit.verifyCode();
                      print(cubit.verified);
                      if(cubit.verified){
                        GoRouter.of(context).push(AppRouter.kGradiantRegView);
                      }

                    },
                    child: const Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        GoRouter.of(context).push(AppRouter.kRegTypeView);
                      },
                      child: const Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  },
);
  }
}