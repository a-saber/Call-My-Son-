import 'package:call_son/feature/school/presentation/views/widgets/school_guardian_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core_widgets/pop_up/copy_clipboard.dart';
import '../../../../../core/main_repos/school.dart';
import '../../../../../core/resources_manager/constants_manager.dart';
import '../../../../../core/shared_models/guardian_model.dart';

class SchoolGuardiansViewBody extends StatelessWidget {
  const SchoolGuardiansViewBody({super.key,});

  @override
  Widget build(BuildContext context) {

    print(SchoolParent.schoolModel.id);
    print(ConstantsManager.schoolCollection);
    print(ConstantsManager.guardianCollection);
    FirebaseFirestore.instance
        .collection(ConstantsManager.schoolCollection)
        .doc(SchoolParent.schoolModel.id)
        .collection(ConstantsManager.guardianCollection)
        .get().then((value) {
      print('object');
      print(value.docs.length);
      print(value.docs[0].id);
    });
    final Stream<QuerySnapshot> stream=FirebaseFirestore.instance
    .collection(ConstantsManager.schoolCollection)
    .doc(SchoolParent.schoolModel.id)
    .collection(ConstantsManager.guardianCollection).snapshots();

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
                minWidth: 400,
                columns: [
                  DataColumn(
                    label:  Center(child: Text('Name')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Phone')),
                  ),
                  DataColumn(
                    label: Center(child: Text('Kids')),
                  ),
                  DataColumn(
                    label: Center(child: Text('More details')),
                  ),
                ],
                rows: List<DataRow>.generate(
                    snapshot.data!.docs.length,
                        (index)
                    {
                      return DataRow(
                          cells:
                          [
                            DataCell(Center(child: FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance.collection(ConstantsManager.guardianCollection)
                                  .doc(snapshot.data!.docs[index].id).get(),
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
                                  .doc(snapshot.data!.docs[index].id).get(),
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
                                          '${guardian.phone}',
                                          style: TextStyle(fontWeight: FontWeight.bold)
                                          ,textAlign: TextAlign.center
                                      )
                                  );
                                }

                                return Text("loading");
                              },
                            ))),
                            DataCell(Center(child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection(ConstantsManager.schoolCollection)
                                  .doc(SchoolParent.schoolModel.id)
                                  .collection(ConstantsManager.guardianCollection)
                                  .doc(snapshot.data!.docs[index].id).collection(ConstantsManager.kidsCollection)
                                  .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                            {
                              if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              return Center(child: Text('${snapshot.data!.docs.length}'),);
                            },))),
                            DataCell(Center(
                              child: ElevatedButton(
                                onPressed: ()
                                {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context)=>SchoolGuardianDetailsView(guardianId: snapshot.data!.docs[index].id,)));
                                }, child: Text('Details')
                              )
                            )),
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