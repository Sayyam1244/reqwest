import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:reqwest/SRC/Data/Resources/constants.dart';

class GooglePlacesService {
  GooglePlacesService._privateConstructor();
  static GooglePlacesService instance =
      GooglePlacesService._privateConstructor();

  Future fetchCities(String input) async {
    log('Fetching cities for $input');
    const String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    final Map<String, String> params = {
      'input': input,
      'types': '(cities)',
      'key': AppConstants.GOOGLE_PLACES_KEY,
    };

    final uri = Uri.parse(url).replace(queryParameters: params);

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        log('Google Places API Response: $data');
        if (data['status'] == 'OK') {
          return (data['predictions'] as List)
              .map((prediction) =>
                  prediction['structured_formatting']['main_text'] as String)
              .toList();
        } else {
          return 'Error: ${data['status']}';
        }
      } else {
        return 'Failed to load cities';
      }
    } catch (e) {
      return 'Failed to load cities $e';
    }
  }
}
