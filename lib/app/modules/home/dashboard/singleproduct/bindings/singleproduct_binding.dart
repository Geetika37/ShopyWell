import 'package:get/get.dart';

import '../controllers/singleproduct_controller.dart';

class SingleproductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleproductController>(
      () => SingleproductController(),
    );
  }
}
