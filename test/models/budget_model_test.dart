import 'package:flutter_test/flutter_test.dart';
import 'package:piggyb/models/budget_model.dart';
import 'package:piggyb/models/transaction_model.dart';

void main() {
  group('BudgetModel Tests', () {
    test('Create budget model', () {
      final budget = BudgetModel(
        id: '1',
        category: TransactionCategory.food,
        limit: 500.0,
        month: DateTime(2025, 1, 1),
      );

      expect(budget.id, '1');
      expect(budget.category, TransactionCategory.food);
      expect(budget.limit, 500.0);
      expect(budget.month.year, 2025);
      expect(budget.month.month, 1);
    });

    test('CopyWith method updates fields correctly', () {
      final budget = BudgetModel(
        id: '1',
        category: TransactionCategory.food,
        limit: 500.0,
        month: DateTime(2025, 1, 1),
      );

      final updated = budget.copyWith(
        limit: 600.0,
        category: TransactionCategory.travel,
      );

      expect(updated.id, '1');
      expect(updated.category, TransactionCategory.travel);
      expect(updated.limit, 600.0);
    });
  });
}
