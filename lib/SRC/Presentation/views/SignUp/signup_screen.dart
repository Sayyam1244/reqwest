import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/views/RoleSelection/role_selection_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscure = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (mediaQuery.padding.top + 100).verticalSpace,
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Re', style: theme.textTheme.headlineMedium),
              TextSpan(
                  text: 'qwest',
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(color: Theme.of(context).primaryColor)),
            ])),
            10.verticalSpace,
            const Text('Shop more, Earn more, Reward yourself'),
            10.verticalSpace,
            Row(
              children: [
                const Expanded(
                  child: AppTextField(
                    labelText: 'First Name',
                  ),
                ),
                10.horizontalSpace,
                const Expanded(
                  child: AppTextField(
                    labelText: 'Last Name',
                  ),
                ),
              ],
            ),
            35.horizontalSpace,
            const AppTextField(
              labelText: 'Email',
            ),
            const AppTextField(
              labelText: 'Phone Number',
            ),
            AppTextField(
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
            AppTextField(
              labelText: 'Confirm Password',
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
            60.verticalSpace,
            CommonButton(
              text: 'Sign Up',
              onTap: () {
                context.to(const RoleSelection());
              },
            ),
            20.verticalSpace,
            RichText(
                text: TextSpan(
              text: 'By Clicking “ Sign up” You certify that you agree to our ',
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
            (mediaQuery.size.height * 0.05).verticalSpace,
            CommonButton(
              text: 'Already have an account? SIGN IN',
              onTap: () {
                context.back();
              },
              backgroundColor: theme.colorScheme.secondary,
              textColor: theme.colorScheme.onBackground,
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
