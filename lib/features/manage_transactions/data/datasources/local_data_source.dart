import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/failures/exceptions.dart';
import '../models/transaction_model.dart';

abstract class LocalDataSource {
  Future<List<TransactionModel>> getAllTransactions();
  Future<bool> createTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTopThreeTransactions();
}

class LocalDataSourceSharedPreferences implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  static const transactionPrefix = 'transaction_';

  List<TransactionModel>? _transactions;

  LocalDataSourceSharedPreferences({required this.sharedPreferences});

  @override
  Future<bool> createTransaction(TransactionModel transaction) async {
    final key =
        transactionPrefix + (DateTime.now()).millisecondsSinceEpoch.toString();

    final jsonData = jsonEncode(transaction.toJson());
    _transactions = null;
    return await sharedPreferences.setString(key, jsonData);
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final keys = sharedPreferences.getKeys();
    final transactionKeys =
        keys.where((key) => key.startsWith(transactionPrefix)).toList();
    final transactions = <TransactionModel>[];

    for (var key in transactionKeys) {
      final stringData = sharedPreferences.getString(key);
      if (stringData == null) {
        throw ModelNotFoundException();
      }
      final jsonData = jsonDecode(stringData);
      transactions.add(TransactionModel.fromJson(jsonData));
    }

    return _transactions = transactions;
  }

  @override
  Future<List<TransactionModel>> getTopThreeTransactions() async {
    if (_transactions != null) return _transactions!;
    final transactions = await getAllTransactions();

    // cache the data in RAM
    _transactions = transactions;
    transactions.sort((a, b) =>
        b.ammount.compareTo(a.ammount)); // sort in descending order of amount
    return transactions.take(3).toList(); // get the top 3 transactions
  }
}
