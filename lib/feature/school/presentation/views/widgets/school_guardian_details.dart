import 'package:call_son/core/shared_models/kid_model.dart';
import 'package:call_son/core/shared_models/level_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core_widgets/pop_up/copy_clipboard.dart';
import '../../../../../core/main_repos/school.dart';
import '../../../../../core/resources_manager/constants_manager.dart';
import '../../../../../core/shared_models/guardian_model.dart';

class SchoolGuardianDetailsView extends StatelessWidget {
  const SchoolGuardianDetailsView({super.key, required this.guardianId});
  final String guardianId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection(ConstantsManager.guardianCollection)
              .doc(guardianId).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> guardianSnapshot) {
            if (guardianSnapshot.hasError) {
              return Text("Something went wrong");
            }

            if (guardianSnapshot.hasData && !guardianSnapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (guardianSnapshot.connectionState == ConnectionState.done)
            {
              GuardianModel guardian = GuardianModel.fromJson(guardianSnapshot.data!.data() as Map<String, dynamic>);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children:
                [
                  Text(
                    '${guardian.name}',
                    textAlign: TextAlign.center
                  ),
                  InkWell(
                      onTap: ()
                      {
                        copyToClipBoard(context: context, text: guardian.phone! );
                      },
                      child: Text(
                          '${guardian.phone}',
                          style: TextStyle(fontWeight: FontWeight.bold)
                          ,textAlign: TextAlign.center
                      )
                  ),
                  SizedBox(height: 15,),
                  StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(ConstantsManager.schoolCollection)
                      .doc(SchoolParent.schoolModel.id)
                      .collection(ConstantsManager.guardianCollection)
                      .doc(guardianId).collection(ConstantsManager.kidsCollection)
                      .snapshots(),
                  builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                  {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    return Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index)
                        {
                          var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              Text('Kid ${index+1}'),
                              FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                .collection(ConstantsManager.kidsCollection)
                                .doc(snapshot.data!.docs[index].id).get(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
                              {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.hasData && !snapshot.data!.exists) {
                                  return Text("Document does not exist");
                                }

                                if (snapshot.connectionState == ConnectionState.done)
                                {
                                  KidModel kidModel = KidModel.fromJson(snapshot.data!.data()! as Map<String, dynamic>);
                                  return Text(kidModel.name!);
                                }
                                return Text('Loading');
                              }),
                              FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                .collection(ConstantsManager.schoolCollection)
                                .doc(SchoolParent.schoolModel.id)
                                  .collection(ConstantsManager.levelCollection)
                                  .doc(data['levelId']).get(),
                              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot)
                              {
                                if (snapshot.hasError) {
                                  return Text("Something went wrong");
                                }

                                if (snapshot.hasData && !snapshot.data!.exists) {
                                  return Text("Document does not exist");
                                }

                                if (snapshot.connectionState == ConnectionState.done)
                                {
                                  LevelModel level = LevelModel.fromJson(snapshot.data!.data()! as Map<String, dynamic>);
                                  return Text(level.name!);
                                }
                                return Text('Loading');
                              }),
                              Text('${data['verified']?'verified':'unVerified'}'),
                              if(!data['verified'])
                                ElevatedButton(
                                  onPressed: ()async
                                  {
                                    await FirebaseFirestore.instance.collection(ConstantsManager.schoolCollection)
                                        .doc(SchoolParent.schoolModel.id).collection(ConstantsManager.guardianCollection)
                                        .doc(guardianId).collection(ConstantsManager.kidsCollection)
                                        .doc(snapshot.data!.docs[index].id).update({'verified':true});
                                  }, child: Text('Verify'))
                            ],
                          );
                        },
                        separatorBuilder: (context, index)=>SizedBox(height: 10,),
                        itemCount: snapshot.data!.docs.length
                      ),
                    );
                  })
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
