import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  void updateWeather() async {
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

  String getFxTime(String time, [String? format, String? local]) {
    final DateTime dateTime = DateTime.parse(time);
    return format == "EEEE"
        ? formatWeekAsChinese(DateFormat(format, local).format(dateTime))
        : DateFormat(format, local).format(dateTime);
  }

  String formatWeekAsChinese(String weekday) {
    Map<String, String> weekdayToChinese = {
      '星期一': '周一',
      '星期二': '周二',
      '星期三': '周三',
      '星期四': '周四',
      '星期五': '周五',
      '星期六': '周六',
      '星期日': '周日',
    };
    return weekdayToChinese[weekday] ?? weekday;
  }
}
