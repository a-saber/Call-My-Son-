import 'package:call_son/feature/school/presentation/views/widgets/school_guardian_view_body.dart';
import 'package:flutter/material.dart';


class SchoolGuardiansView extends StatelessWidget {
  const SchoolGuardiansView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guardian'),
      ),
      body: SafeArea(
        child: Column(
          children:
          [
            SchoolGuardiansViewBody()
          ],
        ),
      ),
    );
  }
}

// MyTabBarView(
//   length: 2,
//   onTab: (index) {
//     if (index == 0)
//     {
//       isNotVerify = true;
//     }
//     else
//     {
//       isNotVerify = false;
//     }
//     setState(() {});
//   },
//   tabs: [
//     TabBarItem(
//         selected: isNotVerify,
//         label: 'UnVerified'.toUpperCase()),
//     TabBarItem(
//         selected: !isNotVerify,
//         label: 'Verified'.toUpperCase()),
//   ],
// ),