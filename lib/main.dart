import 'package:compfest/core/theme/app_theme.dart';
import 'package:compfest/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:compfest/features/dashboard/presentation/widgets/dashboard_empty_view.dart';
import 'package:compfest/features/pages/dead_stock_detail_page.dart';
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
        '/dashboard': (context) => const DashboardPage(),
        '/dead-stock-detail': (context) => const DeadStockDetailPage(),
      },
    );
  }
}
