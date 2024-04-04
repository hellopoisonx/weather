import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/models/settings.dart';
import 'package:weather/widgets/temperature.dart';

class SettingsController extends GetxController {
  final Rx<Settings> settings = Settings().obs;

  late final SharedPreferences _prefs;

  Future<void> _pp(void Function() fun) async {
    fun();
    await loadSettings();
  }

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    settings.value.regionId = _prefs.getStringList("regionId");
    settings.value.temperatureUnit =
        parseNumToEnum(_prefs.getInt("temperatureUnit") ?? 0);
  }

  TemperatureUnit parseNumToEnum(int num) =>
      num == 0 ? TemperatureUnit.centigrade : TemperatureUnit.fahrenheit;

  int parseEnumToNum(TemperatureUnit unit) =>
      unit == TemperatureUnit.centigrade ? 0 : 1;

  set updateRegionId(List<String> ids) => _pp(() => _prefs.setStringList(
      "regionId", (_prefs.getStringList("regionId") ?? []) + ids));

  set upgradeTemperatureUnit(TemperatureUnit unit) =>
      _pp(() => _prefs.setInt("temperatureUnit", parseEnumToNum(unit)));
}
