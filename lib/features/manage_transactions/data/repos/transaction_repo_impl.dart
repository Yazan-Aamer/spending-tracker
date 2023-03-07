import 'package:spending_tracker/core/failures/exceptions.dart';
import 'package:spending_tracker/features/manage_transactions/data/datasources/local_data_source.dart';
import 'package:spending_tracker/features/manage_transactions/data/models/transaction_model.dart';
import 'package:spending_tracker/features/manage_transactions/domain/entities/transaction.dart';
import 'package:spending_tracker/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:spending_tracker/features/manage_transactions/domain/repos/transaction_repo.dart';

class TransactionRepoImpl implements TransactionRepo {
  // note that this is currently the only datasource we are dealing with.
  // remote datasource may be added in the future.
  final LocalDataSource datasource;

  TransactionRepoImpl({required this.datasource});

  @override
  Future<Either<Failure, bool>> createTransaction(
      TransactionModel transaction) async {
    final result = await datasource.createTransaction(transaction);
    if (result == false) {
      return left(TransactionCannotBeCreatedFailure());
    }

    return right(true);
  }

  @override
  Future<Either<Failure, List<Transaction>>> getAllTransactions() async {
    List<Transaction> transactions;
    try {
      transactions = await datasource.getAllTransactions();
    } on ModelNotFoundException catch (e) {
      return left(ModelNotFoundFailure());
    }
    return right(transactions);
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTopThreeTransactions() async {
    List<Transaction> transactions;
    try {
      transactions = await datasource.getTopThreeTransactions();
    } on ModelNotFoundException catch (e) {
      return left(ModelNotFoundFailure());
    }
    return right(transactions);
  }
}
