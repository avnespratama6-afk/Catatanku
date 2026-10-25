import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'core/widgets/morph_glass.dart';
import 'features/splash/screens/splash_screen.dart';

void main() => runApp(const Catatanku());

class Catatanku extends StatelessWidget {
  const Catatanku({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Catatanku',
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    builder: (context, child) =>
        MorphGlassBackground(child: child ?? const SizedBox.shrink()),
    home: const SplashScreen(),
  );
}
