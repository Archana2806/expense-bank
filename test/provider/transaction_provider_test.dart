import 'package:flutter_test/flutter_test.dart';
import 'package:piggyb/models/transaction_model.dart';

void main() {
  group('TransactionModel Calculations', () {
    test('Calculate balance correctly', () {
      final income = 1000.0;
      final expenses = 500.0;
      final balance = income - expenses;

      expect(balance, 500.0);
    });

    test('Filter transactions by type', () {
      final transactions = [
        TransactionModel(
          id: '1',
          title: 'Salary',
          amount: 1000.0,
          category: TransactionCategory.salary,
          type: TransactionType.income,
          date: DateTime.now(),
        ),
        TransactionModel(
          id: '2',
          title: 'Food',
          amount: 50.0,
          category: TransactionCategory.food,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
      ];

      final expenses = transactions
          .where((t) => t.type == TransactionType.expense)
          .toList();
      final income = transactions
          .where((t) => t.type == TransactionType.income)
          .toList();

      expect(expenses.length, 1);
      expect(income.length, 1);
    });

    test('Calculate total expenses', () {
      final transactions = [
        TransactionModel(
          id: '1',
          title: 'Food',
          amount: 50.0,
          category: TransactionCategory.food,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
        TransactionModel(
          id: '2',
          title: 'Travel',
          amount: 100.0,
          category: TransactionCategory.travel,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
      ];

      final total = transactions
          .where((t) => t.type == TransactionType.expense)
          .fold<double>(0, (sum, t) => sum + t.amount);

      expect(total, 150.0);
    });

    test('Group expenses by category', () {
      final transactions = [
        TransactionModel(
          id: '1',
          title: 'Food 1',
          amount: 50.0,
          category: TransactionCategory.food,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
        TransactionModel(
          id: '2',
          title: 'Food 2',
          amount: 30.0,
          category: TransactionCategory.food,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
        TransactionModel(
          id: '3',
          title: 'Travel',
          amount: 100.0,
          category: TransactionCategory.travel,
          type: TransactionType.expense,
          date: DateTime.now(),
        ),
      ];

      final expensesByCategory = <TransactionCategory, double>{};
      for (var transaction in transactions) {
        if (transaction.type == TransactionType.expense) {
          expensesByCategory[transaction.category] =
              (expensesByCategory[transaction.category] ?? 0) +
              transaction.amount;
        }
      }

      expect(expensesByCategory[TransactionCategory.food], 80.0);
      expect(expensesByCategory[TransactionCategory.travel], 100.0);
    });

    test('Filter transactions by month', () {
      final targetMonth = DateTime(2025, 1);
      final transactions = [
        TransactionModel(
          id: '1',
          title: 'January expense',
          amount: 50.0,
          category: TransactionCategory.food,
          type: TransactionType.expense,
          date: DateTime(2025, 1, 15),
        ),
        TransactionModel(
          id: '2',
          title: 'February expense',
          amount: 100.0,
          category: TransactionCategory.travel,
          type: TransactionType.expense,
          date: DateTime(2025, 2, 15),
        ),
      ];

      final januaryTransactions = transactions
          .where(
            (t) =>
                t.date.year == targetMonth.year &&
                t.date.month == targetMonth.month,
          )
          .toList();

      expect(januaryTransactions.length, 1);
      expect(januaryTransactions.first.title, 'January expense');
    });

    test('Sort transactions by date', () {
      final transactions = [
        TransactionModel(
          id: '1',
          title: 'Old',
          amount: 50.0,
          category: TransactionCategory.food,
          type: TransactionType.expense,
          date: DateTime(2025, 1, 1),
        ),
        TransactionModel(
          id: '2',
          title: 'Recent',
          amount: 100.0,
          category: TransactionCategory.travel,
          type: TransactionType.expense,
          date: DateTime(2025, 1, 15),
        ),
      ];

      transactions.sort((a, b) => b.date.compareTo(a.date));

      expect(transactions.first.title, 'Recent');
      expect(transactions.last.title, 'Old');
    });
  });
}
