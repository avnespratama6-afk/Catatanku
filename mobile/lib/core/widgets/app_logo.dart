import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({this.size = 76, super.key});

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: Stack(
      children: [
        Positioned(
          left: size * 0.1,
          top: size * 0.12,
          child: _sheet(size * 0.76, size * 0.78, AppPalette.pink),
        ),
        Positioned(
          left: size * 0.2,
          top: size * 0.1,
          child: _sheet(size * 0.72, size * 0.8, AppPalette.primary),
        ),
        Positioned(
          left: size * 0.31,
          top: size * 0.22,
          child: Container(
            width: size * 0.5,
            height: size * 0.62,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size * 0.1),
            ),
            child: Icon(
              Icons.checklist_rounded,
              color: AppPalette.primary,
              size: size * 0.43,
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: size * 0.04,
          child: Icon(
            Icons.auto_awesome_rounded,
            color: AppPalette.pink,
            size: size * 0.25,
          ),
        ),
      ],
    ),
  );

  Widget _sheet(double width, double height, Color color) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(size * 0.13),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14303D68),
          blurRadius: 12,
          offset: Offset(0, 5),
        ),
      ],
    ),
  );
}
