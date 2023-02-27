import 'package:expense_app/theme.dart';
import 'package:flutter/material.dart';
import '../widgets/all_expenses_screen/all_expenses_fetcher.dart';

class AllExpenses extends StatefulWidget {
  const AllExpenses({super.key});
  static const name = '/all_expenses';

  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: xtrans,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            color: xText,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'All Expenses',
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: const AllExpensesFetcher(),
    );
  }
}
