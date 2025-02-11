import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/SRC/Presentation/views/ConfirmBooking/confirm_booking_screen.dart';
import 'package:reqwest/SRC/Presentation/views/Home/Components/banner_widget.dart';
import 'package:reqwest/SRC/Presentation/views/Home/Components/category_item_widget.dart';
import 'package:reqwest/SRC/Presentation/views/Home/Components/task_item_widget.dart';
import 'package:reqwest/gen/assets.gen.dart';

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
          12.verticalSpace,
          const BannerWidget(),
          10.verticalSpace,
          const Divider(thickness: 10),
          28.verticalSpace,
          SizedBox(
            height: 80,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) => CategoryItemWidget(
                onTap: () {
                  context.to(const ConfirmBookingScreen());
                },
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
              style: theme.textTheme.titleMedium,
            ),
          ),
          // 10.verticalSpace,
          SizedBox(
            height: 220,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) => const TaskItemWidget(),
              separatorBuilder: (BuildContext context, int index) {
                return 30.horizontalSpace;
              },
            ),
          ),
          // 28.verticalSpace,
          const Divider(thickness: 10),
        ],
      ),
    );
  }
}
