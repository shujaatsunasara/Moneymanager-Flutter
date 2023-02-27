import 'package:expense_app/models/expence_sort.dart';
import 'package:expense_app/widgets/category_screen/category_fetcher.dart';
import 'package:expense_app/widgets/category_screen/total_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/database_provider.dart';
import './category_card.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (_, db, __) {
        // get the exp_cat
        var list = db.exp_cat;
        return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (_, i) => CategoryCard(list[i]));
      },
    );
  }
}
