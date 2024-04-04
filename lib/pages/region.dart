import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/models/controllers/home_controller.dart';
import 'package:weather/models/controllers/region_controller.dart';

class RegionPage extends StatelessWidget {
  const RegionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegionController region = Get.find();
    final HomeController home = Get.find();
    region.updateCurrentRegionId = home.currentRegionId.value;
    region.updateCurrentRegionName = home.currentRegionName.value;
    return Obx(() {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(45),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                    onPressed: () => Get.back<Set<String>>(result: {
                          region.currentRegionName.value,
                          region.currentRegionId.value
                        }),
                    icon: const Icon(
                      Icons.backspace,
                      size: 15,
                    )),
              ),
              Expanded(
                child: TextField(
                  autofocus: true,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    hintText: region.query.value,
                  ),
                  onChanged: (v) => region.updateQuery = v,
                ),
              )
            ],
          ),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, idx) => InkWell(
            onTap: () {
              region.updateCurrentRegionName =
                  region.geoResults.value.location![idx].name;
              region.updateCurrentRegionId =
                  region.geoResults.value.location![idx].id;
              Get.back<Set<String>>(result: {
                region.currentRegionName.value,
                region.currentRegionId.value
              });
            },
            child: ListTile(
              title: Text(region.geoResults.value.location![idx].name),
              subtitle: Text(
                  "${region.geoResults.value.location![idx].adm1} ${region.geoResults.value.location![idx].adm2}"),
            ),
          ),
          itemCount: region.geoResults.value.location?.length ?? 0,
        ),
      );
    });
  }
}
