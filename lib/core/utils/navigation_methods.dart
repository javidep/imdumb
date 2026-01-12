// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

extension NavigatorExtension on Navigator {
  static pushAndRemoveUntil(Widget widget, BuildContext context, {bool animation = true}) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget,
          transitionDuration: Duration(seconds: !animation ? 0 : 0),
        ),
        // PageRouteBuilder(
        //   builder: (BuildContext context) => widget,
        // ),
        (Route<dynamic> route) => false);
  }

  static Future<dynamic> push(Widget widget, BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
          body: widget,
        ),
      ),
    );
  }

  static Future<dynamic> pushReplacement(Widget widget, BuildContext context) async {
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Scaffold(
          body: widget,
        ),
      ),
    );
  }

  // static pushAndRemoveUntilState(Widget widget, NavigatorState state) {
  //   state.pushAndRemoveUntil(
  //       MaterialPageRoute(
  //         builder: (BuildContext context) => Scaffold(
  //           body: DoubleBackToCloseApp(
  //             snackBar: const SnackBar(
  //               content: Text('Toca de nuevo para salir'),
  //             ),
  //             child: widget,
  //           ),
  //         ),
  //       ),
  //       (Route<dynamic> route) => false);
  // }
}
