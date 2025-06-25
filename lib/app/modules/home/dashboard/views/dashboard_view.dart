import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shopywell/app/core/constants/app_color.dart';
import 'package:shopywell/app/core/constants/app_images.dart';
import 'package:shopywell/app/routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
            child: Column(
              children: [
                /// Appbar
                _buildAppbar(),
                Gap(15),

                /// Search Bar
                _buildSearchBar(),
                Gap(20),

                /// Header All Featured
                _buildAllFeaturedHeader(),
                Gap(20),

                /// Category
                _buildCategoryList(),
                Gap(20),

                /// carousel
                _buildCarousel(),
                Gap(20),

                // Page indicators
                _buildIndicators(),
                Gap(20),

                /// Deal of the Day
                _buildDealOfTheDay(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.carouselImages.length,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: controller.currentPage.value == index ? 24 : 8,
            decoration: BoxDecoration(
              color:
                  controller.currentPage.value == index
                      ? AppColors.primaryColor
                      : AppColors.greyColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.search, color: Colors.grey, size: 24),
          ),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search any Product..',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
              onChanged: (value) {
                // Handle search
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.mic, color: Colors.grey, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Menu Icon
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: SvgPicture.asset(Appimages.homeMenu),
        ),

        // Logo
        Image.asset(Appimages.splashlogo, height: 40),

        // Profile Avatar
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE57373), Color(0xFF8E24AA)],
          ),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.network(
            'https://picsum.photos/200/300',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildAllFeaturedHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'All Featured',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        _buildFilters(text: 'Sort', icon: Icons.sort),
        Gap(10),
        _buildFilters(text: 'Filter', icon: Icons.filter_alt_outlined),
      ],
    );
  }

  Widget _buildFilters({required String text, required IconData icon}) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(text, style: TextStyle(fontSize: 14, color: Colors.black)),
          Gap(10),
          Icon(icon, color: Colors.black, size: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryList() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      height: 110,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == controller.categories.length - 1 ? 0 : 16,
            ),
            child: _buildCategoryItem(
              name: category['name']!,
              imageUrl: category['image']!,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem({required String name, required String imageUrl}) {
    return GestureDetector(
      onTap: () {
        // Handle category tap
      },
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(30),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.image, color: Colors.grey[400], size: 30),
                  );
                },
              ),
            ),
          ),
          const Gap(8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: PageView.builder(
        itemCount: controller.carouselImages.length,
        onPageChanged: (index) {
          controller.currentPage.value = index;
        },
        itemBuilder: (context, index) {
          final imageUrl = controller.carouselImages[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(50),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.image,
                        color: Colors.grey[400],
                        size: 50,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDealOfTheDay() {
    return Column(
      children: [
        // Header with countdown
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Deal of the Day',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 14,
                          ),
                          const Gap(4),
                          const Text(
                            '22h 55m 20s remaining',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'View all',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      const Gap(4),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Gap(16),
        // Product cards
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.dealProducts.length,
            itemBuilder: (context, index) {
              final product = controller.dealProducts[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.SINGLEPRODUCT);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index == controller.dealProducts.length - 1 ? 0 : 16,
                  ),
                  child: _buildProductCard(product),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(30),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Image.network(
                product['image'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: Icon(Icons.image, color: Colors.grey[400], size: 40),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(4),
                Text(
                  product['subtitle'],
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(8),
                Row(
                  children: [
                    Text(
                      '₹${product['price']}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(6),
                    Text(
                      '₹${product['originalPrice']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    Gap(6),
                    Text(
                      product['discount'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Gap(6),
                Row(
                  children: [
                    ...List.generate(5, (starIndex) {
                      return Icon(
                        starIndex < product['rating'].floor()
                            ? Icons.star
                            : Icons.star_border,
                        size: 14,
                        color: Colors.orange,
                      );
                    }),
                    Gap(6),
                    Text(
                      '${product['reviews']}',
                      style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
