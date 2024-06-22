import 'package:call_son/core/core_widgets/default_form/default_form_field2.dart';
import 'package:call_son/core/core_widgets/pop_up/my_snack_bar.dart';
import 'package:call_son/core/shared_models/guardian_model.dart';
import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/core/shared_models/level_model.dart';
import 'package:call_son/feature/school/presentation/cubit/change_call_status/change_call_status_cubit.dart';
import 'package:call_son/feature/school/presentation/cubit/change_call_status/change_call_status_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core_widgets/pop_up/copy_clipboard.dart';
import '../../../../../core/main_repos/school.dart';
import '../../../../../core/resources_manager/constants_manager.dart';
import '../../../../../core/shared_models/call_model.dart';
import '../../cubit/get_calls/get_calls_cubit.dart';

class SchoolCallsViewBody extends StatelessWidget {
  const SchoolCallsViewBody({super.key, required this.callStatus,});
  final CallStatus callStatus;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> stream=FirebaseFirestore.instance
        .collection(ConstantsManager.callCollection)
        .where('schoolId', isEqualTo: SchoolParent.schoolModel.id)
        .where('status', isEqualTo: callStatus == CallStatus.Waiting? '2': callStatus == CallStatus.Accepted ? '1':'0')
        .orderBy('createdAt', descending: true).snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
      {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if(snapshot.data!.docs.isEmpty)
        {
          return Center(child: Text('No Data'),);
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child:
            DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 650,
                columns: [
                  const DataColumn(
                    label: Center(child: Text('Date & Time')),
                  ),
                  DataColumn(
                    label:  Center(child: Text('Guardian name')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Guardian phone')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Kid name')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Kid level')),
                  ),
                  if(callStatus == CallStatus.Waiting)
                    DataColumn(
                      label: Center(child: Text('Change status')),
                    ),
                  if(callStatus == CallStatus.Rejected)
                    DataColumn(
                      label: Center(child: Text('Reply')),
                    ),
                  if(callStatus != CallStatus.Waiting)
                    DataColumn(
                      label: Center(child: Text(
                          callStatus == CallStatus.Rejected?'Rejected at':'Accepted at')),
                    ),
                ],
                rows: List<DataRow>.generate(
                    snapshot.data!.docs.length,
                    (index)
                    {
                      CallModel callModel = CallModel.fromJson(snapshot.data!.docs[index].data()as Map<String, dynamic>);
                      return DataRow(
                        cells:
                        [
                          DataCell(Center(child: Text(
                            '${DateFormat("yyyy-MM-dd hh:mm:ss").parse(callModel.createdAt!)}'.substring(0,16),
                          textAlign: TextAlign.center,))),
                          DataCell(Center(child: FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection)
                                .doc(callModel.guardianId).get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }

                              if (snapshot.connectionState == ConnectionState.done) {
                                GuardianModel guardian = GuardianModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                                return Text(guardian.name!,textAlign: TextAlign.center);
                              }

                              return Text("loading");
                            },
                          ))),
                          DataCell(Center(child: FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection)
                                .doc(callModel.guardianId).get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }

                              if (snapshot.connectionState == ConnectionState.done) {
                                GuardianModel guardian = GuardianModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                                return InkWell(
                                    onTap: ()
                                    {
                                      copyToClipBoard(context: context, text: guardian.phone! );
                                    },
                                    child: Text(
                                      guardian.phone!,
                                      style: TextStyle(fontWeight: FontWeight.bold)
                                        ,textAlign: TextAlign.center
                                    )
                                );
                              }

                              return Text("loading");
                            },
                          ))),
                          DataCell(Center(child: FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection(ConstantsManager.kidsCollection)
                                .doc(callModel.kidId).get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }

                              if (snapshot.connectionState == ConnectionState.done) {
                                KidModel kid = KidModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                                return Text(kid.name!,textAlign: TextAlign.center);
                              }

                              return Text("loading");
                            },
                          ))),
                          DataCell(Center(child: FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
                                .doc(callModel.schoolId).collection(ConstantsManager.levelCollection)
                                .doc(callModel.levelId).get(),
                            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                              print(callModel.levelId);
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }

                              if (snapshot.connectionState == ConnectionState.done) {
                                LevelModel level = LevelModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                                return Text(level.name!,textAlign: TextAlign.center);
                              }

                              return Text("loading");
                            },
                          ))),
                          if(callStatus == CallStatus.Waiting)
                            DataCell(Center(
                                child: Row(
                                  children: [
                                    CallAction(index: index, accept: true, call: callModel),
                                    SizedBox(width: 1,),
                                    CallAction(index: index, accept: false, call: callModel),
                                  ],
                                )
                            )),
                          if(callStatus == CallStatus.Rejected)
                            DataCell(Center(child: Text('${callModel.reply!}',textAlign: TextAlign.center))),
                          if(callStatus != CallStatus.Waiting)
                          DataCell(Center(child: Text(
                            '${DateFormat("yyyy-MM-dd hh:mm:ss").parse(callModel.editedAt!)}'.substring(0,16),
                            textAlign: TextAlign.center,))),
                      ]);
                    }

                )
            ),
          ),
        );

      },
    );
  }
}

class CallAction extends StatelessWidget {
  const CallAction({super.key, required this.index, required this.accept, required this.call});
  final bool accept;
  final CallModel call;
  final int index;
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return Expanded(
      child: BlocConsumer<ChangeCallStatusCubit, ChangeCallStatusState>(
        listener: (context, state)
        {
          if(state is ChangeCallStatusSuccess && accept)
          {
            GetCallsCubit.get(context).editCalls(index: index, accepted: accept);
            callMySnackBar(context: context, text: state.accepted?'Call Accepted Successfully':'Call Rejected');
          }
          if (state is ChangeCallStatusError && accept)
          {
            callMySnackBar(context: context, text: state.error);
          }
        },
        builder: (context, state)
        {
          return Column(
            children:
            [
              if (state is ChangeCallStatusLoading && accept)
                SizedBox(
                    height:1,child: LinearProgressIndicator()),
              SizedBox(
                height: 20,
                child: Builder(
                  builder: (context) {
                    return IconButton(
                        onPressed: ()async
                        {
                          if(accept) {
                            ChangeCallStatusCubit.get(context).changeCallStatus(
                                callId: call.id!,
                                accepted: accept
                            );
                          }
                          else {
                            var reply = TextEditingController();
                          await showDialog<void>(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Stack(
                                      clipBehavior: Clip.none,
                                      children: <Widget>[
                                        Positioned(
                                          right: -40,
                                          top: -40,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const CircleAvatar(
                                              backgroundColor: Colors.red,
                                              child: Icon(Icons.close),
                                            ),
                                          ),
                                        ),
                                        Form(
                                          key: formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children:
                                            [
                                              Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: Text('Explain to the guardian, why you reject the call'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8),
                                                child: DefaultFormField2(
                                                  hintText: 'Reply',
                                                  controller: reply),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: ElevatedButton(
                                                  child: const Text('Reject Call'),
                                                  onPressed: () {
                                                    if (formKey.currentState!.validate())
                                                    {
                                                      ChangeCallStatusCubit.get(context).changeCallStatus(
                                                          callId: call.id!,
                                                          accepted: accept,
                                                        reply: reply.text,
                                                      );
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        }
                      },
                        icon: accept?
                        Icon(Icons.check, color: Colors.green,):
                        Icon(Icons.close, color: Colors.red,)
                    );
                  }
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

