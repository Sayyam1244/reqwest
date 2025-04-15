import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/web/employees/add_employee.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  State<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text('Employee', style: theme.textTheme.titleLarge),
            36.horizontalSpace,
            CommonButton(
              height: 40,
              width: 130,
              text: 'Add Employee',
              onTap: () {
                context.to(const AddEmployee());
              },
            ),
            const Spacer(),
            SizedBox(
              width: mediaQuery.size.width * 0.3,
              child: AppTextField(
                hintText: 'Search',
                onFieldSubmitted: (v) {
                  setState(() {
                    searchText = v;
                  });
                },
              ),
            ),
          ],
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(flex: 1, child: Text('No', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Name', style: theme.textTheme.bodySmall)),
            Expanded(flex: 3, child: Text('Email', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Service', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Action', style: theme.textTheme.bodySmall)),
          ],
        ),
        20.verticalSpace,
        const Divider(thickness: 1),
        10.verticalSpace,
        StreamBuilder(
          stream: UserServices.streamUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            final data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Center(child: Text('No Employee available'));
            }
            return Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  final item = data[index];
                  final name = "${item.firstName} ${item.lastName}";
                  if (searchText.isNotEmpty && !name.toLowerCase().contains(searchText.toLowerCase())) {
                    return const SizedBox.shrink();
                  }
                  return Row(
                    children: [
                      Expanded(flex: 1, child: Text('${index + 1}', style: theme.textTheme.bodyMedium)),
                      Expanded(flex: 3, child: Text(name, style: theme.textTheme.bodyMedium)),
                      Expanded(flex: 3, child: Text(item.email ?? '', style: theme.textTheme.bodyMedium)),
                      Expanded(
                          flex: 2,
                          child: Text(item.categoryModel?.name ?? '', style: theme.textTheme.bodyMedium)),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            context.to(AddEmployee(userModel: item));
                          },
                          child: Text(
                            'Edit',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.underline,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (_, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(thickness: 1),
                  );
                },
                itemCount: data.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
