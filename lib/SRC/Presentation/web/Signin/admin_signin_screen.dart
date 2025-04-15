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
import 'package:reqwest/SRC/Presentation/web/dashboard/admin_dashboard_screen.dart';
import 'package:reqwest/main.dart';

class AdminSigninScreen extends StatefulWidget {
  const AdminSigninScreen({super.key});

  @override
  State<AdminSigninScreen> createState() => _AdminSigninScreenState();
}

class _AdminSigninScreenState extends State<AdminSigninScreen> {
  bool isObscure = false;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController(text: 'admin@reqwest.com');
  final passwordController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width / 2,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                    48.verticalSpace,
                    CommonButton(
                      text: 'Sign in',
                      onTap: () async {
                        if (!formKey.currentState!.validate()) return;
                        showLoading();
                        final res = await AuthServices.instance
                            .login(email: emailController.text.trim(), password: passwordController.text);
                        if (res is UserModel) {
                          // AuthServices.instance.userModel = res;
                          // isStaffFlow = AuthServices.instance.userModel!.role == 'staff';
                          context.pushAndRemoveUntil(const AdminDashboard(), (route) => false);
                        } else {
                          showToast(res);
                        }
                        dismiss();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
