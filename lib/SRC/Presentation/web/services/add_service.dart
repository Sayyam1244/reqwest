import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker_web/image_picker_web.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/categories_service.dart';
import 'package:reqwest/SRC/Data/Resources/validators.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_dropdown.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';

class AddService extends StatefulWidget {
  const AddService({super.key, this.category});
  final CategoryModel? category;

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final serviceNameController = TextEditingController();
  final serviceDescriptionController = TextEditingController();
  String status = 'Active';
  Uint8List? image;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.category != null) {
      serviceNameController.text = widget.category!.name;
      serviceDescriptionController.text = widget.category!.description;
      status = widget.category!.status!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          width: mediaQuery.size.width * 0.5,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Service', style: theme.textTheme.titleLarge),
                30.verticalSpace,
                AppTextField(
                  hintText: 'Service Name',
                  controller: serviceNameController,
                  validator: AppValidators.emptyCheck,
                ),
                20.verticalSpace,
                AppTextField(
                  hintText: 'Service Description',
                  controller: serviceDescriptionController,
                  validator: AppValidators.emptyCheck,
                ),
                30.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(right: mediaQuery.size.width * 0.2),
                  child: AppDropDownSimple(
                      hint: 'Status',
                      items: const ['Active', 'Block'],
                      selectedValue: status,
                      onChanged: (v) {
                        status = v;
                      }),
                ),
                30.verticalSpace,
                if (widget.category == null)
                  InkWell(
                    onTap: () async {
                      // Pick an image
                      // Uint8List? pickedFile = await ImagePickerWeb.getImageAsBytes();
                      // if (pickedFile != null) {
                      //   setState(() {
                      //     image = pickedFile;
                      //   });
                      // }
                    },
                    child: Container(
                      height: 200.h,
                      width: 200.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                      child: image == null
                          ? const Center(child: Text('Select Image'))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(image!, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                30.verticalSpace,
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
                    final val = await CategoriesService.instance.addCategory(
                      CategoryModel(
                        id: widget.category?.id ?? '',
                        name: serviceNameController.text,
                        description: serviceDescriptionController.text,
                        status: status,
                      ),
                      image,
                    );
                    dismiss();
                    if (val is bool) {
                      showToast('Service added successfully');
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
