import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/apis/apis.dart';
import 'package:weather/components/qw_icons.dart';
import 'package:weather/models/controllers/home_controller.dart';
import 'package:weather/widgets/temp_trend_chart.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController home = Get.find();
    queryLocation().then((value) {
      home.currentRegionId.value = value;
      home.updateWeather();
    });
    // init data
    return Scaffold(
      floatingActionButton: Obx(() => home.isLoading.value != PageStatus.ok
          ? FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () {
                home.updateWeather();
              },
              child: home.isLoading.value == PageStatus.loading
                  ? CircularProgressIndicator(
                      color: Theme.of(context)
                          .buttonTheme
                          .colorScheme
                          ?.primaryContainer)
                  : home.isLoading.value == PageStatus.error
                      ? Icon(
                          Icons.error,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme
                              ?.primaryContainer,
                        )
                      : null,
            )
          : const Text("")),
      body: Obx(() {
        final Widget topBar = SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
              (context, _) => InkWell(
                    onTap: () async {
                      final Set<String> region = await Get.toNamed("/region");
                      if (region.first.isNotEmpty && region.last.isNotEmpty) {
                        home.updateCurrentRegionName = region.first;
                        home.updateCurrentRegionId = region.last;
                        home.updateWeather();
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      height: 85,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Theme.of(context)
                            .colorScheme
                            .secondaryContainer
                            .withOpacity(0.1),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.location_on),
                          const SizedBox(width: 15),
                          Text(
                              home.currentRegionName.value.isNotEmpty
                                  ? home.currentRegionName.value
                                  : "请选择一个地区",
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                  ),
              childCount: 1),
          itemExtent: 85,
        );
        final Widget generalView = SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (context, index) => Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Container(
                        // 1
                        alignment: Alignment.centerLeft,
                        width: 120,
                        height: 130,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "观测时间:${home.obsTime}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary),
                                )),
                            Row(
                              children: [
                                Text(
                                  home.weaNow.value.now?.temp ?? "-",
                                  style: TextStyle(
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                const Icon(
                                  QwIcons.centigrade,
                                  size: 55,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "体感温度:${home.weaNow.value.now?.feelslike ?? "-"}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Icon(
                                  QwIcons.centigrade,
                                  size: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.fontSize,
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Container(
                        // 2
                        alignment: Alignment.centerRight,
                        width: 80,
                        height: 100,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              QwIcons.parseCode(home.weaNow.value.now?.icon),
                              size: 45,
                            ),
                            Text(
                              home.weaNow.value.now?.text ?? "-",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 0.1,
                  ),
                ],
              ),
            ),
            itemExtent: 150);
        final Widget hourView = SliverToBoxAdapter(
          child: (home.weaHour.value.hourly?.length ?? 0) <= 0
              ? const Text("")
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      color: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.2)),
                  height: 180,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: 800,
                      child: TempTrendChart(
                        items: home.weaHour.value.hourly!
                            .map(
                              (e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Column(
                                    children: [
                                      Text(
                                        home.getFxTime(e.fxtime),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Icon(
                                        QwIcons.parseCode(e.icon),
                                        size: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.fontSize,
                                      ),
                                      Row(children: [
                                        Text(
                                          e.temp,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                        ),
                                        Icon(
                                          QwIcons.centigrade,
                                          size: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.fontSize,
                                        ),
                                      ])
                                    ],
                                  )),
                            )
                            .toList(),
                        tempsMax: home.weaHour.value.hourly!
                            .map((e) => int.parse(e.temp))
                            .toList(),
                        colorMax: Colors.blue,
                      ),
                    ),
                  ),
                ),
        );
        final Widget dailyView = SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              color: Theme.of(context)
                  .colorScheme
                  .secondaryContainer
                  .withOpacity(0.1),
            ),
            height: 400,
            child: ListView.builder(
              itemCount: home.weaDaily.value.daily?.length,
              itemBuilder: (ctx, idx) => ListTile(
                leading: Text(
                  DateFormat("EEEE", "zh_CN").format(
                      DateTime.parse(home.weaDaily.value.daily![idx]!.fxDate!)),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                titleAlignment: ListTileTitleAlignment.center,
                title: Row(
                  children: [
                    const Spacer(),
                    Icon(
                        QwIcons.parseCode(
                            home.weaDaily.value.daily![idx]!.iconDay),
                        size:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                    Text("/", style: Theme.of(context).textTheme.titleMedium),
                    Icon(
                        QwIcons.parseCode(
                            home.weaDaily.value.daily![idx]!.iconNight),
                        size:
                            Theme.of(context).textTheme.titleMedium?.fontSize),
                    const Spacer(),
                    Text(
                      home.weaDaily.value.daily![idx]!.tempMin!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Icon(
                      QwIcons.centigrade,
                      size: Theme.of(context).textTheme.titleMedium?.fontSize,
                    ),
                    Text(
                      "/",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      home.weaDaily.value.daily![idx]!.tempMax!,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Icon(
                      QwIcons.centigrade,
                      size: Theme.of(context).textTheme.titleMedium?.fontSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        return RefreshIndicator(
            onRefresh: home.updateWeather,
            child: CustomScrollView(
              slivers: [
                topBar,
                generalView,
                hourView,
                dailyView,
              ],
            ));
      }),
    );
  }
}
