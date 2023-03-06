import '../../../../core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import '../../data/models/transaction_model.dart';
import '../entities/transaction.dart';

abstract class TransactionRepo {
  Future<Either<Failure, List<Transaction>>> getAllTransactions();
  // only parameters are models. it returns only entitiesl because they are
  // used in the domain only.
  Future<Either<Failure, bool>> createTransaction(TransactionModel transaction);
  Future<Either<Failure, List<Transaction>>> getTopThreeTransactions();
}
