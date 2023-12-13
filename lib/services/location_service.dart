import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class LocationService {
  final String key = 'AIzaSyDVmWA_B1R1eetTVJp_pMzfG6HCIT2S9is';

  Future<String> getPlaceId(String input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var placeId = json['candidates'][0]['place_id'] as String;

    print(placeId);
    return placeId;
  }

  Future<Map<String, dynamic>> getPlace(String input) async {
    try {
      final placeId = await getPlaceId(input);
      final String url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var json = convert.jsonDecode(response.body);
        var results = json['result'] as Map<String, dynamic>;

        print(results);
        return results;
      } else {
        print("API Request failed with status code: ${response.statusCode}");
        return {};
      }
    } catch (e, stackTrace) {
      print("Error in getPlace: $e");
      print(stackTrace);
      return {};
    }
  }

   Future<Map<String, dynamic>> getDirections(
      String destination, double lat, double lang) async {
    String userLocal = '$lat,$lang'; // Değişiklik burada
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$userLocal&destination=$destination&key=$key';

    print(url);

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
      'distance_text': json['routes'][0]['legs'][0]['distance']['text'],
      'distance_value': json['routes'][0]['legs'][0]['distance']['value'],
    };
    print("Distance: ${results['distance_text']}");

    // Mesafe sayısal değer olarak (metre cinsinden)
    print("Distance Value: ${results['distance_value']}");

    double distance =
        double.parse(results['distance_value'].toString()) / 1000.0;
    double costPerKilometer = 19.0;
    results['cost'] = distance * costPerKilometer;

    print("Distance: ${results['distance_text']}");
    print("Cost: ${results['cost']} TL");
    print(results);
    return results;
  }
}
