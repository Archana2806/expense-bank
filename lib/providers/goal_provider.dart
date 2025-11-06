import 'package:flutter/foundation.dart';
import '../models/goal_model.dart';
import '../services/storage_service.dart';

class GoalProvider extends ChangeNotifier {
  List<GoalModel> _goals = [];

  List<GoalModel> get goals => _goals;

  GoalProvider() {
    loadGoals();
  }

  Future<void> loadGoals() async {
    _goals = StorageService.getAllGoals();
    notifyListeners();
  }

  Future<void> addGoal(GoalModel goal) async {
    await StorageService.addGoal(goal);
    loadGoals();
  }

  Future<void> updateGoal(GoalModel goal) async {
    await StorageService.updateGoal(goal);
    loadGoals();
  }

  Future<void> deleteGoal(String id) async {
    await StorageService.deleteGoal(id);
    loadGoals();
  }

  Future<void> addToGoal(String id, double amount) async {
    final goal = _goals.firstWhere((g) => g.id == id);
    final updatedGoal = goal.copyWith(
      currentAmount: goal.currentAmount + amount,
    );
    await updateGoal(updatedGoal);
  }

  GoalModel? getGoalById(String id) {
    try {
      return _goals.firstWhere((g) => g.id == id);
    } catch (e) {
      return null;
    }
  }

  List<GoalModel> getActiveGoals() {
    return _goals.where((g) => g.daysRemaining > 0).toList();
  }

  List<GoalModel> getCompletedGoals() {
    return _goals.where((g) => g.progressPercentage >= 100).toList();
  }

  List<GoalModel> getOffTrackGoals() {
    return _goals.where((g) => !g.isOnTrack && g.daysRemaining > 0).toList();
  }
}
