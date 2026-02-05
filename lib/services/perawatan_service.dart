import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/perawatan_model.dart';
import '../responses/api_responses.dart';

class PerawatanService {
  static const String baseUrl =
      "http://10.0.2.2/api_perawatan/";

  static Future<List<PerawatanModel>> getAll() async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}perawatan_get_all.php"),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data
            .map((e) => PerawatanModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("ERROR GET ALL: $e");
      return [];
    }
  }

  static Future<bool> delete(String id) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}perawatan_delete.php"),
        body: {"id": id},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR DELETE: $e");
      return false;
    }
  }

  static Future<bool> create(Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}perawatan_create.php"),
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR CREATE: $e");
      return false;
    }
  }

  static Future<bool> update(Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}perawatan_update.php"),
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['status'] == true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR UPDATE: $e");
      return false;
    }
  }

  static Future<ApiResponse> createResponse(Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse("${baseUrl}perawatan_create.php"),
        body: body,
      );

      final data = json.decode(response.body);
      return ApiResponse.fromJson(data);
    } catch (e) {
      return ApiResponse(
        status: false,
        message: e.toString(),
      );
    }

  }

  // ================= SEARCH =================
  static Future<List<PerawatanModel>> search(String keyword) async {
    try {
      final response = await http.get(
        Uri.parse("${baseUrl}perawatan_search.php?keyword=$keyword"),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data
            .map((e) => PerawatanModel.fromJson(e))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("ERROR SEARCH: $e");
      return [];
    }
  }





}