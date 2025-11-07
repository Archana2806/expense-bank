import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../providers/transaction_provider.dart';
import '../services/csv_export_service.dart';
import '../theme/sketch_theme.dart';
import 'add_transaction_screen.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  TransactionType? _filterType;
  TransactionCategory? _filterCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () => _exportTransactions(context),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list_outlined),
            onSelected: (value) {
              setState(() {
                if (value == 'all') {
                  _filterType = null;
                  _filterCategory = null;
                } else if (value == 'income') {
                  _filterType = TransactionType.income;
                } else if (value == 'expense') {
                  _filterType = TransactionType.expense;
                }
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'all',
                child: Text('All Transactions'),
              ),
              const PopupMenuItem(value: 'income', child: Text('Income Only')),
              const PopupMenuItem(
                value: 'expense',
                child: Text('Expenses Only'),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          var transactions = provider.transactions;

          // Apply filters
          if (_filterType != null) {
            transactions = transactions
                .where((t) => t.type == _filterType)
                .toList();
          }
          if (_filterCategory != null) {
            transactions = transactions
                .where((t) => t.category == _filterCategory)
                .toList();
          }

          if (transactions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.receipt_long, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'No transactions yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add your first transaction to get started!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return _SketchTransactionCard(
                transaction: transaction,
                provider: provider,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTransactionScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _exportTransactions(BuildContext context) async {
    try {
      final transactions = context.read<TransactionProvider>().transactions;
      if (transactions.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No transactions to export'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      await CsvExportService.exportTransactions(transactions);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Transactions exported successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error exporting: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

// Sketch-style transaction card widget
class _SketchTransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final TransactionProvider provider;

  const _SketchTransactionCard({
    required this.transaction,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: SketchTheme.sketchBox(),
      child: Dismissible(
        key: Key(transaction.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: SketchTheme.expenseRed,
            border: Border.all(color: SketchTheme.inkBlack, width: 2.5),
          ),
          child: Icon(
            Icons.delete_outline,
            color: SketchTheme.paperWhite,
            size: 32,
          ),
        ),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Transaction?'),
              content: const Text('This cannot be undone.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Delete'),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          provider.deleteTransaction(transaction.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Transaction deleted'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  provider.undoDelete();
                },
              ),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: transaction.type == TransactionType.income
                    ? SketchTheme.incomeGreen.withValues(alpha: 0.2)
                    : SketchTheme.expenseRed.withValues(alpha: 0.2),
                border: Border.all(color: SketchTheme.inkBlack, width: 2),
              ),
              child: Icon(
                transaction.category.icon,
                size: 28,
                color: transaction.type == TransactionType.income
                    ? SketchTheme.incomeGreen
                    : SketchTheme.expenseRed,
              ),
            ),
            title: Text(
              transaction.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.category.displayName,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  DateFormat('MMM dd, yyyy').format(transaction.date),
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${transaction.type == TransactionType.income ? '+' : '-'}₹ ${transaction.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: transaction.type == TransactionType.income
                        ? SketchTheme.incomeGreen
                        : SketchTheme.expenseRed,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddTransactionScreen(transaction: transaction),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
