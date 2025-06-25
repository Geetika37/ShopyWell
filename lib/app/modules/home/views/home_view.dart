import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:shopywell/app/core/constants/app_color.dart';
import 'package:shopywell/app/core/constants/app_images.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      final initialIndex = args['initialIndex'] as int?;
      if (initialIndex != null) {
        controller.selectedIndex = initialIndex;
      }
    }

    return Scaffold(
      body: Material(
        color: Colors.transparent,
        child: Obx(() => controller.pages[controller.selectedIndex]),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(10),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, -2), // Shadow above the bar
              ),
            ],
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: controller.onItemTapped,
              backgroundColor: AppColors.white,
              elevation: 2,
              enableFeedback: false,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: Get.textTheme.bodyMedium?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: Get.textTheme.bodyMedium?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
              selectedItemColor: Colors.red,
              unselectedItemColor: AppColors.black,
              type: BottomNavigationBarType.fixed,
              items: _buildNavigationBarItems(),
            ),
          ),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildNavigationBarItems() {
    return [
      _buildNavigationBarItem(
        selectedImage: Appimages.bottombar1,
        // unselectedImage: Appimages.homdeunselected,
        index: 0,
        label: 'Home',
      ),
      _buildNavigationBarItem(
        selectedImage: Appimages.bottombar2,
        // unselectedImage: Appimages.wishlistunselected,
        index: 1,
        label: 'Wishlist',
      ),
      _buildNavigationBarItem(
        selectedImage: Appimages.bottombar3,
        // unselectedImage: Appimages.cartunselected,
        index: 2,
        label: 'Cart',
      ),
      _buildNavigationBarItem(
        selectedImage: Appimages.bottombar4,
        // unselectedImage: Appimages.searchunselected,
        index: 3,
        label: 'Search',
      ),
      _buildNavigationBarItem(
        selectedImage: Appimages.bottombar5,
        // unselectedImage: Appimages.settingunselected,
        index: 4,
        label: 'Setting',
      ),
    ];
  }

  BottomNavigationBarItem _buildNavigationBarItem({
    required String selectedImage,
    // required String unselectedImage,
    required String label,
    required int index,
  }) {
    final bool isSelected = controller.selectedIndex == index;

    // Special design for cart icon (index 2)
    if (index == 2) {
      return BottomNavigationBarItem(
        icon: Transform.translate(
          offset: Offset(0, -10),
          child: Container(
            width: 80,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected ? Colors.red : AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                selectedImage,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : AppColors.black,
                  BlendMode.srcIn,
                ),
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
        label: '',
      );
    }

    // Regular design for other icons
    return BottomNavigationBarItem(
      icon: SvgPicture.asset(
        selectedImage,
        colorFilter: ColorFilter.mode(
          isSelected ? Colors.red : AppColors.black,
          BlendMode.srcIn,
        ),
        width: 24,
        height: 24,
      ),
      label: label,
      
    );
  }
}
