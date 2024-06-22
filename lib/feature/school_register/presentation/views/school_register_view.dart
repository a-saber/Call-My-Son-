import 'package:flutter/material.dart';
import 'widgets/school_register_view_body.dart';

class SchoolRegisterView extends StatelessWidget {
  const SchoolRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Create New Organization"),
        ),
        body: SchoolRegisterViewBody(),
      ),
    );
  }
}
