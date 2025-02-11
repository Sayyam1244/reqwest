import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/common_chip_list_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:collection/collection.dart';
import 'package:reqwest/SRC/Presentation/views/OrderDetail/order_detail_screen.dart';

class ConfirmBookingScreen extends StatefulWidget {
  const ConfirmBookingScreen({super.key});

  @override
  State<ConfirmBookingScreen> createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  final ls = [
    'All',
    'Clogged Toilet',
    'Leaking Pipes',
    'Miscellaneous',
    'Toilet',
    'Pipes'
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: 'Plumbing',
        context: context,
        showUnderline: false,
        isTitleCentered: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpace,
            AppText(
              'Select Category',
              style: theme.textTheme.titleSmall,
            ),
            16.verticalSpace,
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: ls
                  .mapIndexed(
                    (i, e) => FilterChip(
                      selected: selectedIndex == i,
                      showCheckmark: false,
                      label: AppText(
                        e,
                        style: theme.textTheme.bodyMedium,
                      ),
                      onSelected: (bool value) {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            16.verticalSpace,
            const AppTextField(
              labelText: 'Email Address',
            ),
            16.verticalSpace,
            const AppTextField(
              labelText: 'Enter Phone No.',
            ),
            16.verticalSpace,
            const AppTextField(
              labelText: 'Task Descriptions',
            ),
            36.verticalSpace,
            CommonButton(
              onTap: () {
                context.to(const OrderDetailScreen());
              },
              text: 'Confirm Booking',
            ),
          ],
        ),
      ),
    );
  }
}
