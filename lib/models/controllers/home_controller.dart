import 'package:get/get.dart';
import 'package:weather/apis/apis.dart';
import 'package:weather/models/weather.dart';

enum PageStatus {
  error,
  loading,
  ok,
}

class HomeController extends GetxController {
  HomeController({String id = ""}) {
    currentRegionId = "".obs;
  }
  Rx<WeatherNow> weaNow = WeatherNow(code: "0").obs;
  Rx<WeatherHour> weaHour = WeatherHour(code: "0").obs;
  Rx<WeatherDaily> weaDaily = WeatherDaily().obs;
  Rx<String> currentRegionName = "".obs;
  Rx<String> currentRegionId = "".obs;
  Rx<PageStatus> isLoading = PageStatus.ok.obs;

  Future<void> updateWeather() async {
    if (currentRegionId.value.isEmpty) return;
    await getWeatherNow(currentRegionId.value)
        .then((v) => updateWeatherNow = v);
    await getWeatherHourly(currentRegionId.value)
        .then((v) => updateWeatherHour = v);
    await getWeatherDaily(currentRegionId.value)
        .then((v) => updateWeatherDaily = v);
  }

  set updateWeatherNow(Map<String, dynamic> wea) {
    weaNow.value = WeatherNow.fromJson(wea);
  }

  set updateWeatherHour(Map<String, dynamic> wea) {
    weaHour.value = WeatherHour.fromJson(wea);
  }

  set updateWeatherDaily(Map<String, dynamic> wea) {
    weaDaily.value = WeatherDaily.fromJson(wea);
  }

  set updateCurrentRegionName(String n) {
    currentRegionName.value = n;
  }

  set updateCurrentRegionId(String n) {
    currentRegionId.value = n;
  }

  String get obsTime {
    if (weaNow.value.now == null) {
      return "-";
    }
    final DateTime dateTime = DateTime.parse(weaNow.value.now!.obstime);
    return "${dateTime.month}/${dateTime.day} ${dateTime.hour}:${dateTime.minute}";
  }

  String getFxTime(String t) {
    final DateTime dateTime = DateTime.parse(t);
    return "${dateTime.hour}:${dateTime.minute}";
  }
}
