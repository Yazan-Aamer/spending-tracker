import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spending_tracker/core/ui/widgets/app_scaffold.dart';
import 'package:spending_tracker/features/manage_transactions/presentation/providers/transaction_management_provider.dart';

import '../../../../core/constants.dart';
import '../../domain/entities/transaction.dart';

class AllTransactionsPage extends StatefulWidget {
  const AllTransactionsPage({super.key});

  @override
  State<AllTransactionsPage> createState() => _AllTransactionsPageState();
}

class _AllTransactionsPageState extends State<AllTransactionsPage> {
  // storing wich panel is open
  List<bool> isExpandedList = List.generate(1000, (index) => false);

  @override
  Widget build(BuildContext context) {
    // Get the instance of the TransactionManagementProvider using context
    final TransactionManagementProvider transactionManager =
        context.watch<TransactionManagementProvider>();

    // Get the Map of transactions grouped by category
    Map<String, List<Transaction>> categoryTransactionsMap =
        transactionManager.transactions;
    final bool hasTransactions = transactionManager.transactions.length > 0;

    return AppScaffold(
      withDrawer: true,
      // Define a floating action button for adding new transactions
      button: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.Create_transaction,
        ),
        child: const Icon(Icons.add),
      ),
      title: 'Transactions',
      body: !hasTransactions
          ? const Center(
              child: Text('No Transactions'),
            )
          : SingleChildScrollView(
              child: ExpansionPanelList(
                elevation: 0,
                // Define the expansion callback function for updating the list of boolean values
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    isExpandedList[panelIndex] = !isExpandedList[panelIndex];
                  });
                },
                // Generate expansion panels based on the categoryTransactionsMap
                children: getExpansionPanelsFrom(categoryTransactionsMap),
              ),
            ),
    );
  }

  // Define a function to create ExpansionPanels from the categoryTransactionsMap
  List<ExpansionPanel> getExpansionPanelsFrom(
      Map<String, List<Transaction>> catToTrans) {
    // Get the list of keys in the map
    final keys = catToTrans.keys.toList();
    List<ExpansionPanel> expansionPanels = [];

    // Loop through each key in the map and create an ExpansionPanel for each category
    for (var i = 0; i < keys.length; i++) {
      var key = keys[i];
      var currentTransactions = catToTrans[key]!;
      var expansionPanel = ExpansionPanel(
        // Set the background color for the expansion panel header
        backgroundColor: Theme.of(context).primaryColor,
        headerBuilder: (context, isExpanded) {
          // Create a ListTile for the category
          return ListTile(
            title: Text(
              key,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
        },
        // Create the body of the ExpansionPanel with a Column of ListTiles
        body: Column(
          children: createExpansionPanelsBody(currentTransactions),
        ),
        canTapOnHeader: true,
        // Get the value of the boolean at the current index
        isExpanded: isExpandedList[i],
      );

      expansionPanels.add(expansionPanel);
    }
    return expansionPanels;
  }

  // Define a function to create ListTiles for each transaction in a single category
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
