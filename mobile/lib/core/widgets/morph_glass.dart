import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class MorphGlassBackground extends StatelessWidget {
  const MorphGlassBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE6EBFF),
              AppPalette.background,
              Color(0xFFF8ECF8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      Positioned(
        top: -100,
        right: -75,
        child: _GlowOrb(size: 280, color: AppPalette.purpleGlow),
      ),
      Positioned(
        top: 290,
        left: -110,
        child: _GlowOrb(size: 240, color: AppPalette.pinkGlow),
      ),
      Positioned(
        right: -30,
        bottom: 35,
        child: _GlowOrb(size: 210, color: const Color(0x2291EC59)),
      ),
      child,
    ],
  );
}

class MorphGlassPanel extends StatelessWidget {
  const MorphGlassPanel({
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = 24,
    this.tint = AppPalette.glass,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color tint;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tint,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: AppPalette.glassBorder),
          boxShadow: [
            BoxShadow(
              color: AppPalette.primaryDark.withValues(alpha: 0.055),
              blurRadius: 22,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(padding: padding, child: child),
      ),
    ),
  );
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) => ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 36, sigmaY: 36),
    child: Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    ),
  );
}
