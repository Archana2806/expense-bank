import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction_model.dart';
import '../models/budget_model.dart';
import '../models/goal_model.dart';

class StorageService {
  static const String transactionsBox = 'transactions';
  static const String budgetsBox = 'budgets';
  static const String goalsBox = 'goals';
  static const String settingsBox = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(TransactionCategoryAdapter());
    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.registerAdapter(BudgetModelAdapter());
    Hive.registerAdapter(GoalModelAdapter());

    // Open boxes
    await Hive.openBox<TransactionModel>(transactionsBox);
    await Hive.openBox<BudgetModel>(budgetsBox);
    await Hive.openBox<GoalModel>(goalsBox);
    await Hive.openBox(settingsBox);
  }

  // Transaction operations
  static Box<TransactionModel> getTransactionsBox() {
    return Hive.box<TransactionModel>(transactionsBox);
  }

  static Future<void> addTransaction(TransactionModel transaction) async {
    final box = getTransactionsBox();
    await box.put(transaction.id, transaction);
  }

  static Future<void> updateTransaction(TransactionModel transaction) async {
    final box = getTransactionsBox();
    await box.put(transaction.id, transaction);
  }

  static Future<void> deleteTransaction(String id) async {
    final box = getTransactionsBox();
    await box.delete(id);
  }

  static List<TransactionModel> getAllTransactions() {
    final box = getTransactionsBox();
    return box.values.toList();
  }

  // Budget operations
  static Box<BudgetModel> getBudgetsBox() {
    return Hive.box<BudgetModel>(budgetsBox);
  }

  static Future<void> addBudget(BudgetModel budget) async {
    final box = getBudgetsBox();
    await box.put(budget.id, budget);
  }

  static Future<void> updateBudget(BudgetModel budget) async {
    final box = getBudgetsBox();
    await box.put(budget.id, budget);
  }

  static Future<void> deleteBudget(String id) async {
    final box = getBudgetsBox();
    await box.delete(id);
  }

  static List<BudgetModel> getAllBudgets() {
    final box = getBudgetsBox();
    return box.values.toList();
  }

  // Settings operations
  static Box getSettingsBox() {
    return Hive.box(settingsBox);
  }

  static Future<void> setThemeMode(bool isDark) async {
    final box = getSettingsBox();
    await box.put('isDarkMode', isDark);
  }

  static bool getThemeMode() {
    final box = getSettingsBox();
    return box.get('isDarkMode', defaultValue: false) as bool;
  }

  // Goal operations
  static Box<GoalModel> getGoalsBox() {
    return Hive.box<GoalModel>(goalsBox);
  }

  static Future<void> addGoal(GoalModel goal) async {
    final box = getGoalsBox();
    await box.put(goal.id, goal);
  }

  static Future<void> updateGoal(GoalModel goal) async {
    final box = getGoalsBox();
    await box.put(goal.id, goal);
  }

  static Future<void> deleteGoal(String id) async {
    final box = getGoalsBox();
    await box.delete(id);
  }

  static List<GoalModel> getAllGoals() {
    final box = getGoalsBox();
    return box.values.toList();
  }
}
