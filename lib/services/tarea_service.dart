import 'dart:convert';
import 'dart:io' show Platform;

import 'package:estados_app/models/tarea.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Cliente REST de la API de tareas (ver carpeta `server/`).
class TareaService {
  TareaService({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? _defaultBaseUrl;

  final http.Client _client;
  final String _baseUrl;

  // El emulador de Android ve el host en 10.0.2.2.
  // Se puede sobreescribir con --dart-define=API_URL=http://IP:3000
  static String get _defaultBaseUrl {
    const fromEnv = String.fromEnvironment('API_URL');
    if (fromEnv.isNotEmpty) return fromEnv;
    if (!kIsWeb && Platform.isAndroid) return 'http://10.0.2.2:3000';
    return 'http://localhost:3000';
  }

  static const _headers = {'Content-Type': 'application/json'};

  Future<List<Tarea>> obtenerTareas() async {
    final res = await _client.get(Uri.parse('$_baseUrl/tareas'));
    _validar(res, 200);
    final lista = jsonDecode(res.body) as List<dynamic>;
    return lista
        .map((e) => Tarea.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Tarea> crearTarea(Tarea tarea) async {
    final res = await _client.post(
      Uri.parse('$_baseUrl/tareas'),
      headers: _headers,
      body: jsonEncode(tarea.toJson()),
    );
    _validar(res, 201);
    return Tarea.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  Future<Tarea> actualizarEstado(int id, bool terminada) async {
    final res = await _client.patch(
      Uri.parse('$_baseUrl/tareas/$id'),
      headers: _headers,
      body: jsonEncode({'terminada': terminada}),
    );
    _validar(res, 200);
    return Tarea.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  }

  void _validar(http.Response res, int esperado) {
    if (res.statusCode != esperado) {
      throw Exception('Error ${res.statusCode}: ${res.body}');
    }
  }
}
