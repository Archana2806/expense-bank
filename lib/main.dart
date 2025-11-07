import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/transaction_provider.dart';
import 'providers/budget_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/goal_provider.dart';
import 'services/storage_service.dart';
import 'screens/dashboard_screen.dart';
import 'theme/sketch_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => GoalProvider()),
        ChangeNotifierProxyProvider<TransactionProvider, BudgetProvider>(
          create: (context) => BudgetProvider(
            transactionProvider: context.read<TransactionProvider>(),
          ),
          update: (context, transactionProvider, previous) =>
              previous ??
              BudgetProvider(transactionProvider: transactionProvider),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Expense Tracker',
            debugShowCheckedModeBanner: false,
            theme: SketchTheme.lightTheme,
            darkTheme: SketchTheme.lightTheme,
            themeMode: ThemeMode.light,
            home: const DashboardScreen(),
          );
        },
      ),
    );
  }
}
