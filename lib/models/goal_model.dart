import 'package:hive/hive.dart';

part 'goal_model.g.dart';

@HiveType(typeId: 4)
class GoalModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double targetAmount;

  @HiveField(3)
  final double currentAmount;

  @HiveField(4)
  final DateTime startDate;

  @HiveField(5)
  final DateTime targetDate;

  @HiveField(6)
  final String? description;

  GoalModel({
    required this.id,
    required this.name,
    required this.targetAmount,
    required this.currentAmount,
    required this.startDate,
    required this.targetDate,
    this.description,
  });

  // Calculate monthly savings target
  double get monthlySavingsTarget {
    final monthsRemaining = targetDate.difference(startDate).inDays / 30;
    if (monthsRemaining <= 0) return targetAmount - currentAmount;
    return (targetAmount - currentAmount) / monthsRemaining;
  }

  // Calculate current month's progress
  double get currentMonthProgress {
    // This would need to be calculated based on actual savings
    // For now, returning 0 as placeholder
    return 0;
  }

  // Check if on track
  bool get isOnTrack {
    final monthsElapsed = DateTime.now().difference(startDate).inDays / 30;
    final expectedAmount = monthlySavingsTarget * monthsElapsed;
    return currentAmount >= expectedAmount;
  }

  // Calculate progress percentage
  double get progressPercentage {
    if (targetAmount == 0) return 0;
    return (currentAmount / targetAmount * 100).clamp(0, 100);
  }

  // Days remaining
  int get daysRemaining {
    return targetDate.difference(DateTime.now()).inDays;
  }

  // Months remaining
  int get monthsRemaining {
    return (daysRemaining / 30).ceil();
  }

  GoalModel copyWith({
    String? id,
    String? name,
    double? targetAmount,
    double? currentAmount,
    DateTime? startDate,
    DateTime? targetDate,
    String? description,
  }) {
    return GoalModel(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'startDate': startDate.toIso8601String(),
      'targetDate': targetDate.toIso8601String(),
      'description': description,
    };
  }

  factory GoalModel.fromMap(Map<String, dynamic> map) {
    return GoalModel(
      id: map['id'],
      name: map['name'],
      targetAmount: map['targetAmount'],
      currentAmount: map['currentAmount'],
      startDate: DateTime.parse(map['startDate']),
      targetDate: DateTime.parse(map['targetDate']),
      description: map['description'],
    );
  }
}
