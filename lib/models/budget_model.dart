import 'package:hive/hive.dart';
import 'transaction_model.dart';

part 'budget_model.g.dart';

@HiveType(typeId: 3)
class BudgetModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  TransactionCategory category;

  @HiveField(2)
  double limit;

  @HiveField(3)
  DateTime month;

  BudgetModel({
    required this.id,
    required this.category,
    required this.limit,
    required this.month,
  });

  BudgetModel copyWith({
    String? id,
    TransactionCategory? category,
    double? limit,
    DateTime? month,
  }) {
    return BudgetModel(
      id: id ?? this.id,
      category: category ?? this.category,
      limit: limit ?? this.limit,
      month: month ?? this.month,
    );
  }
}
