import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/categories_service.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';
import 'package:reqwest/SRC/Data/Resources/validators.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_dropdown.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key, this.userModel});
  final UserModel? userModel;

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<CategoryModel> categories = [];
  String? selectedCatId;
  String? selectedCatVal;
  @override
  void initState() {
    getCategories();
    if (widget.userModel != null) {
      emailController.text = widget.userModel?.email ?? '';
      firstNameController.text = widget.userModel?.firstName ?? '';
      lastNameController.text = widget.userModel?.lastName ?? '';
      phoneNumberController.text = widget.userModel?.phoneNumber ?? "";
      selectedCatId = widget.userModel?.categoryId ?? '';
      log('${widget.userModel?.categoryId}');
    }

    super.initState();
  }

  getCategories() async {
    showLoading();
    await CategoriesService.instance.getCategories().then((value) {
      categories.addAll(value);
      if (widget.userModel != null) {
        selectedCatVal = categories.firstWhere((element) => element.id == selectedCatId).name;
      }
      setState(() {});
    }).whenComplete(() {
      return dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: categories.isEmpty
          ? const SizedBox.shrink()
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: mediaQuery.size.width * 0.5,
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.userModel == null ? "Add" : "Update"} Employee',
                          style: theme.textTheme.titleLarge),
                      30.verticalSpace,
                      AppTextField(
                        controller: firstNameController,
                        hintText: 'First Name',
                        validator: AppValidators.emptyCheck,
                      ),
                      20.verticalSpace,
                      AppTextField(
                        controller: lastNameController,
                        hintText: 'Last Name',
                        validator: AppValidators.emptyCheck,
                      ),
                      20.verticalSpace,
                      AppTextField(
                        controller: emailController,
                        hintText: 'Email',
                        validator: AppValidators.emailCheck,
                      ),
                      20.verticalSpace,
                      AppTextField(
                        controller: phoneNumberController,
                        hintText: 'Phone Number',
                        validator: AppValidators.emptyCheck,
                      ),
                      20.verticalSpace,
                      AppDropDownSimple(
                        items: categories.map((e) => e.name).toList(),
                        selectedValue: selectedCatVal,
                        hint: 'Select Category',
                        onChanged: (v) {
                          selectedCatVal = v;
                          selectedCatId = categories.firstWhere((element) => element.name == v).id!;
                        },
                      ),
                      20.verticalSpace,
                      CommonButton(
                        height: 40,
                        width: 130,
                        text: 'Confirm',
                        onTap: () async {
                          if (!formKey.currentState!.validate()) {
                            showToast('Please fill all fields');
                            return;
                          }
                          showLoading();
                          final data = UserModel(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            phoneNumber: phoneNumberController.text,
                            categoryId: selectedCatId,
                            role: 'staff',
                            docId: widget.userModel?.docId,
                          );
                          log(data.toMap().toString());
                          final val = await UserServices.createUser(data: data.toMap());

                          dismiss();
                          if (val is UserModel) {
                            showToast('Employee added successfully');
                            Navigator.pop(context);
                          } else {
                            showToast(val.toString());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
