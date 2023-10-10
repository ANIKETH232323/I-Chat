import 'package:flutter/material.dart';

class Custom_Navigation_Button extends StatelessWidget {
  final Widget icon;
  final Function()? onPressed;
  const Custom_Navigation_Button({
    super.key,
    required this.icon,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25)
      ),
      child: IconButton(onPressed: onPressed,icon: icon,),
    );
  }
}















