import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:spending_tracker/features/manage_transactions/domain/repos/transaction_repo.dart';

import '../../../../core/failures/failures.dart';
import '../../data/models/transaction_model.dart';
import '../../domain/entities/transaction.dart';

class TransactionManagementProvider extends ChangeNotifier {
  final TransactionRepo repository;

  // state
  Map<String, List<Transaction>> _transactions = {};
  Map<String, List<Transaction>> get transactions => _transactions;

  bool _loading = false;
  bool get loading => _loading;

  String _error = '';
  String get error => _error;

  TransactionManagementProvider({required this.repository});

  Future<void> getAllTransactions() async {
    _loading = true;
// Map<String, List<Transaction>>

    final Either<Failure, List<Transaction>> result =
        await repository.getAllTransactions();
    result.fold(
      (failure) {
        debugPrint("Failed to get transactions");
        _error = 'Failed to get transactions';
        notifyListeners();
      },
      (transactions) {
        // this code converts the input into apropriate data for view.
        Map<String, List<Transaction>> transactionsMap =
            convertDataIntoApropriateFormat(transactions);
        _transactions = transactionsMap;

        _loading = false;
        notifyListeners();
      },
    );
  }

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
        Map<String, List<Transaction>> transactionsMap =
            convertDataIntoApropriateFormat(transactions);
        _transactions = transactionsMap;
        notifyListeners();
      },
    );
    _loading = false;
  }
}
