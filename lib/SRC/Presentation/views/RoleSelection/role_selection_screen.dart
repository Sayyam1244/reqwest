import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/AuthServices/auth_services.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';
import 'package:reqwest/SRC/Presentation/views/Dashboard/dashboard_screen.dart';
import 'package:reqwest/main.dart';

class RoleSelection extends StatefulWidget {
  const RoleSelection({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;
  @override
  State<RoleSelection> createState() => _RoleSelectionState();
}

class _RoleSelectionState extends State<RoleSelection> {
  bool? isStaff;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (mediaQuery.padding.top + 100).verticalSpace,
            RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Re', style: theme.textTheme.headlineMedium),
              TextSpan(
                  text: 'qwest',
                  style: theme.textTheme.headlineMedium?.copyWith(color: Theme.of(context).primaryColor)),
            ])),
            34.verticalSpace,
            Text(
              'What’s your need?',
              style: theme.textTheme.titleMedium,
            ),
            10.verticalSpace,
            Text(
              'Welcome, Wasim! Please select your role to proceed.',
              maxLines: 2,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
            50.verticalSpace,
            CommonButton(
              borderColor: (isStaff ?? false) ? theme.colorScheme.primary : null,
              backgroundColor: (isStaff ?? false)
                  ? theme.colorScheme.primary.withOpacity(0.4)
                  : theme.colorScheme.secondary,
              text: 'Staff',
              onTap: () {
                setState(() {
                  isStaff = true;
                });
              },
              textColor: theme.colorScheme.onSurface,
            ),
            20.verticalSpace,
            CommonButton(
              borderColor: (isStaff == false) ? theme.colorScheme.primary : null,
              backgroundColor: (isStaff == false)
                  ? theme.colorScheme.primary.withOpacity(0.4)
                  : theme.colorScheme.secondary,
              text: 'Customer',
              onTap: () {
                setState(() {
                  isStaff = false;
                });
              },
              textColor: theme.colorScheme.onSurface,
            ),
            const Spacer(),
            CommonButton(
              text: 'Next',
              onTap: () async {
                showLoading();
                if (isStaff == null) return;

                UserModel newUserModel = widget.userModel;
                newUserModel.role = isStaff! ? 'staff' : 'customer';
                final res = await AuthServices.instance.createUser(userModel: newUserModel);
                if (res is String) {
                  showToast(res);
                } else if (res is UserModel) {
                  AuthServices.instance.userModel = res;
                  isStaffFlow = AuthServices.instance.userModel!.role == 'staff';
                  context.to(const DashboardScreen());
                }
                dismiss();
              },
            ),
            24.verticalSpace,
          ],
        ),
      ),
    );
  }
}
