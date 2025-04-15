import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/task_service.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/web/orders/edit_order.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final List<String> filterOptions = [
    'all',
    'pending',
    'active',
    'completed',
  ];
  String activeFilter = 'all';
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text('Orders', style: theme.textTheme.titleLarge),
            36.horizontalSpace,
            const Spacer(),
            SizedBox(
              width: mediaQuery.size.width * 0.3,
              child: AppTextField(
                onFieldSubmitted: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
                hintText: 'Search Description',
              ),
            ),
          ],
        ),
        20.verticalSpace,
        Row(
          children: [
            ...filterOptions.map((e) => InkWell(
                  onTap: () {
                    setState(() {
                      activeFilter = e;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: activeFilter == e ? theme.colorScheme.primary : theme.colorScheme.surface,
                    ),
                    child: Text(
                      '${e[0].toUpperCase()}${e.substring(1)}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                )),
          ],
        ),
        20.verticalSpace,
        Row(
          children: [
            Expanded(flex: 1, child: Text('No', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Service requested', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Description', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Assign to', style: theme.textTheme.bodySmall)),
            Expanded(flex: 2, child: Text('Status', style: theme.textTheme.bodySmall)),
            Expanded(flex: 1, child: Text('Action', style: theme.textTheme.bodySmall)),
          ],
        ),
        20.verticalSpace,
        const Divider(thickness: 1),
        10.verticalSpace,
        StreamBuilder(
          stream: TaskService.instance.getAllTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.error ?? 'Error occurred'}"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LinearProgressIndicator();
            }
            final unSortedData = snapshot.data;
            final data = unSortedData;
            if (activeFilter != 'all') {
              data?.removeWhere((element) => element.status != activeFilter);
            }

            if (data == null || data.isEmpty) {
              return const Center(child: Text('No Tasks available'));
            }
            if (searchText.isNotEmpty) {
              data.removeWhere(
                  (element) => element.description?.toLowerCase().contains(searchText.toLowerCase()) != true);
            }
            return Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) {
                  final item = data[index];
                  return Row(
                    children: [
                      Expanded(flex: 1, child: Text('${index + 1}')),
                      Expanded(flex: 2, child: Text(item.categoryModel?.name ?? 'nil')),
                      Expanded(flex: 2, child: Text(item.description ?? 'nil')),
                      Expanded(flex: 2, child: Text(item.assignToUser?.firstName ?? 'None')),
                      Expanded(
                          flex: 2,
                          child: Text((item.status ?? 'pending')
                              .replaceFirst(item.status?[0] ?? 'p', (item.status?[0] ?? 'p').toUpperCase()))),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            context.to(EditOrder(task: item));
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
