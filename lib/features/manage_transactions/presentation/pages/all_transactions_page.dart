import 'package:flutter/material.dart';

import '../../domain/entities/transaction.dart';

class AllTransactionsPage extends StatefulWidget {
  const AllTransactionsPage({super.key});

  @override
  State<AllTransactionsPage> createState() => _AllTransactionsPageState();
}

class _AllTransactionsPageState extends State<AllTransactionsPage> {
// TODO:
  List<bool> isExpandedList = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
// TODO:
    var transactions_1 = List.generate(
        5,
        (index) => Transaction(
              category: 'category $index',
              summary: 'summart $index',
              ammount: index.toDouble(),
              date: DateTime.now(),
            ));
    Map<String, List<Transaction>> categoryTransactionsMap = {
      'category-1': transactions_1,
      'category-2': transactions_1,
      'category-3': transactions_1,
    };

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          elevation: 0,
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              isExpandedList[panelIndex] = !isExpandedList[panelIndex];
            });
          },
          children: getExpansionPanelsFrom(categoryTransactionsMap),
        ),
      ),
    );
  }

  List<ExpansionPanel> getExpansionPanelsFrom(
      Map<String, List<Transaction>> catToTrans) {
    final keys = catToTrans.keys.toList();
    List<ExpansionPanel> expansionPanels = [];

    for (var i = 0; i < keys.length; i++) {
      var key = keys[i];
      var currentTransactions = catToTrans[key]!;
      var expansionPanel = ExpansionPanel(
        // backgroundColor: const Color.fromARGB(255, 7, 41, 70),
        backgroundColor: Theme.of(context).primaryColor,
        headerBuilder: (context, isExpanded) {
          // category
          return ListTile(
            title: Text(
              key,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
        },
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          children: createExpansionPanelsBody(currentTransactions),
        ),
        canTapOnHeader: true,
        isExpanded: isExpandedList[i],
      );

      expansionPanels.add(expansionPanel);
    }
    return expansionPanels;
  }

  List<ListTile> createExpansionPanelsBody(
      // here key is index
      List<Transaction> singleCategoryTransactions) {
    return singleCategoryTransactions
        .asMap()
        .entries
        .map(
          (e) => ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                e.value.summary,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
            subtitle: Text(
              e.value.date.toString(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(.4),
              ),
            ),
            trailing: Text(
              '${e.value.ammount.toString()} \$',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary.withOpacity(.8),
              ),
            ),
          ),
        )
        .toList();
  }
}
