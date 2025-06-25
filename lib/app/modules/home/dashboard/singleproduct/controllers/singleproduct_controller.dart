import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SingleproductController extends GetxController {
  // Product details
  final productName = 'Nike Sneakers'.obs;
  final productDescription = 'Vision Alta Men\'s Shoe Size (All Colours)'.obs;
  final rating = 4.5.obs;
  final reviewCount = 56890.obs;
  final originalPrice = 3000.0.obs;
  final discountedPrice = 1500.0.obs;
  final discountPercentage = 50.obs;

  // Available sizes
  final availableSizes = ['6 UK', '7 UK', '8 UK', '9 UK', '10 UK'].obs;
  final selectedSize = '7 UK'.obs;

  // Product images
  final currentImageIndex = 0.obs;
  final productImages =
      [
        'assets/img/onboarding-image1.png', // We'll use placeholder images
        'assets/img/onboarding-image2.png',
        'assets/img/onboarding-image3.png',
      ].obs;

  // Quantity
  final quantity = 1.obs;

  // Loading states
  final isAddingToCart = false.obs;
  final isBuyingNow = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Methods
  void selectSize(String size) {
    selectedSize.value = size;
  }

  void changeImage(int index) {
    currentImageIndex.value = index;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() async {
    isAddingToCart.value = true;
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    isAddingToCart.value = false;
    Get.snackbar(
      'Success',
      'Product added to cart!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void buyNow() async {
    isBuyingNow.value = true;
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    isBuyingNow.value = false;
    Get.snackbar(
      'Success',
      'Proceeding to checkout!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
  }

  void goBack() {
    Get.back();
  }
}
