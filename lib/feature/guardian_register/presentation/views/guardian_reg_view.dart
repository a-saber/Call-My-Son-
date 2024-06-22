import 'package:flutter/material.dart';

import 'widgets/guardian_reg_view_body.dart';

class GuardianRegView extends StatelessWidget {
  const GuardianRegView({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Create New Guardian"),
        ),
        body: GuardianRegViewBody(scaffoldKey: scaffoldKey),
      ),
    );
  }
}
