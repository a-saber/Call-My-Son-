import 'package:call_son/core/core_widgets/default_button/default_button.dart';
import 'package:call_son/core/core_widgets/icon_container/icon_container.dart';
import 'package:call_son/core/core_widgets/icon_container/tapped_icon_container.dart';
import 'package:call_son/core/resources_manager/app_router.dart';
import 'package:call_son/core/resources_manager/assets_manager.dart';
import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:call_son/core/resources_manager/style_manager.dart';
import 'package:call_son/feature/guardian_register/presentation/cubit/otp/guardian_otp_cubit.dart';
import 'package:call_son/feature/school_register/presentation/cubit/otp/otp_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'option_widget.dart';

class WelcomeViewBody extends StatefulWidget {
  const WelcomeViewBody({super.key});

  static bool isOrganization = true;

  @override
  State<WelcomeViewBody> createState() => _WelcomeViewBodyState();
}

class _WelcomeViewBodyState extends State<WelcomeViewBody> {
  TextEditingController countryController = TextEditingController();
  String phone = "";

  @override
  void initState() {
    countryController.text = "+20";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            "Choose your option",
            style: StyleManager.textStyle18.copyWith(
              color: ColorsManager.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptionWidget(
              onTap: () {
                GoRouter.of(context).push(AppRouter.kLocationView);
                // setState(() {
                //   WelcomeViewBody.isOrganization = true;
                // });
              },
              widget:
              //WelcomeViewBody.isOrganization
                //  ? TappedIconContainer(image: AssetsManager.school)
                //     :
            IconContainer(image: AssetsManager.school),
              text: "Organization",
            ),
            SizedBox(
              width: 70,
            ),
            OptionWidget(
              onTap: ()
              {
                GoRouter.of(context).push(AppRouter.kGradiantRegView);
                // setState(() {
                //   WelcomeViewBody.isOrganization = false;
                // });
              },
              widget:
              //WelcomeViewBody.isOrganization
              //    ?
              IconContainer(image: AssetsManager.guardian),
              //     :
              // TappedIconContainer(
              //         image: AssetsManager.guardian,
              //       ),
              text: "Guardian",
            ),
          ],
        ),
        // SizedBox(
        //   height: 50,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
        //   child: Container(
        //     height: 55,
        //     decoration: BoxDecoration(
        //         border: Border.all(width: 1, color: Colors.grey),
        //         borderRadius: BorderRadius.circular(10)),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           width: 10,
        //         ),
        //         SizedBox(
        //           width: 40,
        //           child: TextField(
        //             controller: countryController,
        //             keyboardType: TextInputType.text,
        //             decoration: InputDecoration(
        //               border: InputBorder.none,
        //             ),
        //           ),
        //         ),
        //         Text(
        //           "|",
        //           style: TextStyle(fontSize: 33, color: Colors.grey),
        //         ),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Expanded(
        //             child: TextField(
        //           onChanged: (val) {
        //             phone = val;
        //           },
        //           keyboardType: TextInputType.phone,
        //           decoration: InputDecoration(
        //             border: InputBorder.none,
        //             hintText: "Phone",
        //           ),
        //         )),
        //         SizedBox(width: 5,),
        //         Padding(
        //           padding: const EdgeInsets.only(right: 8.0, top: 5),
        //           child: Icon(
        //             Icons.phone_enabled,
        //             color: ColorsManager.primary,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        //   // DefaultFormField(
        //   //   labelText: 'Phone',
        //   //   hintText: "tap here phone number",
        //   //   textInputType: TextInputType.phone,
        //   //   controller: TextEditingController(),
        //   //   suffixIcon: Icon(
        //   //     Icons.phone_enabled,
        //   //     color: ColorsManager.primary,
        //   //   ),
        //   // ),
        // ),
        // SizedBox(
        //   height: 50,
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 40.0),
        //   child: WelcomeViewBody.isOrganization
        //       ? BlocBuilder<OtpCubit, OtpState>(
        //           builder: (context, state) {
        //             return DefaultButton(
        //               onTap: () {
        //                 print(
        //                     "***********${countryController.text + phone}************");
        //                 OtpCubit.get(context).sendCode(
        //                     phone: "${countryController.text + phone}",
        //                     context: context);
        //
        //               },
        //               text: "Submit",
        //             );
        //           },
        //         )
        //       : BlocBuilder<GuardianOtpCubit, GuardianOtpState>(
        //           builder: (context, state) {
        //             return DefaultButton(
        //               onTap: () {
        //                 print(
        //                     "***********${countryController.text + phone}************");
        //                 GuardianOtpCubit.get(context).sendCode(
        //                     phone: "${countryController.text + phone}",
        //                     context: context);
        //               },
        //               text: "Submit",
        //             );
        //           },
        //         ),
        // )
      ],
    );
  }
}
