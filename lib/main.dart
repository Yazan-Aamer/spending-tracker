import 'package:flutter/material.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/pages/all_transactions_page.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/pages/dashboard_page.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/pages/transaction_addition_page.dart';

import 'core/ui/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Spending Tracker';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: lightTheme,
      home: TransactionAdditionPage(),
    );
  }
}
