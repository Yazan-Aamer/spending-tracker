class Transaction {
  final String category;
  final String summary;
  final double ammount;
  final DateTime date;

  Transaction(
      {required this.category,
      required this.summary,
      required this.ammount,
      required this.date});
}
