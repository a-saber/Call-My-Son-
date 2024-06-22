import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/resources_manager/color_manager.dart';
import '../../../../../core/shared_models/school_model.dart';
import '../../cubit/get_schools/get_school_cubit.dart';
import '../../cubit/get_schools/get_school_state.dart';

class SchoolsBottomSheetBody extends StatelessWidget {
  SchoolsBottomSheetBody({super.key,
    required this.isSearch,
    required this.search,
    required this.onTap,

  });

  bool isSearch;
  final TextEditingController search;
  final void Function(SchoolModel model) onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            //color: Colors.white,
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
          padding: EdgeInsets.symmetric(
              vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocConsumer<GetSchoolsCubit, GetSchoolsState>(
                  listener: (context, state) {},
                  builder: (context, state)
                  {
                    if (state is GetSchoolsLoading )
                    {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator()),
                          ],
                        ),
                      );
                    }
                    else if (state is GetSchoolsError)
                    {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.error),
                          ],
                        ),
                      );
                    }

                    else if (state is GetSchoolsSuccess)
                    {
                      return SchoolBottomSheetListBuilder(
                          title: 'All Schools',
                          schools: state.schools,
                          onTap: onTap
                      );
                    }
                    else
                    {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(),
                          ],
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ],
    );
  }
}

class SchoolBottomSheetListBuilder extends StatelessWidget {
  const SchoolBottomSheetListBuilder({super.key,
    required this.title,
    required this.schools,
    required this.onTap
  });

  final String title;
  final List<SchoolModel> schools;
  final void Function(SchoolModel school) onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            width: double.infinity,
            color: Colors.grey.withOpacity(0.2),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: schools.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 7),
                  child: InkWell(
                    onTap: ()
                    {
                      onTap( schools[index]);
                    },
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Icon(
                                Icons.school,
                                size: 20,
                                color: ColorsManager.primary
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                schools[index].name!,
                                style: TextStyle(
                                    fontWeight:
                                    FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Divider()
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

