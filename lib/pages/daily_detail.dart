import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/components/qw_icons.dart';
import 'package:weather/components/weather_icons.dart';
import 'package:weather/models/controllers/daily_detail_controller.dart';
import 'package:weather/models/controllers/home_controller.dart';
import 'package:weather/models/weather.dart';
import 'package:weather/widgets/temperature.dart';

class SingleDailyDetailPage extends StatelessWidget {
  const SingleDailyDetailPage({super.key, required this.days});
  final Daily days;
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ThemeData theme = Theme.of(context);
    Widget getIcon(IconData icon) => Icon(icon,
        color: theme.iconTheme.color, size: textTheme.titleLarge!.fontSize);
    Widget getTitle(String text) => Text(
          text,
          style: textTheme.titleMedium,
        );
    Widget getSubTitle(String text) => Text(
          text,
          style: textTheme.bodyLarge,
        );
    Widget getLabel(String text) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: textTheme.titleMedium,
            ),
          ),
        );
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                getLabel("白天"),
                ListTile(
                  leading: getIcon(QwIcons.parseCode(days.iconDay)),
                  title: Temperature(
                    days.tempMax!,
                    style: textTheme.titleMedium,
                  ),
                  subtitle: getSubTitle(days.textDay!),
                  isThreeLine: true,
                ),
                ListTile(
                  leading: getIcon(WeatherIcons.fengxiang),
                  title: getTitle(days.windDirDay!),
                  subtitle: getSubTitle("${days.wind360Day.toString()}度"),
                  isThreeLine: true,
                ),
                ListTile(
                  leading: getIcon(WeatherIcons.fengsu),
                  title: getTitle("风速"),
                  subtitle: getSubTitle("${days.windSpeedDay!}米/秒"),
                  isThreeLine: true,
                ),
                ListTile(
                  leading: getIcon(WeatherIcons.fengli),
                  title: getTitle("风力"),
                  subtitle: getSubTitle("${days.windScaleDay!}级"),
                  isThreeLine: true,
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                getLabel("夜晚"),
                ListTile(
                  leading: getIcon(QwIcons.parseCode(days.iconNight)),
                  title: Temperature(
                    days.tempMin!,
                    style: textTheme.titleMedium,
                  ),
                  subtitle: getSubTitle(days.textNight!),
                  isThreeLine: true,
                ),
                ListTile(
                  leading: getIcon(WeatherIcons.fengxiang),
                  title: getTitle(days.windDirNight!),
                  subtitle: getSubTitle("${days.wind360Night.toString()}度"),
                  isThreeLine: true,
                ),
                ListTile(
                  leading: getIcon(WeatherIcons.fengsu),
                  title: getTitle("风速"),
                  subtitle: getSubTitle("${days.windSpeedNight!}米/秒"),
                  isThreeLine: true,
                ),
                ListTile(
                  leading: getIcon(WeatherIcons.fengli),
                  title: getTitle("风力"),
                  subtitle: getSubTitle("${days.windScaleNight!}级"),
                  isThreeLine: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DailyDetailPage extends StatelessWidget {
  const DailyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final idx = Get.arguments;
    final controller = PageController(initialPage: idx);

    final HomeController home = Get.find();
    final DailyDetailController daily = Get.find();
    daily.updateSelectedPage = idx;
    final List<Daily?> days = home.weaDaily.value.daily!;
    daily.updateDate = home.getFxTime(days[idx]!.fxDate!, "M/d");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.backspace),
          onPressed: Get.back,
        ),
        title: Obx(() => Text(daily.date.value)),
        actions: [
          Obx(() => Text("${daily.selectedPage.value + 1}/${days.length}"))
        ],
      ),
      body: PageView.builder(
          controller: controller,
          itemCount: days.length,
          onPageChanged: (v) {
            daily.updateSelectedPage = v;
            daily.updateDate = home.getFxTime(days[v]!.fxDate!, "M/d");
          },
          itemBuilder: (ctx, id) {
            return SingleDailyDetailPage(days: days[id]!);
          }),
    );
  }
}
