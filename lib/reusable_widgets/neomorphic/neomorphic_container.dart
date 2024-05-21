import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class neomorphic_container extends StatelessWidget {
  Color? shadowColor1;
  Color? shadowColor2;
  double? borderRadius;
  Color? backgroundColor;
  double? height;
  double? width;
  Widget? child;
  double? padding;
  bool isGlass = false;
  neomorphic_container({super.key, this.padding, this.backgroundColor, required this.isGlass, this.borderRadius, this.height, this.shadowColor1, this.shadowColor2, this.width, this.child});

  @override
  Widget build(BuildContext context) {
    return isGlass
        ? BackdropFilter(
            filter: ImageFilter.blur(),
            child: Container(
              height: height,
              width: width,
              child: Padding(
                padding: EdgeInsets.all(padding!),
                child: child,
              ),
              decoration: BoxDecoration(color: AdaptiveTheme.of(context).mode.isDark ? Colors.black26 : Colors.white24, borderRadius: BorderRadius.circular(borderRadius!), boxShadow: [
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
          )
        : Container(
            height: height,
            width: width,
            padding: EdgeInsets.all(24),
            child: child,
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
          );
  }
}
