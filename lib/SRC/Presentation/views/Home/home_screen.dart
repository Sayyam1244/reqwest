import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/AuthServices/auth_services.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/categories_service.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/task_service.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';
import 'package:reqwest/SRC/Presentation/views/ConfirmBooking/confirm_booking_screen.dart';
import 'package:reqwest/SRC/Presentation/views/Home/Components/banner_widget.dart';
import 'package:reqwest/SRC/Presentation/views/Home/Components/category_item_widget.dart';
import 'package:reqwest/SRC/Presentation/views/Home/Components/task_item_widget.dart';
import 'package:reqwest/SRC/Presentation/views/OrderDetail/order_detail_screen.dart';
import 'package:reqwest/SRC/Presentation/views/TaskDetail/task_detail_screen.dart';
import 'package:reqwest/gen/assets.gen.dart';
import 'package:reqwest/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: 'Welcome',
        context: context,
        leading: AssetImageWidget(
          color: theme.colorScheme.primary,
          url: Assets.images.chef.path,
          isCircle: true,
        ),
      ),
      body: ListView(
        children: [
          if (isStaffFlow) StaffFlow(theme: theme) else UserFlow(theme: theme),
        ],
      ),
    );
  }
}

class UserFlow extends StatefulWidget {
  const UserFlow({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<UserFlow> createState() => _UserFlowState();
}

class _UserFlowState extends State<UserFlow> {
  final categoryInstance = CategoriesService.instance;
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    showLoading();
    await Future.wait([
      categoryInstance.getCategories(),
    ]);
    dismiss();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // categoryInstance.addCategory(CategoryModel(
    //     name: 'Plumb - 2', description: 'adsfadsfa', image: 'adfadsf'));
    return Column(
      children: [
        12.verticalSpace,
        const BannerWidget(),
        10.verticalSpace,
        const Divider(thickness: 10),
        28.verticalSpace,
        if (categoryInstance.cachedCategories == null) const SizedBox(),
        if (categoryInstance.cachedCategories?.isEmpty ?? false)
          const Center(child: Text('No Categories Found')),
        if (categoryInstance.cachedCategories?.isNotEmpty ?? false)
          SizedBox(
            height: 80,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: categoryInstance.cachedCategories?.length ?? 0,
              itemBuilder: (context, index) => CategoryItemWidget(
                onTap: () {
                  context.to(ConfirmBookingScreen(
                    categoryModel: categoryInstance.cachedCategories![index],
                  ));
                },
                category: categoryInstance.cachedCategories![index],
              ),
              separatorBuilder: (BuildContext context, int index) {
                return 30.horizontalSpace;
              },
            ),
          ),
        28.verticalSpace,
        const Divider(thickness: 10),
        10.verticalSpace,
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: AppText(
            'My Tasks',
            style: widget.theme.textTheme.titleMedium,
          ),
        ),
        // 10.verticalSpace,
        StreamBuilder(
          stream: TaskService.instance
              .getTasksForCurrentUser(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error Fetching Tasks'));
            }
            final tasks = snapshot.data as List<TaskModel>;
            if (tasks.isEmpty) {
              return const Center(child: Text('No Tasks Found'));
            }

            return SizedBox(
              height: 220,
              child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                scrollDirection: Axis.horizontal,
                itemCount: tasks.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    context.to(OrderDetailScreen(taskModel: tasks[index]));
                  },
                  child: TaskItemWidget(
                    taskModel: tasks[index],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return 30.horizontalSpace;
                },
              ),
            );
          },
        ),
        // 28.verticalSpace,
        const Divider(thickness: 10),
      ],
    );
  }
}

class StaffFlow extends StatelessWidget {
  const StaffFlow({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: TaskService.instance.getTasksForCurrentUserStaff(
            FirebaseAuth.instance.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error Fetching Tasks'));
          }

          final tasks = snapshot.data as List<TaskModel>;
          final completedTasks = tasks
              .where((element) => element.status == 'completed')
              .toList()
              .length;
          final inProgressTasks = tasks
              .where((element) => element.status != 'completed')
              .toList()
              .length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(thickness: 20),
              28.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: AppText(
                  'Task Overview',
                  style: theme.textTheme.titleMedium,
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            'Completed',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          AppText(
                            '$completedTasks',
                            style: theme.textTheme.titleLarge,
                          )
                        ],
                      ),
                    )),
                    16.horizontalSpace,
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: theme.colorScheme.outline,
                          width: 0.5,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            'In Progress',
                            style: theme.textTheme.bodyLarge!.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          AppText(
                            '$inProgressTasks',
                            style: theme.textTheme.titleLarge,
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              28.verticalSpace,
              const Divider(thickness: 20),
              28.verticalSpace,
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: AppText(
                  'Assigned Task',
                  style: theme.textTheme.titleSmall,
                ),
              ),
              10.verticalSpace,
              ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    context.to(OrderDetailScreen(taskModel: tasks[index]));
                  },
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        tasks[index].categoryModel?.name[0] ?? '',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                  contentPadding: EdgeInsets.zero,
                  title: AppText(tasks[index].categoryModel?.name ?? ''),
                  subtitle: AppText(tasks[index].status ?? ''),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
                itemCount: tasks.length,
              )
            ],
          );
        });
  }
}
