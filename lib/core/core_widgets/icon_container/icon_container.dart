import 'package:call_son/core/resources_manager/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: ColorsManager.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: SvgPicture.asset(image,width: 50,height: 50,),
      ),
    );
  }
}
