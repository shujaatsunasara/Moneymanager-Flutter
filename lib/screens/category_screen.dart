import 'package:expense_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../widgets/category_screen/category_fetcher.dart';
import '../widgets/expense_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const name = '/category_screen'; // for routes
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //! This is the category function
      body: const CategoryFetcher(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: NeumorphicButton(
        style: NeumorphicStyle(
          color: xgreyer,
          boxShape: NeumorphicBoxShape.circle(),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            barrierColor: xGreyLight,
            builder: (_) => const ExpenseForm(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.add,
            color: xGreyLight,
            size: 20,
          ),
        ),
      ),
    );
  }
}
