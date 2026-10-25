import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TapButton extends StatefulWidget {
  const TapButton({
    required this.label,
    required this.onTap,
    this.icon,
    this.secondary = false,
    this.danger = false,
    super.key,
  });

  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final bool secondary;
  final bool danger;

  @override
  State<TapButton> createState() => _TapButtonState();
}

class _TapButtonState extends State<TapButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final foreground = widget.danger
        ? AppPalette.danger
        : widget.secondary
        ? AppPalette.primary
        : Colors.white;
    final background = widget.danger
        ? AppPalette.blush
        : widget.secondary
        ? AppPalette.lilac
        : AppPalette.primary;

    return AnimatedScale(
      scale: _pressed ? 0.96 : 1,
      duration: const Duration(milliseconds: 110),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          borderRadius: BorderRadius.circular(19),
          onTap: widget.onTap,
          onTapDown: (_) => setState(() => _pressed = true),
          onTapCancel: () => setState(() => _pressed = false),
          onTapUp: (_) => setState(() => _pressed = false),
          child: Container(
            constraints: const BoxConstraints(minHeight: 54),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: background,
              gradient: widget.secondary || widget.danger
                  ? null
                  : const LinearGradient(
                      colors: [Color(0xFFAA83E7), AppPalette.primary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(22),
              border: widget.secondary || widget.danger
                  ? Border.all(color: foreground.withValues(alpha: 0.16))
                  : null,
              boxShadow: widget.secondary || widget.danger
                  ? null
                  : [
                      BoxShadow(
                        color: AppPalette.primary.withValues(alpha: 0.22),
                        blurRadius: 16,
                        offset: const Offset(0, 7),
                      ),
                    ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 19, color: foreground),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
