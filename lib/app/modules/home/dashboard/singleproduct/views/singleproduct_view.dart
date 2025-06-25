import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:shopywell/app/core/constants/app_color.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../controllers/singleproduct_controller.dart';

class SingleproductView extends GetView<SingleproductController> {
  const SingleproductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: controller.goBack,
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            _buildImageSection(),

            const Gap(20),

            // Product Details Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Size Selection
                  _buildSizeSelection(),

                  const Gap(20),

                  // Product Name and Description
                  _buildProductInfo(),

                  const Gap(10),

                  // Rating and Reviews
                  _buildRatingSection(),

                  const Gap(15),

                  // Price Section
                  _buildPriceSection(),

                  const Gap(20),

                  // Product Description
                  _buildProductDescription(),

                  const Gap(30),

                  // Quantity and Action Buttons
                  _buildActionSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return Container(
      height: 300,
      child: Stack(
        children: [
          PageView.builder(
            onPageChanged: controller.changeImage,
            itemCount: controller.productImages.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    controller.productImages[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(
                            Icons.image,
                            size: 80,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Obx(
                () => SmoothPageIndicator(
                  controller: PageController(
                    initialPage: controller.currentImageIndex.value,
                  ),
                  count: controller.productImages.length,
                  effect: const WormEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.black,
                    dotColor: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSizeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size: ${controller.selectedSize.value}',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        Obx(
          () => Wrap(
            spacing: 10,
            children:
                controller.availableSizes.map((size) {
                  final isSelected = controller.selectedSize.value == size;
                  return GestureDetector(
                    onTap: () => controller.selectSize(size),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? AppColors.lightPinkColor
                                : Colors.white,
                        border: Border.all(
                          color:
                              isSelected
                                  ? AppColors.lightPinkColor
                                  : Colors.grey[300]!,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        size,
                        style: GoogleFonts.poppins(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            controller.productName.value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Gap(5),
        Obx(
          () => Text(
            controller.productDescription.value,
            style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600]),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection() {
    return Obx(
      () => Row(
        children: [
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < controller.rating.value.floor()
                    ? Icons.star
                    : Icons.star_border,
                color: Colors.orange,
                size: 16,
              );
            }),
          ),
          const Gap(5),
          Text(
            '${controller.reviewCount.value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection() {
    return Obx(
      () => Row(
        children: [
          Text(
            '₹${controller.discountedPrice.value.toInt()}',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Gap(10),
          Text(
            '₹${controller.originalPrice.value.toInt()}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.grey,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          const Gap(10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '${controller.discountPercentage.value}% OFF',
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Details',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const Gap(10),
        Text(
          'Perhaps the most iconic sneaker of all-time, this original "Chicago" colorway is the cornerstone to any sneaker collection. Made famous in 1985 by Michael Jordan, the shoe has stood the test of time, becoming the most famous colorway of the Air Jordan 1. This 2015 release saw the family colorway of the Air Jordan 1 release worldwide.',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection() {
    return Column(
      children: [
        // Quantity Section
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quantity',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Obx(
              () => Row(
                children: [
                  GestureDetector(
                    onTap: controller.decrementQuantity,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.remove, size: 16),
                    ),
                  ),
                  const Gap(15),
                  Text(
                    controller.quantity.value.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(15),
                  GestureDetector(
                    onTap: controller.incrementQuantity,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(Icons.add, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const Gap(30),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isAddingToCart.value
                          ? null
                          : controller.addToCart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      controller.isAddingToCart.value
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : Text(
                            'Add to Cart',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.isBuyingNow.value ? null : controller.buyNow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:
                      controller.isBuyingNow.value
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : Text(
                            'Buy Now',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
            ),
          ],
        ),

        const Gap(20),
      ],
    );
  }
}
