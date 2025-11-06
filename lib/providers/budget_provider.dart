import 'package:flutter/foundation.dart';
import '../models/budget_model.dart';
import '../models/transaction_model.dart';
import '../services/storage_service.dart';
import 'transaction_provider.dart';

class BudgetProvider with ChangeNotifier {
  List<BudgetModel> _budgets = [];
  final TransactionProvider transactionProvider;

  List<BudgetModel> get budgets => _budgets;

  BudgetProvider({required this.transactionProvider}) {
    loadBudgets();
  }

  void loadBudgets() {
    _budgets = StorageService.getAllBudgets();
    notifyListeners();
  }

  Future<void> addBudget(BudgetModel budget) async {
    await StorageService.addBudget(budget);
    _budgets.add(budget);
    notifyListeners();
  }

  Future<void> updateBudget(BudgetModel budget) async {
    await StorageService.updateBudget(budget);
    final index = _budgets.indexWhere((b) => b.id == budget.id);
    if (index != -1) {
      _budgets[index] = budget;
      notifyListeners();
    }
  }

  Future<void> deleteBudget(String id) async {
    await StorageService.deleteBudget(id);
    _budgets.removeWhere((b) => b.id == id);
    notifyListeners();
  }

  BudgetModel? getBudgetForCategory(
    TransactionCategory category,
    DateTime month,
  ) {
    try {
      return _budgets.firstWhere(
        (b) =>
            b.category == category &&
            b.month.year == month.year &&
            b.month.month == month.month,
      );
    } catch (e) {
      return null;
    }
  }

  double getSpentAmount(TransactionCategory category, DateTime month) {
    final expenses = transactionProvider.getMonthlyExpensesByCategory(month);
    return expenses[category] ?? 0;
  }

  double getBudgetPercentage(TransactionCategory category, DateTime month) {
    final budget = getBudgetForCategory(category, month);
    if (budget == null || budget.limit == 0) return 0;

    final spent = getSpentAmount(category, month);
    return (spent / budget.limit) * 100;
  }

  BudgetStatus getBudgetStatus(TransactionCategory category, DateTime month) {
    final percentage = getBudgetPercentage(category, month);

    if (percentage >= 100) return BudgetStatus.exceeded;
    if (percentage >= 80) return BudgetStatus.warning;
    return BudgetStatus.normal;
  }

  List<BudgetModel> getCurrentMonthBudgets() {
    final now = DateTime.now();
    return _budgets
        .where((b) => b.month.year == now.year && b.month.month == now.month)
        .toList();
  }
}

enum BudgetStatus { normal, warning, exceeded }
