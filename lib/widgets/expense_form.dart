import 'package:expense_app/theme.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/database_provider.dart';
import '../constants/icons.dart';
import '../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _date;
  String _initialValue = 'Other';
  _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blueGrey,
              primaryColorDark: Colors.blueGrey,
              accentColor: Colors.blueGrey,
            ),
            dialogBackgroundColor: Colors.white,
            // You can also customize other properties, such as text styles
            textTheme: TextTheme(
              headline6:
                  TextStyle(color: Colors.blue), // Change the title text color
              subtitle1:
                  TextStyle(color: Colors.orange), // Change the date text color
            ),
          ),
          child: child ?? Container(),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return Container(
      color: xGrey,
      height: MediaQuery.of(context).size.height * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * 0.008,
              width: MediaQuery.of(context).size.width * 0.2,
              decoration: BoxDecoration(
                  color: xgreyer, borderRadius: BorderRadius.circular(5)),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            //! title

            Text(
              'So on what did you Spent, ',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            TextField(
                controller: _title,
                cursorHeight: 20,
                cursorWidth: 1.5,
                cursorColor: xText,
                cursorRadius: const Radius.circular(1),
                decoration: InputDecoration(
                  label: Text('Expence', style: TextStyle(color: xgreyer)),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: xgreyer)),
                )),
            const SizedBox(height: 20.0),
            // amount
            TextField(
              controller: _amount,
              cursorHeight: 20,
              cursorWidth: 1.5,
              cursorColor: xText,
              cursorRadius: const Radius.circular(1),
              decoration: InputDecoration(
                  label: Text('Expence Amount \$',
                      style: TextStyle(color: xgreyer)),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: xgreyer))),
            ),
            const SizedBox(height: 20.0),
            // date picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    _date != null
                        ? DateFormat('MMMM dd, yyyy').format(_date!)
                        : 'Select Date  : ',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                IconButton(
                  onPressed: () => _pickDate(),
                  icon: Icon(
                    Icons.calendar_month,
                    color: xText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            // category
            Row(
              children: [
                Expanded(
                    child: Text(
                  'Category : ',
                  style: Theme.of(context).textTheme.displaySmall,
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    flex: 2,
                    child: Neumorphic(
                      style: NeumorphicStyle(color: Colors.grey.shade300),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 18, right: 18),
                        child: DropdownButton(
                          dropdownColor: Colors.grey.shade300,
                          alignment: Alignment.bottomCenter,
                          elevation: 12,
                          borderRadius: BorderRadius.circular(12),
                          items: icons.keys
                              .map(
                                (e) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.center,
                                  value: e,
                                  child: Text(
                                    e,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
                                  ),
                                ),
                              )
                              .toList(),
                          value: _initialValue,
                          onChanged: (newValue) {
                            setState(() {
                              _initialValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: NeumorphicButton(
                style: NeumorphicStyle(color: Colors.grey.shade300),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [const Icon(Icons.add)],
                ),
                onPressed: () {
                  if (_title.text != '' && _amount.text != '') {
                    // create an expense
                    final file = Expense(
                      id: 0,
                      title: _title.text,
                      amount: double.parse(_amount.text),
                      date: _date != null ? _date! : DateTime.now(),
                      category: _initialValue,
                    );
                    // add it to database.
                    provider.addExpense(file);
                    // close the bottomsheet
                    Navigator.of(context).pop();
                  } else if (_amount.text == null) {
                    AlertDialog(
                      elevation: 0,
                      backgroundColor: xGreyLight,
                      title: Text(
                        'please fill the Empty boxes ',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(12)),
                              intensity: 10,
                              depth: 2,
                              color: xGreyLight,
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              child: Text(
                                'Got-it',
                                style: GoogleFonts.poppins(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
