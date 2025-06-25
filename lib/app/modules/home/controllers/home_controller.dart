import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/modules/home/dashboard/views/dashboard_view.dart';
import 'package:shopywell/app/modules/home/search/views/search_view.dart';
import 'package:shopywell/app/modules/home/setting/views/setting_view.dart';
import 'package:shopywell/app/modules/home/wishlist/views/wishlist_view.dart';

class HomeController extends GetxController {
  final RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;
  set selectedIndex(int value) => _selectedIndex.value = value;

  final List<Widget> pages = [
    DashboardView(),
    WishlistView(),
    // TODO: Replace with actual CartView when created
    Center(child: Text('Cart Page', style: TextStyle(fontSize: 24))),
    SearchView(),
    SettingView(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
  }
}
