import 'package:flutter/material.dart';

import 'neomorphic_container.dart';

class neomorphic_TextFormField extends StatelessWidget {
  String? label;
  Color? shadowColor1;
  Color? shadowColor2;
  double? borderRadius;
  Color? backgroundColor;
  double? height;
  double? width;
  neomorphic_TextFormField({super.key, this.backgroundColor, this.borderRadius, this.height, this.label, this.shadowColor1, this.shadowColor2, this.width});

  @override
  Widget build(BuildContext context) {
    return neomorphic_container(
      height: height,
      isGlass: false,
      width: width,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      shadowColor1: shadowColor1,
      shadowColor2: shadowColor2,
      child: TextFormField(
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          border: InputBorder.none,
          // label: Text(label!),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
