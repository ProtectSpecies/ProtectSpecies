import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import '/screens/home/identify.dart';

Future<String> myAlertDialog(BuildContext context) {
  TextEditingController customController = TextEditingController();
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Thank you for taking steps to protect animals.' +
                ' Our artificial intelligence mechanism has detected the animal you photographed as a .',
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          content: TextFormField(
            controller: customController,
          ),
          actions: [
            MaterialButton(
                child: Text('No'),
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop();
                  selectedIndex2 = 1;
                }),
            MaterialButton(
                child: Text('Yes'),
                elevation: 5,
                onPressed: () {
                  Navigator.of(context).pop(customController.text.toString());
                  Navigator.of(context).pushReplacement(_createRoute());
                  selectedIndex2 = 1;
                }),
          ],
        );
      });
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MyHome(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
