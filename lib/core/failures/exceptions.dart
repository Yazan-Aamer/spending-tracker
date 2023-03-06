class NoTransactionsException implements Exception {
  final String message;

  NoTransactionsException(this.message);

  @override
  String toString() => message;
}

class ModelNotFoundException implements Exception {}
