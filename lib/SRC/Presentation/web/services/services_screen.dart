import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/categories_service.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/web/services/add_service.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text('Services', style: theme.textTheme.titleLarge),
            36.horizontalSpace,
            CommonButton(
              height: 40,
              width: 130,
              text: 'Add Service',
              onTap: () {
                context.to(const AddService());
                // Add your action here
              },
            ),
            const Spacer(),
            SizedBox(
              width: mediaQuery.size.width * 0.3,
              child: const AppTextField(
                hintText: 'Search Service',
              ),
            ),
          ],
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(flex: 2, child: Text('No', style: theme.textTheme.bodySmall)),
            Expanded(flex: 3, child: Text('Name', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Status', style: theme.textTheme.bodySmall)),
            Expanded(flex: 1, child: Text('Action', style: theme.textTheme.bodySmall)),
          ],
        ),
        20.verticalSpace,
        const Divider(thickness: 1),
        10.verticalSpace,
        StreamBuilder(
          stream: CategoriesService.instance.streamCategories(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }
            final data = snapshot.data;
            if (data == null || data.isEmpty) {
              return const Center(child: Text('No services available'));
            }
            return Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  final item = data[index];
                  return Row(
                    children: [
                      Expanded(flex: 2, child: Text('${index + 1}', style: theme.textTheme.bodyMedium)),
                      Expanded(flex: 3, child: Text(item.name, style: theme.textTheme.bodyMedium)),
                      Expanded(
                          flex: 2, child: Text(item.status ?? 'Active', style: theme.textTheme.bodyMedium)),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            context.to(AddService(category: item));
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
