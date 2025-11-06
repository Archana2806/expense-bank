import 'package:flutter_test/flutter_test.dart';
import 'package:piggyb/models/budget_model.dart';
import 'package:piggyb/models/transaction_model.dart';
import 'package:piggyb/providers/budget_provider.dart';

void main() {
  group('Budget Calculations', () {
    test('Calculate budget percentage correctly', () {
      final spent = 400.0;
      final limit = 500.0;
      final percentage = (spent / limit) * 100;

      expect(percentage, 80.0);
    });

    test('Determine budget status - normal', () {
      final percentage = 50.0;
      BudgetStatus status;

      if (percentage >= 100) {
        status = BudgetStatus.exceeded;
      } else if (percentage >= 80) {
        status = BudgetStatus.warning;
      } else {
        status = BudgetStatus.normal;
      }

      expect(status, BudgetStatus.normal);
    });

    test('Determine budget status - warning', () {
      final percentage = 85.0;
      BudgetStatus status;

      if (percentage >= 100) {
        status = BudgetStatus.exceeded;
      } else if (percentage >= 80) {
        status = BudgetStatus.warning;
      } else {
        status = BudgetStatus.normal;
      }

      expect(status, BudgetStatus.warning);
    });

    test('Determine budget status - exceeded', () {
      final percentage = 110.0;
      BudgetStatus status;

      if (percentage >= 100) {
        status = BudgetStatus.exceeded;
      } else if (percentage >= 80) {
        status = BudgetStatus.warning;
      } else {
        status = BudgetStatus.normal;
      }

      expect(status, BudgetStatus.exceeded);
    });

    test('Filter budgets by month', () {
      final targetMonth = DateTime(2025, 1);
      final budgets = [
        BudgetModel(
          id: '1',
          category: TransactionCategory.food,
          limit: 500.0,
          month: DateTime(2025, 1),
        ),
        BudgetModel(
          id: '2',
          category: TransactionCategory.travel,
          limit: 300.0,
          month: DateTime(2025, 2),
        ),
      ];

      final januaryBudgets = budgets
          .where(
            (b) =>
                b.month.year == targetMonth.year &&
                b.month.month == targetMonth.month,
          )
          .toList();

      expect(januaryBudgets.length, 1);
      expect(januaryBudgets.first.category, TransactionCategory.food);
    });

    test('Calculate remaining budget', () {
      final limit = 500.0;
      final spent = 350.0;
      final remaining = limit - spent;

      expect(remaining, 150.0);
      expect(remaining > 0, true);
    });
  });

  group('BudgetStatus Tests', () {
    test('Budget status enum has correct values', () {
      expect(BudgetStatus.normal, isA<BudgetStatus>());
      expect(BudgetStatus.warning, isA<BudgetStatus>());
      expect(BudgetStatus.exceeded, isA<BudgetStatus>());
    });

    test('Budget status comparison', () {
      expect(BudgetStatus.normal != BudgetStatus.warning, true);
      expect(BudgetStatus.warning != BudgetStatus.exceeded, true);
      expect(BudgetStatus.normal == BudgetStatus.normal, true);
    });
  });
}
