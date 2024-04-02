import 'package:get/get.dart';
import 'package:weather/models/controllers/home_controller.dart';
import 'package:weather/models/controllers/region_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put<HomeController>(HomeController());
  }
}

class RegionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegionController>(() => RegionController());
  }
}
