import 'dart:convert';

import 'package:your_advisor/domain/backend.dart';
import 'package:your_advisor/domain/tests/test_repository.dart';
import 'package:http/http.dart' as http;

final class BackendTestsRepository implements TestRepository {
  @override
  Future<TestPayload?> psychologyTest(String userId) async {
    final url = Uri.parse("$backendUrl/tests/psychology?user_id=$userId");

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 404 && response.body.contains("Test not found")) {
      return null;
    } else if (response.statusCode != 200) {
      throw Exception("Błąd: ${response.body}");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return TestPayload.fromJson(data);
  }

  @override
  Future<TestPayload?> vocationTest(String userId) async {
    final url = Uri.parse("$backendUrl/tests/vocation?user_id=$userId");

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 404 && response.body.contains("Test not found")) {
      return null;
    } else if (response.statusCode != 200) {
      throw Exception("Błąd: ${response.body}");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return TestPayload.fromJson(data);
  }
}
