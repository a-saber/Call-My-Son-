import 'package:call_son/core/shared_models/school_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/core_widgets/pop_up/copy_clipboard.dart';
import '../../../../../core/main_repos/guardian.dart';
import '../../../../../core/main_repos/school.dart';
import '../../../../../core/resources_manager/constants_manager.dart';
import '../../../../../core/shared_models/call_model.dart';
import '../../../../../core/shared_models/guardian_model.dart';
import '../../../../../core/shared_models/kid_model.dart';
import '../../../../../core/shared_models/level_model.dart';
import '../../../../school/presentation/views/widgets/school_calls_view_body.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key, required this.callStatus,});
  final CallStatus callStatus;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance
          .collection(ConstantsManager.callCollection)
          .where('guardianId', isEqualTo: GuardianParent.guardianModel.id)
      .where('status',
          isEqualTo: callStatus==CallStatus.Waiting ?'2' :
          callStatus==CallStatus.Accepted?'1':'0')
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
        print(snapshot.data!.docs.length);
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
                    label: Center(child: Text('Requested at')),
                  ),
                  DataColumn(
                    label:  Center(child: Text('Kid')),
                  ),
                  DataColumn(
                    label: Center(child: Text('School')),
                  ),
                  if(callStatus == CallStatus.Rejected )
                    DataColumn(
                      label: Center(child: Text('Reply')),
                    ),
                  if(callStatus != CallStatus.Waiting)
                    DataColumn(
                      label: Center(child: Text(
                          callStatus == CallStatus.Rejected? 'Rejected at':'Accepted at')
                      ),
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
                                  .doc(callModel.schoolId).get(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.hasData && !snapshot.data!.exists) {
                                  return Text("Document does not exist");
                                }

                                if (snapshot.connectionState == ConnectionState.done) {
                                  SchoolModel school = SchoolModel.fromJson(snapshot.data!.data() as Map<String, dynamic>);
                                  return Text(
                                      school.name!,
                                      style: TextStyle(fontWeight: FontWeight.bold)
                                      ,textAlign: TextAlign.center
                                  );
                                }

                                return Text("loading");
                              },
                            ))),

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