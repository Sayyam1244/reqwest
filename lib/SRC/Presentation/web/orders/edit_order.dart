import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/task_service.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';
import 'package:reqwest/SRC/Data/Resources/validators.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_dropdown.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';

class EditOrder extends StatefulWidget {
  const EditOrder({super.key, this.task});
  final TaskModel? task;

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  final description = TextEditingController();
  UserModel assignToUser = UserModel();
  String status = 'active';
  final List<String> filterOptions = [
    'pending',
    'active',
    'completed',
  ];
  final List<UserModel> users = [];
  final FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    initUsers();
    description.text = widget.task!.description ?? '';
    assignToUser = widget.task!.assignToUser ?? UserModel();
    status = widget.task!.status ?? 'active';

    super.initState();
  }

  void initUsers() async {
    showLoading();
    final data = await UserServices.getAllUsers();
    if (data is List<UserModel>) {
      setState(() {
        users.addAll(data);
      });
    }
    dismiss();
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
                Text('Edit Task', style: theme.textTheme.titleLarge),
                30.verticalSpace,
                AppTextField(
                  hintText: 'Description',
                  controller: description,
                  validator: AppValidators.emptyCheck,
                ),
                30.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(right: mediaQuery.size.width * 0.2),
                  child: AppDropDownSimple(
                      hint: 'Status',
                      items: filterOptions,
                      selectedValue: status,
                      onChanged: (v) {
                        status = v;
                      }),
                ),
                30.verticalSpace,
                Padding(
                  padding: EdgeInsets.only(right: mediaQuery.size.width * 0.2),
                  child: TypeAheadField<UserModel>(
                    builder: (context, controller, focusNode) => AppTextField(
                      hintText: 'Assign to',
                      focusNode: focusNode,
                      controller: controller,
                      validator: (v) => v!.isEmpty ? 'Please select a user' : null,
                    ),
                    focusNode: focusNode,
                    controller: TextEditingController(
                        text: "${assignToUser.firstName ?? ''} ${assignToUser.lastName ?? ''}"),
                    itemBuilder: (_, user) {
                      final name = "${user.firstName} ${user.lastName}";
                      return ListTile(
                        onTap: () {
                          assignToUser = user;
                          focusNode.unfocus();
                          setState(() {});
                        },
                        title: Text(name),
                      );
                    },
                    onSelected: (UserModel v) {
                      focusNode.unfocus();
                    },
                    suggestionsCallback: (pattern) async {
                      if (pattern.isEmpty) {
                        return [];
                      }
                      return users.where((user) {
                        final name = "${user.firstName} ${user.lastName}";
                        return name.toLowerCase().contains(pattern.toLowerCase());
                      }).toList();
                    },
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
                    final val = await TaskService.instance.updateTask(
                      widget.task!.copyWith(
                        description: description.text,
                        status: status,
                        assignTo: assignToUser.docId,
                      ),
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
