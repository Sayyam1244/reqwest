import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/task_service.dart';
import 'package:reqwest/SRC/Data/Resources/validators.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';
import 'package:reqwest/SRC/Presentation/views/OrderDetail/order_detail_screen.dart';

class ConfirmBookingScreen extends StatefulWidget {
  ConfirmBookingScreen({
    super.key,
    this.categoryModel,
  });
  CategoryModel? categoryModel;

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  // final ls = [
  //   'All',
  //   'Clogged Toilet',
  //   'Leaking Pipes',
  //   'Miscellaneous',
  //   'Toilet',
  //   'Pipes'
  // ];
  int selectedIndex = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: widget.categoryModel?.name ?? '',
        context: context,
        showUnderline: false,
        isTitleCentered: true,
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpace,
              // AppText(
              //   'Select Category',
              //   style: theme.textTheme.titleSmall,
              // ),
              // 16.verticalSpace,
              // Wrap(
              //   spacing: 10,
              //   runSpacing: 10,
              //   children: ls
              //       .mapIndexed(
              //         (i, e) => FilterChip(
              //           selected: selectedIndex == i,
              //           showCheckmark: false,
              //           label: AppText(
              //             e,
              //             style: theme.textTheme.bodyMedium,
              //           ),
              //           onSelected: (bool value) {
              //             setState(() {
              //               selectedIndex = i;
              //             });
              //           },
              //         ),
              //       )
              //       .toList(),
              // ),
              // 16.verticalSpace,
              AppTextField(
                labelText: 'Email Address',
                controller: emailController,
                validator: AppValidators.emailCheck,
              ),
              16.verticalSpace,
              AppTextField(
                labelText: 'Enter Phone No.',
                controller: phoneController,
                validator: AppValidators.phoneCheck,
              ),
              16.verticalSpace,
              AppTextField(
                labelText: 'Task Descriptions',
                controller: descController,
                validator: AppValidators.emptyCheck,
              ),
              36.verticalSpace,
              CommonButton(
                onTap: () async {
                  if (!formKey.currentState!.validate()) return;

                  showLoading();
                  final val = await TaskService.instance.createTask(TaskModel(
                    service: widget.categoryModel?.id,
                    email: emailController.text,
                    phone: phoneController.text,
                    description: descController.text,
                    status: 'pending',
                    createdDate: DateTime.now(),
                    requestedBy: FirebaseAuth.instance.currentUser?.uid,
                  ));
                  dismiss();
                  if (val is String) {
                    showToast(val);
                  } else {
                    showToast('Task Created Successfully');
                    context.pushReplacement(
                        OrderDetailScreen(taskModel: val, isFirstTime: true));
                  }
                },
                text: 'Confirm Booking',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
