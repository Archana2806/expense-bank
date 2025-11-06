import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';

class CsvExportService {
  static Future<void> exportTransactions(
    List<TransactionModel> transactions,
  ) async {
    try {
      // Prepare CSV data
      List<List<dynamic>> rows = [
        ['Date', 'Title', 'Category', 'Type', 'Amount', 'Description'],
      ];

      for (var transaction in transactions) {
        rows.add([
          DateFormat('yyyy-MM-dd').format(transaction.date),
          transaction.title,
          transaction.category.displayName,
          transaction.type.name,
          transaction.amount.toStringAsFixed(2),
          transaction.description ?? '',
        ]);
      }

      // Convert to CSV
      String csv = const ListToCsvConverter().convert(rows);

      // Get temporary directory
      final directory = await getTemporaryDirectory();
      final path =
          '${directory.path}/transactions_${DateTime.now().millisecondsSinceEpoch}.csv';

      // Write to file
      final file = File(path);
      await file.writeAsString(csv);

      // Share the file
      await Share.shareXFiles([
        XFile(path),
      ], subject: 'Expense Tracker - Transactions Export');
    } catch (e) {
      throw Exception('Failed to export transactions: $e');
    }
  }
}
