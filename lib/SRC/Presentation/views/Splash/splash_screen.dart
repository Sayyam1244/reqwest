import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:reqwest/SRC/Presentation/Common/logo_widget.dart';
import 'package:reqwest/SRC/Presentation/views/Signin/signin_screen.dart';
import 'package:reqwest/SRC/Presentation/web/Signin/admin_signin_screen.dart';
import 'package:reqwest/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      if (isWeb) {
        context.to(const AdminSigninScreen());
      } else {
        context.to(const SigninScreen());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: const Center(
        child: LogoWidget(),
      ),
    );
  }
}
