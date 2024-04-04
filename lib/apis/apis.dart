import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather/models/controllers/home_controller.dart';
import 'package:weather/models/geo.dart';
import 'package:weather/models/weather.dart';

const String apiKey = "";

final HomeController home = Get.find();

final _geoDio = Dio(
  BaseOptions(
      baseUrl: "https://geoapi.qweather.com/v2/city/lookup",
      responseType: ResponseType.json,
      receiveTimeout: const Duration(milliseconds: 4000),
      connectTimeout: const Duration(milliseconds: 4000),
      sendTimeout: const Duration(milliseconds: 4000),
      queryParameters: {"key": apiKey}),
)..interceptors.add(InterceptorsWrapper(
    onRequest: (req, handlers) {
      home.isLoading.value = PageStatus.loading;
      handlers.next(req);
    },
    onError: (exp, handler) {
      home.isLoading.value = PageStatus.error;
    },
    onResponse: (resp, handler) {
      home.isLoading.value = PageStatus.ok;
      if (kDebugMode) {
        print(resp.data);
        print(resp.data.runtimeType);
        print((resp.data as Map<String, dynamic>)["code"].runtimeType);
      }
      if (resp.data is Map &&
          (resp.data as Map<String, dynamic>)["code"] as String != "200") {
        handler.reject(
          DioException(
            requestOptions: resp.requestOptions,
            message: WeatherNow.parseStatusCode(
                (resp.data as Map<String, dynamic>)["code"]),
          ),
          true,
        );
      } else {
        handler.next(resp);
      }
    },
  ));

final _weaDio = Dio(
  BaseOptions(
      baseUrl: "https://devapi.qweather.com/v7/weather/",
      responseType: ResponseType.json,
      receiveTimeout: const Duration(milliseconds: 4000),
      connectTimeout: const Duration(milliseconds: 4000),
      sendTimeout: const Duration(milliseconds: 4000),
      queryParameters: {"key": apiKey}),
)..interceptors.add(InterceptorsWrapper(
    onRequest: (req, handlers) {
      home.isLoading.value = PageStatus.loading;
      handlers.next(req);
    },
    onError: (exp, handler) {
      home.isLoading.value = PageStatus.error;
    },
    onResponse: (resp, handler) {
      home.isLoading.value = PageStatus.ok;
      if (kDebugMode) {
        print(resp.data);
      }
      if (resp.data is Map &&
          (resp.data as Map<String, dynamic>)["code"] as String != "200") {
        handler.reject(
          DioException(
            requestOptions: resp.requestOptions,
            message: WeatherNow.parseStatusCode(
                (resp.data as Map<String, dynamic>)["code"]),
          ),
          true,
        );
      } else {
        handler.next(resp);
      }
    },
  ));

Future<Geo> lookUpGeo(String query) async {
  final resp = await _geoDio.get("", queryParameters: {"location": query});
  return Geo.fromJson(resp.data);
}

Future<Map<String, dynamic>> getWeatherNow(String id) async {
  final resp = await _weaDio.get("now", queryParameters: {"location": id});
  return resp.data;
}

Future<Map<String, dynamic>> getWeatherHourly(String id,
    {String interval = "24"}) async {
  final resp =
      await _weaDio.get("${interval}h", queryParameters: {"location": id});
  return resp.data;
}

Future<Map<String, dynamic>> getWeatherDaily(String id,
    {String interval = "7"}) async {
  final resp =
      await _weaDio.get("${interval}d", queryParameters: {"location": id});
  return resp.data;
}

Future<String> queryLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  final p = await Geolocator.getCurrentPosition();
  if (kDebugMode) {
    print(p.longitude);
  }
  if (kDebugMode) {
    print(p.latitude);
  }
  return "${p.longitude.toStringAsFixed(2)},${p.latitude.toStringAsFixed(2)}";
}
