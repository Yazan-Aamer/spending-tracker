import 'package:spending_tracker/core/failures/exceptions.dart';
import 'package:spending_tracker/features/manage_transactions/data/datasources/local_data_source.dart';
import 'package:spending_tracker/features/manage_transactions/data/models/transaction_model.dart';
import 'package:spending_tracker/features/manage_transactions/domain/entities/transaction.dart';
import 'package:spending_tracker/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:spending_tracker/features/manage_transactions/domain/repos/transaction_repo.dart';

class TransactionRepoImpl implements TransactionRepo {
  // Create a local data source object that we will use to interact with data
  // We may add a remote data source in the future
  final LocalDataSource datasource;

  TransactionRepoImpl({required this.datasource});

  @override
  // Method to create a new transaction
  // Returns a boolean indicating success or failure wrapped in an Either object
  Future<Either<Failure, bool>> createTransaction(
      TransactionModel transaction) async {
    // Call the createTransaction method of the local data source object
    final result = await datasource.createTransaction(transaction);
    // Check the result of the createTransaction method
    if (result == false) {
      // If the transaction cannot be created, return a TransactionCannotBeCreatedFailure wrapped in an Either object
      return left(TransactionCannotBeCreatedFailure());
    }
    // If the transaction is created successfully, return a boolean true wrapped in an Either object
    return right(true);
  }

  @override
  // Method to get all transactions
  // Returns a list of Transaction objects wrapped in an Either object
  Future<Either<Failure, List<Transaction>>> getAllTransactions() async {
    List<Transaction> transactions;
    try {
      // Call the getAllTransactions method of the local data source object
      transactions = await datasource.getAllTransactions();
    } on ModelNotFoundException catch (e) {
      // If the getAllTransactions method throws a ModelNotFoundException, return a ModelNotFoundFailure wrapped in an Either object
      return left(ModelNotFoundFailure());
    }
    // If the getAllTransactions method executes successfully, return the list of Transaction objects wrapped in an Either object
    return right(transactions);
  }

  @override
  // Method to get the top three transactions
  // Returns a list of Transaction objects wrapped in an Either object
  Future<Either<Failure, List<Transaction>>> getTopThreeTransactions() async {
    List<Transaction> transactions;
    try {
      // Call the getTopThreeTransactions method of the local data source object
      transactions = await datasource.getTopThreeTransactions();
    } on ModelNotFoundException catch (e) {
      // If the getTopThreeTransactions method throws a ModelNotFoundException, return a ModelNotFoundFailure wrapped in an Either object
      return left(ModelNotFoundFailure());
    }
    // If the getTopThreeTransactions method executes successfully, return the list of Transaction objects wrapped in an Either object
    return right(transactions);
  }
}
