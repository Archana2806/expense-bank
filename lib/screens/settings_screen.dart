import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          const SizedBox(height: 8),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return SwitchListTile(
                secondary: Icon(
                  themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                title: const Text('Dark Mode'),
                subtitle: Text(
                  themeProvider.isDarkMode ? 'Enabled' : 'Disabled',
                ),
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Expense Tracker',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2025 Expense Tracker',
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'A cross-platform Flutter app to track personal expenses and budgets with basic analytics.',
                  ),
                ],
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy'),
            subtitle: const Text('All data is stored locally'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Privacy'),
                  content: const Text(
                    'This app stores all your data locally on your device. '
                    'No data is sent to any external servers or third parties. '
                    'Your financial information remains completely private.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categories'),
            subtitle: const Text('10 categories available'),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Available Categories'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _CategoryRow(icon: Icons.restaurant, text: 'Food'),
                        _CategoryRow(icon: Icons.flight, text: 'Travel'),
                        _CategoryRow(icon: Icons.receipt_long, text: 'Bills'),
                        _CategoryRow(icon: Icons.movie, text: 'Entertainment'),
                        _CategoryRow(
                          icon: Icons.shopping_bag,
                          text: 'Shopping',
                        ),
                        _CategoryRow(
                          icon: Icons.local_hospital,
                          text: 'Healthcare',
                        ),
                        _CategoryRow(icon: Icons.school, text: 'Education'),
                        _CategoryRow(icon: Icons.attach_money, text: 'Salary'),
                        _CategoryRow(
                          icon: Icons.trending_up,
                          text: 'Investment',
                        ),
                        _CategoryRow(icon: Icons.category, text: 'Other'),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _CategoryRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(text)],
      ),
    );
  }
}
