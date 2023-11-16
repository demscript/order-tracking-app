import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_tracking/authentication/presentation/screens/authentication_screen.dart';
import 'package:order_tracking/navigation_screen.dart';
import 'package:order_tracking/order/presentation/screens/order_detail_screen.dart';
import 'package:order_tracking/order/presentation/screens/track_your_order_screen.dart';

class AppRoutes {
  static const String navScreen = '/navScreen';
  static const String authScreen = '/authScreen';
  static const String orderDetailScreen = '/orderDetailScreen';
  static const String trackOrderScreen = '/trackOrderScreen';

  static Map<String, Widget Function(BuildContext)> routes = {};

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return CupertinoPageRoute(builder: (context){
          return const AuthenticationScreen();
        });
        case navScreen:
        return CupertinoPageRoute(builder: (context){
          return const NavigationScreen();
        });
        case orderDetailScreen:
        return CupertinoPageRoute(builder: (context){
          return const OrderDetailScreen();
        });
        // case trackOrderScreen:
        // return CupertinoPageRoute(builder: (context){
        //   return const TrackYourOrderScreen();
        // });

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
