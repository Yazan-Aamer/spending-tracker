import 'package:spending_tracker/features/manage_transactions/domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  TransactionModel(
      {required super.category,
      required super.summary,
      required super.ammount,
      required super.date});

  factory TransactionModel.fromJson(json) {
    return TransactionModel(
      category: json['category'],
      summary: json['summary'],
      ammount: json['ammount'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'summary': summary,
      'ammount': ammount,
      'date': date.toIso8601String(),
    };
  }
}
