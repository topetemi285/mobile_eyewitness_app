import 'package:eyewitness_app/services/auth_services.dart';
import 'package:flutter/material.dart';

class WidgetProvider extends InheritedWidget {
  final AuthService auth;
  final db;
 

  WidgetProvider({Key key, Widget child, this.auth, this.db,}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static WidgetProvider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<WidgetProvider>());
}