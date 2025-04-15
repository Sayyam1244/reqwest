import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reqwest/SRC/Application/Services/AuthServices/auth_services.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/task_service.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/SRC/Presentation/views/Dashboard/Controller/dashboard_controller.dart';
import 'package:reqwest/SRC/Presentation/views/OrderDetail/order_detail_screen.dart';
import 'package:reqwest/SRC/Presentation/views/Signin/signin_screen.dart';
import 'package:reqwest/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: 'Profile',
        context: context,
        isTitleCentered: true,
        showUnderline: false,
        actions: [
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              context.to(const SigninScreen());
            },
            child: AppText(
              'Logout',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          "${AuthServices.instance.userModel?.firstName ?? ''} ${AuthServices.instance.userModel?.lastName ?? ''}",
                          style: theme.textTheme.titleSmall,
                        ),
                        6.verticalSpace,
                        AppText(
                          AuthServices.instance.userModel?.email ?? '',
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        )
                      ],
                    ),
                  ),
                  // AppText('Edit', style: theme.textTheme.bodyMedium)
                ],
              ),
            ),
            32.verticalSpace,
            ProfileTile(
              title: 'Orders History',
              icon: Icons.bookmark_outline_outlined,
              onTap: () {
                context.to(const OrderHistory());
              },
            ),
            32.verticalSpace,
            ProfileTile(
              title: 'Privacy Policy',
              icon: Icons.privacy_tip_outlined,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
        appBar: customAppbar(
          title: 'Order History',
          context: context,
          isTitleCentered: true,
          showUnderline: false,
        ),
        body: StreamBuilder(
            stream: isStaffFlow
                ? TaskService.instance.getTasksForCurrentUserStaff(
                    FirebaseAuth.instance.currentUser!.uid)
                : TaskService.instance.getTasksForCurrentUser(
                    FirebaseAuth.instance.currentUser!.uid),
            builder: (BuildContext context,
                AsyncSnapshot<List<TaskModel>> snapshot) {
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
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  12.verticalSpace,
                  ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = snapshot.data![index];
                        return ListTile(
                          onTap: () {
                            context.to(OrderDetailScreen(
                              isFirstTime: false,
                              taskModel: item,
                            ));
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            height: 40.w,
                            width: 40.w,
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle),
                            child: Center(
                              child: AppText(
                                item.docId?.characters.firstOrNull ?? '',
                                style: theme.textTheme.titleSmall!.copyWith(
                                  color: theme.colorScheme.surface,
                                ),
                              ),
                            ),
                          ),
                          title: AppText(
                            '${item.docId}',
                            style: theme.textTheme.titleSmall!
                                .copyWith(fontSize: 14),
                          ),
                          subtitle: AppText(
                            maxLine: 2,
                            item.description ?? '',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                          trailing: AppText(
                            DateFormat('MMMM dd').format(item.createdDate!),
                            style: theme.textTheme.bodySmall,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data?.length ?? 0),

                  //
                ],
              );
            }));
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.outline,
              ),
              child: DynamicAppIconHandler.buildIcon(
                context: context,
                icon: icon,
                iconColor: theme.colorScheme.onSurface,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: AppText(
                title,
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
              ),
            ),
            6.verticalSpace,
            DynamicAppIconHandler.buildIcon(
              context: context,
              icon: Icons.arrow_forward_ios_rounded,
              iconHeight: 16,
            ),
          ],
        ),
      ),
    );
  }
}
