import 'dart:math';
import 'package:expense_app/screens/notify.dart';
import 'package:flutter_animation_set/animation_set.dart';
import 'package:expense_app/models/expence_sort.dart';
import 'package:expense_app/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../../models/database_provider.dart';

class ExpenceCard extends StatefulWidget {
  const ExpenceCard({Key? key}) : super(key: key);

  @override
  State<ExpenceCard> createState() => _ExpenceCardState();
}

class _ExpenceCardState extends State<ExpenceCard>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.exp_cat;
      var total = db.calculateTotalExpenses();
      return SafeArea(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //? here is the welcoming activity
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Welcome Back!',
                            style: Theme.of(context).textTheme.headlineMedium),
                        Text(
                          'Shujaat Sunasara!',
                          style: Theme.of(context).textTheme.displayMedium,
                        )
                      ]),
                ),

                //? here is the notify icon

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.11,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const notify(),
                              type: PageTransitionType.fade));
                    },
                    child: Icon(
                      Icons.notifications,
                      color: xgreyer,
                    ),
                  ),
                ),
              ],
            ),
            //! this is the crd widget for the xpences!

            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      offset: Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('E X P E N S E',
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 16)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                      '${NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(total)}',
                      style: TextStyle(color: xgreyer, fontSize: 38),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: list
                                .where((e) => e.totalAmount > 0)
                                .map(
                                  (e) => AnimatedBuilder(
                                    animation: const AlwaysStoppedAnimation(0),
                                    builder: (_, __) =>
                                        TweenAnimationBuilder<Color?>(
                                      tween: ColorTween(
                                        begin: Colors.grey,
                                        end: Colors.primaries[list.indexOf(e)],
                                      ),
                                      duration: Duration(
                                        milliseconds: 3000,
                                      ),
                                      builder: (context, color, child) {
                                        return Row(
                                          children: [
                                            Container(
                                              height: 5,
                                              width: 5,
                                              decoration: BoxDecoration(
                                                color: color,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                            ),
                                            const SizedBox(width: 3.0),
                                            Icon(
                                              e.icon,
                                              color: xText,
                                            ),
                                            const SizedBox(width: 3.0),
                                            Text(
                                              total == 0
                                                  ? '0%'
                                                  : '${((e.totalAmount / total) * 100).toStringAsFixed(2)}%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                            const SizedBox(width: 10.0),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
