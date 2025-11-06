import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/transactions_screen.dart';
import 'screens/add_transaction_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PiggyB',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (ctx) => const DashboardScreen(),
        '/transactions': (ctx) => const TransactionsScreen(),
        '/add_transaction': (ctx) => const AddTransactionScreen(),
      },
    );
  }
}
