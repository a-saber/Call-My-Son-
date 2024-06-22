import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:flutter/material.dart';

import '../resources_manager/style_manager.dart';



class MyTabBarView extends StatelessWidget {
  const MyTabBarView({Key? key,
    required this.length,
    required this.tabs,
    required this.onTab,
    this.isScrollable = false,
  }) : super(key: key);
  final int length;
  final List<Widget> tabs;
  final void Function(int)? onTab;
  final bool isScrollable;
  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
      length: length,
      child: TabBar(
        indicatorWeight: 2.5,
        padding: const EdgeInsets.only(right: 5),
        indicatorSize: TabBarIndicatorSize.tab,
        //indicatorPadding: const EdgeInsets.only(left: 10,right: 10),
        indicatorColor: ColorsManager.formFillColor,
        isScrollable: isScrollable,
        onTap: onTab,
        tabs: tabs,
      ),
    );
  }
}

class TabBarItem extends StatelessWidget {
  const TabBarItem({Key? key, required this.label, this.selected = true}) : super(key: key);

  final bool selected;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
        left: 5,
        right: 5,
        top: 10,
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(color: selected? ColorsManager.primary: ColorsManager.primary.withOpacity(0.5), fontWeight: FontWeight.w700),
      ),
    );
  }
}