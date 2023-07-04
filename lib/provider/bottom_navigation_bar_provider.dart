import 'package:expert_app/screens/my_home/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:expert_app/screens/clients/clients_screen.dart';

class BottomState extends ChangeNotifier {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const DashBoard(),
    const ClientScreen(),
    //ExpertScreen(),
  ];
  int get selectedIndex => _selectedIndex;
  List<Widget> get widgetOptions => _widgetOptions;

  void onItemTapped(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
