import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
    static Future<List<dynamic>> fetchStations() async {
        final response = await http.get(
            Uri.parse('https://mesonet.climate.umt.edu/api/stations?type=json')
        );

        if (response.statusCode == 200) {
            return json.decode(response.body);
        } else {
            throw Exception('Failed to load data');
        }
    }
}

Future<Map<String, dynamic>> getForecast(double lat, double lon) async {
  final response = await http.get(
    Uri.parse("https://api.weather.gov/points/$lat,$lon")
  );
  if (response.statusCode == 200) {
      final initResp = json.decode(response.body);
      final forecastResp = await http.get(
        Uri.parse(initResp['properties']['forecast'])
      );

      if (forecastResp.statusCode == 200) {
        return json.decode(forecastResp.body);
      } else {
        throw Exception('Forecast API call failed with status code $response.statusCode');
      }
  } else {
    throw Exception('Forecast API call failed with status code $response.statusCode');
  }
}

void main() async {
    Map<String, dynamic> forecast = await getForecast(39.7456, -97.0892);
    print(forecast);
}