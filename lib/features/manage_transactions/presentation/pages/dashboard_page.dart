import 'package:flutter/material.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/providers/transaction_management_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/ui/widgets/app_scaffold.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TransactionManagementProvider transactionManager =
        context.watch<TransactionManagementProvider>();

    return AppScaffold(
      withDrawer: true,
      title: 'Dashboard',
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'This Month you have spent',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              MoneySpentWidget(money: transactionManager.totalMonthSpending()),
              const SizedBox(height: 10),
              Text(
                'Your top three spending transactions',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              ...transactionManager.top3Transactions
                  .map(
                    (e) => TopCategoryWidget(
                      categoryName: e.category,
                      moneySpent: e.ammount,
                    ),
                  )
                  .toList(),
              // const TopCategoryWidget(
              //   categoryName: 'Gaming',
              //   moneySpent: '10',
              // ),
              // const SizedBox(height: 10),
              // const TopCategoryWidget(
              //   categoryName: 'Shopping',
              //   moneySpent: '20',
              // ),
              // const SizedBox(height: 10),
              // const TopCategoryWidget(
              //   categoryName: 'Landery',
              //   moneySpent: '30',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoneySpentWidget extends StatelessWidget {
  const MoneySpentWidget({super.key, required this.money});
  final double money;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${money.toStringAsFixed(2)}',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}

class TopCategoryWidget extends StatelessWidget {
  const TopCategoryWidget({super.key, this.categoryName, this.moneySpent});
  final categoryName;
  final moneySpent;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(categoryName),
        const SizedBox(height: 5),
        Text('\$$moneySpent'),
        const SizedBox(height: 10),
      ],
    );
  }
}
