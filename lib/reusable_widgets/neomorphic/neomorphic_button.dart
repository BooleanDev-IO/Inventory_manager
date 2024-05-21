import 'package:flutter/material.dart';

class neomorphic_Button extends StatelessWidget {
  Color? shadowColor1;
  Color? shadowColor2;
  double? borderRadius;
  Color? backgroundColor;
  double? height;
  double? width;
  String? buttonText;
  Function? onbuttonPressed;

  neomorphic_Button({
    super.key,
    this.backgroundColor,
    this.borderRadius,
    this.buttonText,
    this.height,
    this.onbuttonPressed,
    this.shadowColor1,
    this.shadowColor2,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onbuttonPressed!();
      },
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(24),
        child: Text(buttonText!, style: Theme.of(context).textTheme.titleMedium),
        decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(borderRadius!), boxShadow: [
          BoxShadow(
            // color: Color(0xFFBEBEBE),
            color: shadowColor1!,
            offset: Offset(10, 10),
            blurRadius: 20,
            spreadRadius: 1,
          ),
          BoxShadow(
            // color: Colors.white,
            color: shadowColor2!,
            offset: Offset(-10, -10),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ]),
      ),
    );
  }
}
