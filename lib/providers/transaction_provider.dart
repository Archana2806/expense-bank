import 'package:flutter/foundation.dart';
import '../models/transaction_model.dart';
import '../services/storage_service.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  TransactionModel? _deletedTransaction;
  String? _deletedTransactionKey;

  List<TransactionModel> get transactions => _transactions;

  TransactionProvider() {
    loadTransactions();
  }

  void loadTransactions() {
    _transactions = StorageService.getAllTransactions();
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await StorageService.addTransaction(transaction);
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  Future<void> updateTransaction(TransactionModel transaction) async {
    await StorageService.updateTransaction(transaction);
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
      _transactions.sort((a, b) => b.date.compareTo(a.date));
      notifyListeners();
    }
  }

  Future<void> deleteTransaction(String id) async {
    final index = _transactions.indexWhere((t) => t.id == id);
    if (index != -1) {
      _deletedTransaction = _transactions[index];
      _deletedTransactionKey = id;
      _transactions.removeAt(index);
      await StorageService.deleteTransaction(id);
      notifyListeners();
    }
  }

  Future<void> undoDelete() async {
    if (_deletedTransaction != null && _deletedTransactionKey != null) {
      await StorageService.addTransaction(_deletedTransaction!);
      _transactions.add(_deletedTransaction!);
      _transactions.sort((a, b) => b.date.compareTo(a.date));
      _deletedTransaction = null;
      _deletedTransactionKey = null;
      notifyListeners();
    }
  }

  List<TransactionModel> getRecentTransactions({int count = 10}) {
    return _transactions.take(count).toList();
  }

  double getTotalIncome() {
    return _transactions
        .where((t) => t.type == TransactionType.income)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double getTotalExpenses() {
    return _transactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0, (sum, t) => sum + t.amount);
  }

  double getCurrentBalance() {
    return getTotalIncome() - getTotalExpenses();
  }

  Map<TransactionCategory, double> getExpensesByCategory() {
    final expenses = _transactions
        .where((t) => t.type == TransactionType.expense)
        .toList();

    Map<TransactionCategory, double> categoryTotals = {};

    for (var transaction in expenses) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    }

    return categoryTotals;
  }

  Map<TransactionCategory, double> getMonthlyExpensesByCategory(
    DateTime month,
  ) {
    final expenses = _transactions
        .where(
          (t) =>
              t.type == TransactionType.expense &&
              t.date.year == month.year &&
              t.date.month == month.month,
        )
        .toList();

    Map<TransactionCategory, double> categoryTotals = {};

    for (var transaction in expenses) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    }

    return categoryTotals;
  }

  List<TransactionModel> getTransactionsByMonth(DateTime month) {
    return _transactions
        .where((t) => t.date.year == month.year && t.date.month == month.month)
        .toList();
  }
}
