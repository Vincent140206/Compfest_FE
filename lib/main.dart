import 'package:compfest/core/theme/app_theme.dart';
import 'package:compfest/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:compfest/features/dashboard/presentation/widgets/dashboard_empty_view.dart';
import 'package:compfest/features/data_upload/presentation/pages/data_upload_page.dart';
import 'package:compfest/features/dead_stock/presentation/pages/dead_stock_detail_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const DashboardEmptyView(),
      routes: {
        '/upload': (context) => const UploadDataPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/dashboard-empty': (context) => const DashboardEmptyView(),
        '/dead-stock-detail': (context) => const DeadStockDetailPage(),
      },
    );
  }
}
