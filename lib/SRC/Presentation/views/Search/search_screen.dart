import 'package:flutter/material.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/categories_service.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/views/ConfirmBooking/confirm_booking_screen.dart';
import 'package:reqwest/gen/assets.gen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final categoryInstance = CategoriesService.instance;
  List<CategoryModel> categories = [];
  String search = '';
  @override
  void initState() {
    categories = categoryInstance.cachedCategories ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (mediaQuery.padding.top + 30).verticalSpace,
            AppText(
              'Search',
              style: theme.textTheme.titleMedium,
            ),
            16.verticalSpace,
            AppTextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              hintText: 'Search for a service',
              prefixIcon: DynamicAppIconHandler.buildIcon(
                context: context,
                svg: Assets.icons.search,
                iconColor: theme.colorScheme.onSurface,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  if (search.isNotEmpty &&
                      !categories[index]
                          .name
                          .toLowerCase()
                          .contains(search.toLowerCase())) {
                    return const SizedBox();
                  }
                  return InkWell(
                    onTap: () {
                      context.to(ConfirmBookingScreen(
                        categoryModel:
                            categoryInstance.cachedCategories![index],
                      ));
                    },
                    child: Text(
                      categories[index].name,
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return 12.verticalSpace;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
