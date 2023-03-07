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
// TODO:
  List<bool> isExpandedList = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    final TransactionManagementProvider transactionManager =
        context.watch<TransactionManagementProvider>();

    Map<String, List<Transaction>> categoryTransactionsMap =
        transactionManager.transactions;

    return AppScaffold(
      withDrawer: true,
      button: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(
          context,
          Routes.Create_transaction,
        ),
        child: const Icon(Icons.add),
      ),
      title: 'Transactions',
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
