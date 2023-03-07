import 'package:flutter/material.dart';

class TransactionAdditionPage extends StatelessWidget {
  TransactionAdditionPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final categoryTextController = TextEditingController();
    final summaryController = TextEditingController();
    final dateController = TextEditingController();
    final transactionAmmount = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Transactions'),
        actions: [
          TextButton.icon(
            label: const Text('Next',
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // do something
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