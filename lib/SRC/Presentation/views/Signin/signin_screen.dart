import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/AuthServices/auth_services.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';
import 'package:reqwest/SRC/Presentation/views/Dashboard/dashboard_screen.dart';
import 'package:reqwest/SRC/Presentation/views/SignUp/signup_screen.dart';
import 'package:reqwest/main.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isObscure = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              (mediaQuery.padding.top + 100).verticalSpace,
              AppText(
                'Sign in to Reqwest',
                style: theme.textTheme.headlineMedium,
              ),
              48.verticalSpace,
              AppTextField(
                controller: emailController,
                labelText: 'Email',
              ),
              12.verticalSpace,
              AppTextField(
                controller: passwordController,
                labelText: 'Password',
                obscureText: isObscure,
                suffixIcon: DynamicAppIconHandler.buildIcon(
                  context: context,
                  icon: isObscure ? Icons.visibility_off : Icons.visibility,
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                ),
              ),
              14.verticalSpace,
              Row(
                children: [
                  // const Icon(Icons.check_box_outline_blank),
                  // 8.horizontalSpace,
                  // AppText(
                  //   'Remember me',
                  //   style: theme.textTheme.bodyMedium,
                  // ),
                  const Spacer(),
                  AppText(
                    'Forgot Password?',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              30.verticalSpace,
              CommonButton(
                text: 'Sign in',
                onTap: () async {
                  if (!formKey.currentState!.validate()) return;
                  showLoading();
                  final res = await AuthServices.instance.login(
                      email: emailController.text.trim(),
                      password: passwordController.text);
                  if (res is UserModel) {
                    AuthServices.instance.userModel = res;
                    isStaffFlow =
                        AuthServices.instance.userModel!.role == 'staff';
                    context.pushAndRemoveUntil(
                        const DashboardScreen(), (route) => false);
                  } else {
                    showToast(res);
                  }
                  dismiss();
                },
              ),
              20.verticalSpace,
              RichText(
                  text: TextSpan(
                text:
                    'By Clicking “ Sign in” You certify that you agree to our ',
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: 'Privacy policy ',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: 'and ',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    text: 'Terms and Conditions',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              )),
              (mediaQuery.size.height * 0.2).verticalSpace,
              CommonButton(
                text: 'New user? REGISTER',
                onTap: () {
                  context.to(const SignUpScreen());
                },
                backgroundColor: theme.colorScheme.secondary,
                textColor: theme.colorScheme.onSurface,
              )
            ],
          ),
        ),
      ),
    );
  }
}
