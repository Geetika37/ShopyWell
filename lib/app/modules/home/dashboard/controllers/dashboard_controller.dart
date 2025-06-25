import 'package:get/get.dart';

class DashboardController extends GetxController {
  var currentPage = 0.obs;
  final categories = [
    {'name': 'Beauty', 'image': 'https://picsum.photos/200/300?random=1'},
    {'name': 'Fashion', 'image': 'https://picsum.photos/200/300?random=2'},
    {'name': 'Kids', 'image': 'https://picsum.photos/200/300?random=3'},
    {'name': 'Mens', 'image': 'https://picsum.photos/200/300?random=4'},
    {'name': 'Womens', 'image': 'https://picsum.photos/200/300?random=5'},
  ];

  final carouselImages = [
    'https://picsum.photos/800/400?random=1',
    'https://picsum.photos/800/400?random=2',
    'https://picsum.photos/800/400?random=3',
  ];

  final dealProducts = [
    {
      'title': 'Women Printed Kurta',
      'subtitle': 'Neque porro quisquam est qui dolorem ipsum quia',
      'price': '1500',
      'originalPrice': '2499',
      'discount': '40%OFF',
      'rating': 4.0,
      'reviews': 56890,
      'image': 'https://picsum.photos/200/300?random=6',
    },
    {
      'title': 'HRX by Hrithik Roshan',
      'subtitle': 'Neque porro quisquam est qui dolorem ipsum quia',
      'price': '2499',
      'originalPrice': '4999',
      'discount': '50%OFF',
      'rating': 4.5,
      'reviews': 344567,
      'image': 'https://picsum.photos/200/300?random=7',
    },
  ];
}
