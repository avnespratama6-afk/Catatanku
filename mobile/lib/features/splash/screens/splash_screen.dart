
import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/app_logo.dart';
import '../../auth/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _animation = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..forward();

    _timer = Timer(const Duration(milliseconds: 8500), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final opening = CurvedAnimation(
      parent: _animation,
      curve: const Interval(0.05, 0.85, curve: Curves.easeInOutCubic),
    );

    final reveal = CurvedAnimation(
      parent: _animation,
      curve: const Interval(0.65, 1, curve: Curves.easeOutCubic),
    );

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFB8C5FF),
              Color(0xFFE2E7FF),
              Color(0xFFF5E7FA),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: 92,
              left: 46,
              child: Icon(
                Icons.auto_awesome_rounded,
                color: Color(0xFF8794E8),
                size: 24,
              ),
            ),
            const Positioned(
              right: 42,
              bottom: 120,
              child: Icon(
                Icons.star_rounded,
                color: Color(0xFFE7A8D5),
                size: 28,
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 38,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.82),
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.9),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppPalette.primary.withValues(alpha: 0.17),
                      blurRadius: 34,
                      offset: const Offset(0, 16),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 160,
                      height: 125,
                      child: AnimatedBuilder(
                        animation: opening,
                        builder: (context, child) {
                          final progress = opening.value;

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 148,
                                height: 104,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFCF4),
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppPalette.primary.withValues(
                                        alpha: 0.12,
                                      ),
                                      blurRadius: 12,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Expanded(child: _BookPage()),
                                    Container(
                                      width: 1.5,
                                      color: const Color(0xFFD9D4E8),
                                    ),
                                    const Expanded(child: _BookPage()),
                                  ],
                                ),
                              ),
                              Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.0015)
                                  ..rotateY(-math.pi * progress * 0.48),
                                child: Opacity(
                                  opacity: (1 - progress * 0.15)
                                      .clamp(0.0, 1.0),
                                  child: Container(
                                    width: 148,
                                    height: 104,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF777FE0),
                                          Color(0xFF9B9DEB),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.6,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppPalette.primary.withValues(
                                            alpha: 0.22 * (1 - progress),
                                          ),
                                          blurRadius: 14,
                                          offset: const Offset(3, 5),
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: AppLogo(size: 52),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    FadeTransition(
                      opacity: reveal,
                      child: Column(
                        children: [
                          Text(
                            'Catatanku',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: AppPalette.primaryDark,
                                ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Langkah kecil, hari lebih terarah.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppPalette.muted),
                          ),
                          const SizedBox(height: 24),
                          const SizedBox(
                            width: 23,
                            height: 23,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.6,
                              color: AppPalette.primary,
                              backgroundColor: AppPalette.lilac,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookPage extends StatelessWidget {
  const _BookPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (_) => Container(
            height: 2,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFFD8D7EA),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
