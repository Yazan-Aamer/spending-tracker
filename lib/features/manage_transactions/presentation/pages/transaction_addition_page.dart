import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/features/manage_transactions/domain/entities/transaction.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/providers/transaction_management_provider.dart';

class TransactionAdditionPage extends StatelessWidget {
  TransactionAdditionPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final categoryTextController = TextEditingController();
  final summaryController = TextEditingController();
  final dateController = TextEditingController();
  final transactionAmmount = TextEditingController();

  void clearText() {
    categoryTextController.clear();
    summaryController.clear();
    dateController.clear();
    transactionAmmount.clear();
  }

  @override
  Widget build(BuildContext context) {
    final transactionManager = context.watch<TransactionManagementProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Transactions'),
        actions: [
          TextButton.icon(
            label: Text('Next',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // do something
                final transaction = Transaction(
                  category: categoryTextController.text,
                  summary: summaryController.text,
                  ammount: double.parse(transactionAmmount.text),
                  date: DateTime.now(),
                );
                transactionManager.createTransaction(transaction);
                clearText();
              }
            },
            icon: const Icon(Icons.check, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: categoryTextController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Category',
                labelStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: summaryController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Summary',
                labelStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Date',
                labelStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: transactionAmmount,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Transaction ammount',
                labelStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}


// summary
// date/
// transaction ammount