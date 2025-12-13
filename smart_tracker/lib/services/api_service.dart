import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/bus.dart';

class ApiService {
  // YAHAN SABSE IMPORTANT PART:
  // Agar:
  // 1) Android Emulator use kar rahe ho (backend same PC pe):
  //    BASE_URL = 'http://10.0.2.2:5000'
  //
  // 2) iOS Simulator (Mac):
  //    BASE_URL = 'http://localhost:5000'
  //
  // 3) Real phone (WiFi se connected), backend same WiFi pe PC:
  //    BASE_URL = 'http://<PC ka IP>:5000'
  //    jaise: 'http://192.168.1.5:5000'
  //
  static const String baseUrl = 'http://localhost:5000'; // isko apne case ke hisaab se badlo

  static Future<List<Bus>> getBuses() async {
    final url = Uri.parse('$baseUrl/api/buses');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Bus.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load buses: ${response.statusCode}');
    }
  }
}