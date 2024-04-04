import 'package:get/get.dart';

class DailyDetailController extends GetxController {
  Rx<int> selectedPage = 0.obs;
  Rx<String> date = "".obs;
  set updateSelectedPage(int n) => selectedPage.value = n;
  set updateDate(String n) => date.value = n;
}
