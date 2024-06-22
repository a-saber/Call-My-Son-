import 'package:call_son/core/core_widgets/pop_up/my_snack_bar.dart';
import 'package:call_son/core/resources_manager/constants_manager.dart';
import 'package:call_son/feature/guardian/presentation/cubit/call/call_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultView extends StatelessWidget {
  const ResultView({super.key, required this.kid, required this.school});
  final String kid;
  final String school;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wait For Response'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Text('Request call your kid : $kid'),
            Text('From School : $school'),
            BlocConsumer<CallCubit, CallState>(
              listener: (context, state)
              {
                if(state is CallSuccess)
                {
                  callMySnackBar(context: context, text: 'Call Sent Successfully');
                }
              },
              builder: (context, state)
              {
                if(state is CallLoading)
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(state is CallError)
                {
                  return Center(
                    child: Text(state.error),
                  );
                }
                else if(state is CallSuccess)
                {
                  return StreamBuilder<DocumentSnapshot> (
                    stream: FirebaseFirestore.instance
                    .collection(ConstantsManager.callCollection)
                    .doc(state.id).snapshots(),
                    builder: (context, snapshot)
                    {
                      if(snapshot.data != null){
                        if(snapshot.data!['status']=='2')
                          return Row(
                            children: [
                              Text('Your Call Request Status is '),
                              Text('Waiting'),
                            ],
                          );
                        else if(snapshot.data!['status']=='1')
                          return Row(
                            children:
                            [
                              Text('Your Call Request Status is '),
                              Text('Accepted'),
                            ],
                          );
                        else
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Row(
                                children: [
                                  Text('Your Call Request Status is '),
                                  Text('Rejected'),
                                ],
                              ),
                              Text('School reply : ${snapshot.data!['reply']}')
                            ],
                          );
                      }
                      else{
                        return Container();
                      }
                    },
                  );
                }

                return SizedBox();
              }
            )
          ],
        ),
      ),
    );
  }
}
