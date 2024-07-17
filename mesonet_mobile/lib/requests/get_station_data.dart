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