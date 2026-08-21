import 'package:compfest/core/theme/app_theme.dart';
import 'package:compfest/features/dashboard/presentation/dashboard_page.dart';
import 'package:compfest/features/dashboard/presentation/dead_stock_detail_page.dart';
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
      home: const DashboardPage(),
      routes: {
        '/dashboard': (context) => const DashboardPage(),
        '/dead-stock-detail': (context) => const DeadStockDetailPage(),
      },
    );
  }
}
