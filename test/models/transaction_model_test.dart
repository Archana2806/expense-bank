import 'package:flutter_test/flutter_test.dart';
import 'package:piggyb/models/transaction_model.dart';

void main() {
  group('TransactionModel Tests', () {
    test('Create transaction model', () {
      final transaction = TransactionModel(
        id: '1',
        title: 'Test Transaction',
        amount: 100.0,
        category: TransactionCategory.food,
        type: TransactionType.expense,
        date: DateTime(2025, 1, 1),
        description: 'Test description',
      );

      expect(transaction.id, '1');
      expect(transaction.title, 'Test Transaction');
      expect(transaction.amount, 100.0);
      expect(transaction.category, TransactionCategory.food);
      expect(transaction.type, TransactionType.expense);
      expect(transaction.description, 'Test description');
    });

    test('CopyWith method updates fields correctly', () {
      final transaction = TransactionModel(
        id: '1',
        title: 'Original',
        amount: 100.0,
        category: TransactionCategory.food,
        type: TransactionType.expense,
        date: DateTime(2025, 1, 1),
      );

      final updated = transaction.copyWith(title: 'Updated', amount: 200.0);

      expect(updated.id, '1');
      expect(updated.title, 'Updated');
      expect(updated.amount, 200.0);
      expect(updated.category, TransactionCategory.food);
    });

    test('TransactionCategory extension returns correct display name', () {
      expect(TransactionCategory.food.displayName, 'Food');
      expect(TransactionCategory.travel.displayName, 'Travel');
      expect(TransactionCategory.bills.displayName, 'Bills');
    });

    test('TransactionCategory extension returns correct icon', () {
      expect(TransactionCategory.food.icon, '🍔');
      expect(TransactionCategory.travel.icon, '✈️');
      expect(TransactionCategory.bills.icon, '📄');
    });

    test('Transaction toMap method returns correct map', () {
      final transaction = TransactionModel(
        id: '1',
        title: 'Test',
        amount: 100.0,
        category: TransactionCategory.food,
        type: TransactionType.expense,
        date: DateTime(2025, 1, 1),
      );

      final map = transaction.toMap();

      expect(map['id'], '1');
      expect(map['title'], 'Test');
      expect(map['amount'], 100.0);
      expect(map['category'], 'food');
      expect(map['type'], 'expense');
    });
  });
}
