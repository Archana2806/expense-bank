import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  double amount;

  @HiveField(3)
  TransactionCategory category;

  @HiveField(4)
  TransactionType type;

  @HiveField(5)
  DateTime date;

  @HiveField(6)
  String? description;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.type,
    required this.date,
    this.description,
  });

  TransactionModel copyWith({
    String? id,
    String? title,
    double? amount,
    TransactionCategory? category,
    TransactionType? type,
    DateTime? date,
    String? description,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      type: type ?? this.type,
      date: date ?? this.date,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'category': category.name,
      'type': type.name,
      'date': date.toIso8601String(),
      'description': description,
    };
  }
}

@HiveType(typeId: 1)
enum TransactionCategory {
  @HiveField(0)
  food,
  @HiveField(1)
  travel,
  @HiveField(2)
  bills,
  @HiveField(3)
  entertainment,
  @HiveField(4)
  shopping,
  @HiveField(5)
  healthcare,
  @HiveField(6)
  education,
  @HiveField(7)
  salary,
  @HiveField(8)
  investment,
  @HiveField(9)
  other,
}

@HiveType(typeId: 2)
enum TransactionType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

extension TransactionCategoryExtension on TransactionCategory {
  String get displayName {
    return switch (this) {
      TransactionCategory.food => 'Food',
      TransactionCategory.travel => 'Travel',
      TransactionCategory.bills => 'Bills',
      TransactionCategory.entertainment => 'Entertainment',
      TransactionCategory.shopping => 'Shopping',
      TransactionCategory.healthcare => 'Healthcare',
      TransactionCategory.education => 'Education',
      TransactionCategory.salary => 'Salary',
      TransactionCategory.investment => 'Investment',
      TransactionCategory.other => 'Other',
    };
  }

  String get icon {
    return switch (this) {
      TransactionCategory.food => '🍔',
      TransactionCategory.travel => '✈️',
      TransactionCategory.bills => '📄',
      TransactionCategory.entertainment => '🎬',
      TransactionCategory.shopping => '🛍️',
      TransactionCategory.healthcare => '💊',
      TransactionCategory.education => '📚',
      TransactionCategory.salary => '💰',
      TransactionCategory.investment => '📈',
      TransactionCategory.other => '📦',
    };
  }
}
