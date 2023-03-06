import 'package:flutter/material.dart';

class CategoryAdditionPage extends StatelessWidget {
  CategoryAdditionPage({super.key});
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: categoryTextController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Category',
              ),
            ),
            TextFormField(
              controller: summaryController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Summary',
              ),
            ),
            TextFormField(
              controller: dateController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Date',
              ),
            ),
            TextFormField(
              controller: transactionAmmount,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Transaction ammount',
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