import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:flutter/material.dart';

import 'icon_container.dart';
class TappedIconContainer extends StatelessWidget {
  const TappedIconContainer({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: ColorsManager.borderColor,
        border: Border.all(color: ColorsManager.borderColor,width: 10),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconContainer(image: image,),
    );
  }
}
