// import 'package:flutter/material.dart';
// import 'package:flutter_quick_router/Routers/quick_routes.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nest/SRC/Presentation/Common/app_text.dart';

// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//   final String title;
//   final bool? bckShow;
//   final Widget? titleWidget;

//   final VoidCallback? onBackTap;
//   final List<Widget>? actions;
//   final PreferredSizeWidget? bottom;
//   final double? height;

//   const CustomAppBar(
//       {key,
//       required this.title,
//       this.onBackTap,
//       this.bottom,
//       this.bckShow,
//       this.titleWidget,
//       this.height,
//       this.actions})
//       : preferredSize = const Size.fromHeight(65),
//         super(key: key);
//   @override
//   final Size preferredSize;

//   @override
//   CustomAppBarState createState() => CustomAppBarState();
// }

// class CustomAppBarState extends State<CustomAppBar> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       scrolledUnderElevation: 0,
//       toolbarHeight: widget.height,
//       automaticallyImplyLeading: false,
//       centerTitle: true,
//       leading: widget.bckShow != null
//           ? BackButton(
//               onPressed: widget.onBackTap ?? () => context.back(),
//             )
//           : null,
//       bottom: widget.bottom,
//       title: widget.titleWidget ??
//           Padding(
//             padding: EdgeInsets.only(top: 5.r),
//             child: AppText(
//               widget.title,
//               style: Theme.of(context)
//                   .textTheme
//                   .titleMedium
//                   ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
//             ),
//           ),
//       actions: widget.actions,
//     );
//   }
// }
