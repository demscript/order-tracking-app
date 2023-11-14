import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splashScreen = '/splash';
  static const String signIn = '/signIn';

  static Map<String, Widget Function(BuildContext)> routes = {};

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case splashScreen:
      //   return CupertinoPageRoute(builder: (context){});

    // Default Route is error route
      default:
        return CupertinoPageRoute(
            builder: (context) => errorView(settings.name));
    }
  }

  static Widget errorView(String? name) {
    return Scaffold(body: Center(child: Text('404 $name View not found')));
  }
}


routeBuilder(Widget widget){
  return PageRouteBuilder(
    pageBuilder: (_, ani, ani1) => widget,
    transitionDuration: const Duration(seconds: 0),
  );
}
