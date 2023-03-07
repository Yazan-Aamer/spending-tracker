import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/core/ui/widgets/app_scaffold.dart';
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

    return AppScaffold(
      withDrawer: false,
      title: 'Your Transactions',
      actions: [
        TextButton.icon(
          label: Text('Next',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              )),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // do somethinj
              final transaction = Transaction(
                category: categoryTextController.text,
                summary: summaryController.text,
                ammount: double.parse(transactionAmmount.text),
                date: DateTime.parse(dateController.text),
              );
              transactionManager.createTransaction(transaction);
              clearText();
            }
          },
          icon: Icon(
            Icons.check,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: categoryTextController,
              validator: (value) {
                if (value == '') {
                  return 'This field is required';
                }
              },
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
            DateTimePicker(
              type: DateTimePickerType.date,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
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
              validator: (value) {
                if (value == '') {
                  return 'This is also required';
                } else {
                  final parsedValue = double.tryParse(value!);
                  if (parsedValue == null) {
                    return 'Please enter something valid -_-';
                  }
                }
              },
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: 'Transaction amount',
                labelStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
