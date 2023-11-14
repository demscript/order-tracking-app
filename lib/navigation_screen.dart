import 'package:flutter/material.dart';
import 'package:order_tracking/profile_screen.dart';
import 'package:order_tracking/utils/app_extension.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> screenOptions =[
    const Scaffold(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: Scaffold(
        body: screenOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            selectedItemColor: context.primaryColor,
            unselectedItemColor: context.themeData.shadowColor.withOpacity(0.6),
            unselectedLabelStyle: context.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              height: 0,
            ),
            selectedLabelStyle: context.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                height: 0,
                color: context.themeData.shadowColor.withOpacity(0.5)),
            selectedFontSize: 0,
            unselectedFontSize: 0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Order'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
