// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_quick_router/Routers/quick_routes.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:reqwest/SRC/Application/Utils/Extensions/extensions.dart';
// import 'package:reqwest/SRC/Data/Resources/Colors/light_colors_palate.dart';
// import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
// import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
// import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
// import 'package:reqwest/SRC/Presentation/Common/common_dialogue.dart';
// import 'package:reqwest/SRC/Presentation/Common/shimmer.dart';
// import 'package:reqwest/SRC/Presentation/Views/Dashboard/cubit/user_cubit.dart';
// import 'package:reqwest/SRC/Presentation/Views/Dashboard/state/user_state.dart';
// import 'package:reqwest/gen/assets.gen.dart';

// class Topbar extends StatelessWidget {
//   const Topbar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
//       if (state is UserErrorState) {
//         CommonDialogs.showErrorDialogue(
//           context: context,
//           title: "Error",
//           description: state.error,
//         );
//       }
//     }, builder: (context, state) {
//       final userCubit =
//           BlocProvider.of<UserCubit>(context, listen: false).userModel;
//       return Row(
//         children: [
//           if (state is UserLoadedState)
//             if (userCubit?.profilePhoto == null)
//               Container(
//                 height: 40,
//                 width: 40,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: AppText(
//                     userCubit?.fullName.characters.first.toUpperCase() ?? '',
//                     style: theme.textTheme.titleMedium!.copyWith(
//                       color: theme.colorScheme.background,
//                     ),
//                   ),
//                 ),
//               )
//             else
//               AssetImageWidget(
//                 url: userCubit?.profilePhoto ?? '',
//                 isCircle: true,
//                 radius: 20,
//               )
//           else
//             CommonShimmer(
//               width: 40,
//               height: 40,
//               shape: BoxShape.circle,
//             ),
//           10.horizontalSpace,
//           if (state is UserLoadedState)
//             AppText(
//               userCubit?.fullName ?? '',
//               style: theme.textTheme.bodyLarge!.copyWith(fontSize: 14),
//             )
//           else
//             CommonShimmer(
//               width: 100,
//               height: 20,
//             ),
//           const Spacer(),
//           DynamicAppIconHandler.buildIcon(
//             context: context,
//             icon: Icons.add,
//             iconColor: LightColorsPalate.lightContentColor,
//           ).onTapped(onTap: () {
//             // context.to(const AddPostScreen());
//           }),
//           20.horizontalSpace,
//           Container(
//             height: 40,
//             width: 40,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: theme.colorScheme.outline,
//             ),
//             child: DynamicAppIconHandler.buildIcon(
//               context: context,
//               icon: Icons.notifications,
//               iconColor: theme.colorScheme.onBackground,
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }
