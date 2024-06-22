import 'package:call_son/feature/school/presentation/views/widgets/school_calls_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/core_widgets/my_tab_bar_view.dart';
import '../../../../core/shared_models/call_model.dart';


class SchoolCallsView extends StatefulWidget {
  const SchoolCallsView({super.key});

  @override
  State<SchoolCallsView> createState() => _SchoolCallsViewState();
}
class _SchoolCallsViewState extends State<SchoolCallsView> {

  CallStatus callStatus = CallStatus.Waiting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calls'),
      ),
      body: SafeArea(
        child: Column(
          children:
          [
            MyTabBarView(
              length: 3,
              onTab: (index)
              {
                if (index == 0)
                {
                  callStatus = CallStatus.Waiting;
                }
                else if(index == 1)
                {
                  callStatus = CallStatus.Accepted;
                }
                else
                {
                  callStatus = CallStatus.Rejected;
                }
                setState(() {});
              },
              tabs: [
                TabBarItem(
                    selected: callStatus == CallStatus.Waiting,
                    label: 'Waiting'.toUpperCase()),
                TabBarItem(
                    selected: callStatus == CallStatus.Accepted,
                    label: 'Accepted'.toUpperCase()),
                TabBarItem(
                    selected: callStatus == CallStatus.Rejected,
                    label: 'Rejected'.toUpperCase()),
              ],
            ),
            Builder(
              builder: (BuildContext context)
              {
                return SchoolCallsViewBody(callStatus: callStatus,);
              },
            ),

          ],
        ),
      ),
    );
  }
}
