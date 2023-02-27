import 'package:expense_app/theme.dart';
import 'package:flutter/material.dart';

class notify extends StatefulWidget {
  const notify({super.key});

  @override
  State<notify> createState() => _notifyState();
}

class _notifyState extends State<notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: xgreyer,
              size: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: xtrans,
          elevation: 0,
          title: Text(
            'Notificatoins',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        body: Center(
          child: Text(
            'You don\'t have any notifications yet',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ));
  }
}
