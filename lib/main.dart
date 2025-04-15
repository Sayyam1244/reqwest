import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:reqwest/SRC/Application/Utils/app_providers.dart';
import 'package:reqwest/SRC/Data/Resources/Theme/app_theme.dart';
import 'package:reqwest/SRC/Presentation/Common/loading.dart';
import 'package:reqwest/SRC/Presentation/views/Splash/splash_screen.dart';
import 'package:reqwest/SRC/Presentation/web/dashboard/admin_dashboard_screen.dart';
import 'package:reqwest/SRC/Presentation/web/employees/add_employee.dart';
import 'package:reqwest/SRC/Presentation/web/employees/employees.dart';
import 'package:reqwest/SRC/Presentation/web/orders/orders_screen.dart';
import 'package:reqwest/SRC/Presentation/web/services/add_service.dart';
import 'package:reqwest/SRC/Presentation/web/stats/stats.dart';
import 'package:reqwest/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> registerBackgroundMessage(RemoteMessage message) async {}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(const MyApp());
  // runApp(MultiBlocProvider(providers: appProviders, child: const MyApp()));
}

bool isStaffFlow = false;
bool isWeb = false;
Size getSize(context) {
  if (MediaQuery.sizeOf(context).width > 1400) {
    isWeb = true;
    return const Size(1440, 1098);
  } else {
    return const Size(375, 812);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log(MediaQuery.sizeOf(context).toString());
    return ScreenUtilInit(
      designSize: getSize(context),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: child,
          theme: CustomAppTheme.instance.lightTheme(),
          builder: FlutterSmartDialog.init(
            loadingBuilder: (string) => const Loading(),
            builder: (context, child) {
              return child ?? const SizedBox();
            },
          ),
        );
      },
      child: const SplashScreen(),
      // child: const StatsScreen(),
    );
  }
}
