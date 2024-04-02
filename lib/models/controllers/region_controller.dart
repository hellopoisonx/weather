import 'package:get/get.dart';
import 'package:weather/apis/apis.dart';
import 'package:weather/models/geo.dart';

class RegionController extends GetxController {
  Rx<String> query = "".obs;
  Rx<Geo> geoResults = Geo(code: "0").obs;
  Rx<String> currentRegionName = "".obs;
  Rx<String> currentRegionId = "".obs;

  set updateQuery(String n) {
    query.value = n;
    lookUpGeo(query.value).then((g) => geoResults.value = g);
  }

  set updateCurrentRegionName(String n) {
    currentRegionName.value = n;
  }

  set updateCurrentRegionId(String n) {
    currentRegionId.value = n;
  }
}
