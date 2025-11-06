Here's your README exactly as you have it, ready to copy-paste into VS Code:

```markdown
# Expense Tracker

A Flutter app for tracking personal expenses with budgets, goals, and analytics.

## Quick Start

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

## Features

- **Dashboard**: Balance overview, expense charts, recent transactions
- **Transactions**: Add/edit/delete with categories and validation
- **Budgets**: Monthly budget tracking with progress indicators
- **Goals**: Financial goal setting and tracking
- **Themes**: Dark/light mode toggle
- **Export**: CSV export functionality

## Architecture

### Structure
```
lib/
├── main.dart                 # App entry
├── models/                   # Data models (Transaction, Budget, Goal)
├── providers/                # State management (Provider pattern)
├── services/                 # Business logic (Storage, CSV export)
├── screens/                  # UI screens
└── widgets/                  # Reusable components
```

### Tech Stack
- **State Management**: Provider 
- **Local Storage**: Hive
- **Charts**: FL Chart
- **Export**: CSV 

### Data Flow
User Input → UI → Provider → Service → Model → Hive Storage

## Testing

### Run Tests
```bash
flutter test                   # All tests
flutter test --coverage        # With coverage
```

### Test Coverage
- Models: Business logic validation
- Providers: State management
- Widgets: UI components

## Dependencies

### Core
```yaml
provider: ^6.1.1      # State management
hive: ^2.2.3          # Local database
fl_chart: ^0.68.0     # Charts
csv: ^6.0.0           # Export
```

### Dev
```yaml
flutter_test: sdk     # Testing
mockito: ^5.4.4       # Mocks
build_runner: ^2.4.7  # Code gen
```

## Project Structure Details

### Models
- `TransactionModel`: Income/expense with category, date, amount
- `BudgetModel`: Category budgets with limits and tracking
- `GoalModel`: Financial goals with progress

### Providers
- `TransactionProvider`: CRUD operations, balance calculations
- `BudgetProvider`: Budget management, progress tracking
- `GoalProvider`: Goal setting and monitoring
- `ThemeProvider`: Dark/light theme switching

### Services
- `StorageService`: Hive database operations for all models
- `CsvExportService`: Transaction export to CSV

### Screens
- `DashboardScreen`: Main overview with charts
- `AddTransactionScreen`: Transaction form
- `TransactionsScreen`: Full transaction list
- `BudgetsScreen`: Budget management
- `GoalsScreen`: Goal tracking
- `SettingsScreen`: App preferences

### Widgets
- `BalanceCard`: Financial summary display
- `ExpenseChart`: Pie chart visualization
- `RecentTransactionsList`: Transaction previews
```
