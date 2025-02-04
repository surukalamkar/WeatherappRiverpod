// weather_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather_ModelClass.dart'; // Import your model

final weatherProvider =
    FutureProvider.family<WeatherModel, String>((ref, location) async {
  Uri url = Uri.parse(
      "https://api.weatherapi.com/v1/current.json?key=580857fd9d414dd5a4b132050241609&q=$location");

  final http.Response response = await http.get(url);

  var responseData = json.decode(response.body);
  return WeatherModel.fromJson(responseData);
});




// void getWeatherData() async {
//     setState(() {
//       isLoading = true;
//     });
//     Uri url = Uri.parse(
//         "https://api.weatherapi.com/v1/current.json?key=580857fd9d414dd5a4b132050241609&q=$location");
//     http.Response response = await http.get(url);

//     var responseData = json.decode(response.body);

//     WeatherModel weatherModel = WeatherModel.fromJson(responseData);
//     setState(() {
//       locationData = weatherModel.location?.toJson() as Map<String, dynamic>;
//       currentData = weatherModel.current?.toJson() as Map<String, dynamic>;
//       isLoading = false;
//     });
//   }


// api_provider.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'model.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// // Create a provider that fetches data from the API
// final apiProvider = FutureProvider<ApiResponse>((ref) async {
//   final response = await http.get(Uri.parse('https://api.example.com/data'));

//   if (response.statusCode == 200) {
//     // If the server returns a 200 OK response, parse the JSON
//     return ApiResponse.fromJson(jsonDecode(response.body));
//   } else {
//     throw Exception('Failed to load data');
//   }
// });
