import 'package:flutter/material.dart';

// ignore_for_file: deprecated_member_use

import 'package:expense_app/theme.dart';
import 'package:intl/intl.dart';
import '../../models/expence_sort.dart';
import '../../screens/expense_screen.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ExpenseScreen.name,
              arguments: category.title, // for expensescreen.
            );
          },
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.grey[500]),
                      child: Center(
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(category.title,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        )),
                  ],
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'en_IN',
                    symbol: '₹',
                  ).format(category.totalAmount),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
