import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AnimatedNavigationBar extends StatelessWidget {
  const AnimatedNavigationBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const _destinations = [
    (icon: Icons.home_outlined, active: Icons.home_rounded, label: 'Beranda'),
    (
      icon: Icons.archive_outlined,
      active: Icons.archive_rounded,
      label: 'Arsip',
    ),
    (
      icon: Icons.person_outline_rounded,
      active: Icons.person_rounded,
      label: 'Profil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 98,
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: selectedIndex.toDouble()),
          duration: const Duration(milliseconds: 650),
          curve: Curves.easeInOutCubicEmphasized,
          builder: (context, position, _) => Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 12,
                right: 12,
                top: 18,
                height: 72,
                child: CustomPaint(
                  painter: _NotchPainter(position),
                  child: const SizedBox.expand(),
                ),
              ),
              Positioned(
                left: 12,
                right: 12,
                top: 18,
                height: 72,
                child: Row(
                  children: List.generate(_destinations.length, (index) {
                    final item = _destinations[index];
                    final selected = selectedIndex == index;

                    return Expanded(
                      child: Semantics(
                        button: true,
                        selected: selected,
                        label: item.label,
                        child: InkWell(
                          onTap: () => onDestinationSelected(index),
                          borderRadius: BorderRadius.circular(24),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AnimatedScale(
                                scale: selected ? 1.08 : 1,
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeOutCubic,
                                child: Icon(
                                  selected ? item.active : item.icon,
                                  size: 22,
                                  color: selected
                                      ? AppPalette.primaryDark
                                      : Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item.label,
                                style: TextStyle(
                                  color: selected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 6),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              IgnorePointer(
                child: Align(
                  alignment: Alignment(
                    -1 + (position + 0.5) / _destinations.length * 2,
                    -0.306,
                  ),
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: AppPalette.primary,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppPalette.primary.withValues(alpha: 0.28),
                          blurRadius: 22,
                          offset: const Offset(0, 7),
                        ),
                      ],
                    ),
                    child: Icon(
                      _destinations[selectedIndex].active,
                      color: AppPalette.primaryDark,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotchPainter extends CustomPainter {
  const _NotchPainter(this.position);

  final double position;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.width * (position + 0.5) / 3;
    final path = Path()
      ..moveTo(24, 0)
      ..lineTo(center - 33, 0)
      ..cubicTo(center - 17, 0, center - 20, 35, center, 35)
      ..cubicTo(center + 20, 35, center + 17, 0, center + 33, 0)
      ..lineTo(size.width - 24, 0)
      ..quadraticBezierTo(size.width, 0, size.width, 24)
      ..lineTo(size.width, size.height - 24)
      ..quadraticBezierTo(size.width, size.height, size.width - 24, size.height)
      ..lineTo(24, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - 24)
      ..lineTo(0, 24)
      ..quadraticBezierTo(0, 0, 24, 0)
      ..close();

    canvas.drawShadow(path, Colors.black.withValues(alpha: 0.22), 12, false);
    canvas.drawPath(path, Paint()..color = AppPalette.navigation);
  }

  @override
  bool shouldRepaint(covariant _NotchPainter oldDelegate) =>
      oldDelegate.position != position;
}
