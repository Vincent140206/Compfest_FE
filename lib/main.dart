import 'package:compfest/core/theme/app_theme.dart';
import 'package:compfest/features/auth/presentation/pages/login_page.dart';
import 'package:compfest/features/auth/presentation/pages/register_page.dart';
import 'package:compfest/features/auth/presentation/pages/verify_otp_page.dart';
import 'package:compfest/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:compfest/features/dashboard/presentation/widgets/dashboard_empty_view.dart';
import 'package:compfest/features/data_upload/presentation/pages/data_upload_page.dart';
import 'package:compfest/features/dead_stock/presentation/pages/dead_stock_detail_page.dart';
import 'package:compfest/features/forecast/presentation/pages/forecast_page.dart';
import 'package:compfest/features/main_navigation/presentation/pages/main_navigation_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Invise',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/verify', page: () => VerifyOtpPage()),
        GetPage(name: '/main', page: () => MainNavigationPage()),
        GetPage(name: '/upload', page: () => UploadDataPage()),
        GetPage(name: '/dashboard', page: () => const DashboardPage()),
        GetPage(name: '/dashboard-empty', page: () => const DashboardEmptyView()),
        GetPage(name: '/dead-stock-detail', page: () => const DeadStockDetailPage()),
        GetPage(name: '/forecast', page: () => const ForecastPage()),
      ],
    );
  }
}
