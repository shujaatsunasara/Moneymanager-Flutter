import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/database_provider.dart';
import './expense_card.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        var exList = db.expenses;
        return exList.isNotEmpty
            ? ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: exList.length,
                itemBuilder: (_, i) => ExpenseCard(exList[i]))
            : Center(
                child: Text(
                  'Maintaining good, No expences yet..',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
      },
    );
  }
}
