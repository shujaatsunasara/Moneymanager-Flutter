import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/expense_screen/expense_fetcher.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});
  static const name = '/expense_screen';
  @override
  Widget build(BuildContext context) {
    // get the argument passed from category_card.
    final category = ModalRoute.of(context)!.settings.arguments as String;
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
      body: ExpenseFetcher(category),
    );
  }
}
