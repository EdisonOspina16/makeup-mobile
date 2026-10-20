import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies/models/makeup.dart';

class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

class MakeupService {
  final String baseUrl;

  MakeupService(this.baseUrl);

  Future<List<Makeup>> getMakeups() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((item) => Makeup.fromJson(item)).toList();
      }

      if (response.statusCode == 404) {
        throw const ApiException('No se encontraron los productos');
      }

      if (response.statusCode == 500) {
        throw const ApiException('Error en el servidor');
      }
      throw ApiException('Error HTTP ${response.statusCode}');
    } on http.ClientException {
      throw const ApiException('No se pudo conectar con el servidor');
    } on TimeoutException {
      throw const ApiException('El servidor tardó demasiado en responder');
    }
  }
}
