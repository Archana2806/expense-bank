import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';

class ExpenseChart extends StatefulWidget {
  const ExpenseChart({super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  int? _selectedSection;
  TransactionCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionProvider>(
      builder: (context, provider, child) {
        final expensesByCategory = provider.getExpensesByCategory();

        if (expensesByCategory.isEmpty) {
          return Container(
            height: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.donut_large_outlined,
                    size: 64,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No expenses yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        final total = expensesByCategory.values.fold<double>(
          0,
          (sum, amount) => sum + amount,
        );

        // Calculate selected label and amount
        String displayLabel = 'Total Spent';
        double displayAmount = total;

        if (_selectedCategory != null &&
            expensesByCategory.containsKey(_selectedCategory)) {
          displayLabel = _selectedCategory!.displayName;
          displayAmount = expensesByCategory[_selectedCategory] ?? 0;
        }

        return Container(
          height: 320,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pie Chart
              SizedBox(
                height: 280,
                child: PieChart(
                  PieChartData(
                    sections: _createSections(expensesByCategory, total),
                    sectionsSpace: 2,
                    centerSpaceRadius:
                        85, // Larger center space for thinner ring
                    startDegreeOffset: -90,
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            _selectedSection = null;
                            _selectedCategory = null;
                            return;
                          }
                          _selectedSection = pieTouchResponse
                              .touchedSection!
                              .touchedSectionIndex;
                          final categories = expensesByCategory.keys.toList();
                          if (_selectedSection != null &&
                              _selectedSection! >= 0 &&
                              _selectedSection! < categories.length) {
                            _selectedCategory = categories[_selectedSection!];
                          } else {
                            _selectedSection = null;
                            _selectedCategory = null;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ),
              // Center Content
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSection = null;
                    _selectedCategory = null;
                  });
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '₹ ${displayAmount.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      displayLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<PieChartSectionData> _createSections(
    Map<dynamic, double> data,
    double total,
  ) {
    // Neutral, muted color palette
    final neutralColors = [
      const Color(0xFF94A3B8), // Slate gray
      const Color(0xFFCBD5E1), // Light slate
      const Color(0xFFE2E8F0), // Very light gray
      const Color(0xFFF1F5F9), // Off white
      const Color(0xFF64748B), // Medium slate
      const Color(0xFF475569), // Darker slate
      const Color(0xFF334155), // Dark slate
      const Color(0xFF1E293B), // Very dark slate
      const Color(0xFF0F172A), // Almost black
      const Color(0xFF6B7280), // Gray
    ];

    return data.entries.map((entry) {
      final index = data.keys.toList().indexOf(entry.key);
      final isSelected = _selectedCategory == entry.key;

      return PieChartSectionData(
        value: entry.value,
        color: isSelected
            ? neutralColors[index % neutralColors.length].withValues(
                alpha: 0.8,
              ) // Slightly more opaque when selected
            : neutralColors[index % neutralColors.length],
        radius: isSelected ? 50 : 45, // Slightly larger when selected
        showTitle: false,
      );
    }).toList();
  }
}
