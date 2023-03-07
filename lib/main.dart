import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/pages/all_transactions_page.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/pages/dashboard_page.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/pages/transaction_addition_page.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/providers/transaction_management_provider.dart';
import 'package:spending_tracker/sl.dart';

import 'core/constants.dart';
import 'core/ui/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Spending Tracker';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<TransactionManagementProvider>(),
      child: MaterialApp(
        title: _title,
        initialRoute: Routes.Home,
        routes: {
          Routes.Home: (context) => DashboardPage(),
          Routes.Transactions: (context) => const AllTransactionsPage(),
          Routes.Create_transaction: (context) => TransactionAdditionPage(),
        },
        theme: darkTheme,
      ),
    );
  }
}
