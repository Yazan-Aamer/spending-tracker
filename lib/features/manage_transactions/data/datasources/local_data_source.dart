import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/failures/exceptions.dart';
import '../models/transaction_model.dart';

// Define an interface for local data source operations for TransactionModel objects.
abstract class LocalDataSource {
  Future<List<TransactionModel>> getAllTransactions();
  Future<bool> createTransaction(TransactionModel transaction);
  Future<List<TransactionModel>> getTopThreeTransactions();
}

// Implementation of the LocalDataSource interface using the SharedPreferences package.
class LocalDataSourceSharedPreferences implements LocalDataSource {
  final SharedPreferences sharedPreferences;
  static const transactionPrefix = 'transaction_';

  List<TransactionModel>? _transactions;

  LocalDataSourceSharedPreferences({required this.sharedPreferences});

  // Creates a new transaction and stores it in the SharedPreferences.
  @override
  Future<bool> createTransaction(TransactionModel transaction) async {
    final key =
        transactionPrefix + (DateTime.now()).millisecondsSinceEpoch.toString();

    final jsonData = jsonEncode(transaction.toJson());
    _transactions = null;
    return await sharedPreferences.setString(key, jsonData);
  }

  // Returns all stored transactions from SharedPreferences.
  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final keys = sharedPreferences.getKeys();
    final transactionKeys =
        keys.where((key) => key.startsWith(transactionPrefix)).toList();
    final transactions = <TransactionModel>[];

    // Deserialize each transaction and add it to the list of transactions.
    for (var key in transactionKeys) {
      final stringData = sharedPreferences.getString(key);
      if (stringData == null) {
        throw ModelNotFoundException();
      }
      final jsonData = jsonDecode(stringData);
      transactions.add(TransactionModel.fromJson(jsonData));
    }

    // Store the list of transactions in the cache.
    return _transactions = transactions;
  }

  // Returns the top 3 transactions from SharedPreferences.
  @override
  Future<List<TransactionModel>> getTopThreeTransactions() async {
    // Get all transactions from SharedPreferences.
    final transactions = await getAllTransactions();

    // Cache the list of transactions.
    _transactions = transactions;

    // Sort the transactions in descending order of amount and return the top 3.
    transactions.sort((a, b) =>
        b.ammount.compareTo(a.ammount)); // sort in descending order of amount

    return transactions.take(3).toList(); // get the top 3 transactions
  }
}
