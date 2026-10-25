
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/widgets/app_logo.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/tap_button.dart';

class LoginContent extends StatelessWidget {
  const LoginContent({
    required this.email,
    required this.password,
    required this.passwordVisible,
    required this.onTogglePassword,
    required this.onLogin,
    super.key,
  });

  final TextEditingController email;
  final TextEditingController password;
  final bool passwordVisible;
  final VoidCallback onTogglePassword;
  final VoidCallback onLogin;

  void _showSocialMessage(BuildContext context, String provider) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            'Login $provider belum dikonfigurasi.',
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final compact = size.height < 750;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: AppPalette.primary.withValues(alpha: 0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppPalette.primary.withValues(alpha: 0.13),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: AppLogo(size: compact ? 68 : 78),
          ),
        ),
        SizedBox(height: compact ? 16 : 22),

        Text(
          'Catatanku',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppPalette.primaryDark,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: 6),

        Text(
          'Masuk untuk melanjutkan',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: AppPalette.muted,
          ),
        ),
        SizedBox(height: compact ? 22 : 30),

        _LoginInput(
          controller: email,
          hint: 'Email contoh: user@gmail.com',
          icon: Icons.mail_outline_rounded,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 14),

        _LoginInput(
          controller: password,
          hint: 'Kata sandi',
          icon: Icons.lock_outline_rounded,
          obscureText: !passwordVisible,
          suffix: IconButton(
            onPressed: onTogglePassword,
            tooltip: passwordVisible
                ? 'Sembunyikan kata sandi'
                : 'Tampilkan kata sandi',
            icon: Icon(
              passwordVisible
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppPalette.muted,
            ),
          ),
        ),
        SizedBox(height: compact ? 18 : 24),

        TapButton(
          label: 'Masuk',
          onTap: onLogin,
        ),
        SizedBox(height: compact ? 18 : 24),

        Row(
          children: [
            Expanded(
              child: Divider(
                color: AppPalette.border,
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'atau masuk dengan',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppPalette.muted,
                ),
              ),
            ),
            Expanded(
              child: Divider(
                color: AppPalette.border,
                thickness: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 16 : 20),

        _SocialLoginButton(
          label: 'Google',
          icon: const FaIcon(
            FontAwesomeIcons.google,
            size: 19,
            color: Color(0xFF4285F4),
          ),
          onTap: () => _showSocialMessage(context, 'Google'),
        ),
        const SizedBox(height: 12),

        _SocialLoginButton(
          label: 'Apple',
          icon: const FaIcon(
            FontAwesomeIcons.apple,
            size: 23,
            color: Colors.black,
          ),
          onTap: () => _showSocialMessage(context, 'Apple'),
        ),
        const SizedBox(height: 12),

        _SocialLoginButton(
          label: 'Facebook',
          icon: const FaIcon(
            FontAwesomeIcons.facebook,
            size: 21,
            color: Color(0xFF1877F2),
          ),
          onTap: () => _showSocialMessage(context, 'Facebook'),
        ),
        const SizedBox(height: 18),

        Text(
          'Dengan masuk, kamu bisa mengelola catatan dan '
          'menyimpan ide pentingmu dalam satu tempat.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppPalette.muted,
            height: 1.5,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _LoginInput extends StatelessWidget {
  const _LoginInput({
    required this.controller,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.suffix,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(
          icon,
          color: AppPalette.muted,
          size: 21,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.88),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(color: AppPalette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(color: AppPalette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: AppPalette.primary,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class _SocialLoginButton extends StatelessWidget {
  const _SocialLoginButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white.withValues(alpha: 0.88),
        foregroundColor: AppPalette.primaryDark,
        minimumSize: const Size.fromHeight(52),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 13,
        ),
        side: BorderSide(color: AppPalette.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Center(child: icon),
          ),
          Expanded(
            child: Text(
              'Masuk dengan $label',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 30),
        ],
      ),
    );
  }
}
