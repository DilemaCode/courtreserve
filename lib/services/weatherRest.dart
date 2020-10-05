import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RestWeather {
  RestWeather._();
  static Future latlon(List geo) async {
    final response = await http.get(
      'http://api.openweathermap.org/data/2.5/weather?lat=${geo[0].toString()}&lon=${geo[1].toString()}&appid=72a2d60b0ea627a3080fa43030c717dc',
    );
    if (response.statusCode == 200) {
      Map data = Map.from(json.decode(response.body));
      return data['weather'][0]['description'];
    } else {
      throw Exception('error');
    }
  }
}
