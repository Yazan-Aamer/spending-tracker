import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:spending_tracker/features/manage_transactions/domain/repos/transaction_repo.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/transaction_model.dart';
import '../../domain/entities/transaction.dart';

class TransactionManagementProvider extends ChangeNotifier {
  final TransactionRepo repository;

  // state variables
  double _totalMonthSpending = 0; // Total spending for the current month
  double get totalMonthSpending => _totalMonthSpending;

  Map<String, List<Transaction>> _transactions =
      {}; // All transactions categorized by category
  Map<String, List<Transaction>> get transactions => _transactions;

  List<Transaction> _top3Transactions = []; // Top three transactions by amount
  List<Transaction> get top3Transactions => _top3Transactions;

  bool _loading = false; // Whether the provider is currently loading data
  bool get loading => _loading;

  String _error = ''; // The error message to display to the user
  String get error => _error;

  TransactionManagementProvider({required this.repository});

  // Get all transactions from the repository
  Future<void> getAllTransactions() async {
    _loading = true;

    // Call the repository method to get all transactions
    final Either<Failure, List<Transaction>> result =
        await repository.getAllTransactions();

    // Handle the result of the repository call
    result.fold(
      (failure) {
        debugPrint("Failed to get transactions");
        _error = 'Failed to get transactions';
        notifyListeners();
      },
      (transactions) {
        // Convert the list of transactions into a map of categories to transactions
        Map<String, List<Transaction>> transactionsMap =
            convertDataIntoApropriateFormat(transactions);

        // Update

        _transactions = transactionsMap;

        _loading = false;
        notifyListeners();
      },
    );
  }

  // convert data for making use of it in the UI. this step is for making it
  // easier for the UI to use thae data.
  Map<String, List<Transaction>> convertDataIntoApropriateFormat(
      List<Transaction> transactions) {
    final Set<String> keys = transactions.map((t) => t.category).toSet();
    final Map<String, List<Transaction>> transactionsMap = {};
    for (var key in keys) {
      transactionsMap[key] =
          transactions.where((element) => element.category == key).toList();
    }
    return transactionsMap;
  }

  // create transaction and store it in the database.
  Future<void> createTransaction(Transaction transaction) async {
    _loading = true;
    TransactionModel model = TransactionModel(
      category: transaction.category,
      summary: transaction.summary,
      ammount: transaction.ammount,
      date: transaction.date,
    );

    debugPrint('here');
    final Either<Failure, bool> result =
        await repository.createTransaction(model);
    result.fold(
      (failure) {
        debugPrint("Failed to create transaction $failure");
        _error = 'Failed to create transaction';
        notifyListeners();
      },
      (_) {
        getAllTransactions();
      },
    );
    _loading = false;
  }

  // for calculating spending in the current month
  void calculateMonthSpending() {
    final keys = transactions.keys;
    final currentMonth = DateTime.now().month;
    double totalSpending = 0;

    for (var key in keys) {
      List<Transaction> categoryTransactions = transactions[key]!;
      for (var t in categoryTransactions) {
        if (t.date.month == currentMonth) {
          totalSpending += t.ammount;
        }
      }
    }
    debugPrint(totalSpending.toString());
    _totalMonthSpending = totalSpending;
  }

  // getting the top three transactions
  Future<void> getTopThreeTransactions() async {
    final Either<Failure, List<Transaction>> result =
        await repository.getTopThreeTransactions();
    _loading = true;
    result.fold(
      (failure) {
        debugPrint("Failed to get Top 3 transactions");
        _error = 'Failed to get Top 3 transactions';
        notifyListeners();
      },
      (transactions) {
        debugPrint(transactions.length.toString());
        _top3Transactions = transactions;
        _loading = false;
        notifyListeners();
      },
    );
    _loading = false;
  }
}
