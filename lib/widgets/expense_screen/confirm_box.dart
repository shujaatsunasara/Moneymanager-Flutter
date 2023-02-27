import 'package:expense_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../models/database_provider.dart';
import '../../models/expense.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({
    Key? key,
    required this.exp,
  }) : super(key: key);

  final Expense exp;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      elevation: 0,
      backgroundColor: xGreyLight,
      title: Text(
        'Surely delete ${exp.title} ?',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          NeumorphicButton(
            onPressed: () {
              Navigator.of(context).pop(false); // dont delete
            },
            style: NeumorphicStyle(
              intensity: 10,
              depth: 2,
              color: xGreyLight,
            ),
            child: Container(
              child: Text(
                'Go Back',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.05),
          NeumorphicButton(
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
              intensity: 10,
              shadowDarkColor: Colors.red,
              shadowLightColor: xwhite,
              depth: 2,
              color: xGreyLight,
            ),
            onPressed: () {
              Navigator.of(context).pop(true); // delete
              provider.deleteExpense(exp.id, exp.category, exp.amount);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text(
                'Delete',
                style: GoogleFonts.poppins(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
