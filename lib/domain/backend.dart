import 'dart:convert';
import 'package:http/http.dart' as http;

const String backendUrl = "https://hackheroes25-advice.fly.dev"; // TODO

class TestPayload {
  final String userId;
  final List<int> closedAnswers;
  final List<String> openAnswers;

  TestPayload({
    required this.userId,
    required this.closedAnswers,
    required this.openAnswers,
  });

  factory TestPayload.fromJson(Map<String, dynamic> json) {
    return TestPayload(
      userId: json["user_id"] as String,
      closedAnswers: List<int>.from(json["closed_answers"] ?? []),
      openAnswers: List<String>.from(json["open_answers"] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "closed_answers": closedAnswers,
        "open_answers": openAnswers,
      };
}

Future<Map<String, dynamic>> submitPsychologyTest(TestPayload payload) async {
  final url = Uri.parse("$backendUrl/tests/psychology");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(payload.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception("Błąd: ${response.body}");
  }

  return jsonDecode(response.body);
}

Future<Map<String, dynamic>> submitVocationalTest(TestPayload payload) async {
  final url = Uri.parse("$backendUrl/tests/vocation");

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(payload.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception("Błąd: ${response.body}");
  }

  return jsonDecode(response.body);
}
