import 'package:get/get.dart';
import 'package:weather/models/controllers/daily_detail_controller.dart';
import 'package:weather/models/controllers/home_controller.dart';
import 'package:weather/models/controllers/region_controller.dart';
import 'package:weather/models/controllers/settings_controller.dart';

class RootBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put<HomeController>(HomeController());
    Get.put<SettingsController>(SettingsController());
  }
}

class RegionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegionController>(() => RegionController());
  }
}

class DailyDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DailyDetailController>(() => DailyDetailController());
  }
}
