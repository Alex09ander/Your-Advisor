import 'dart:convert';

import 'package:your_advisor/domain/backend.dart';
import 'package:your_advisor/domain/career_advice/career_advice_api.dart';
import 'package:http/http.dart' as http;

final class BackendCareerAdviceApi implements CareerAdviceApi {
  @override
  Future<CareerAdvice> getAdvice(String userId, JobDemandPriority demandPriority) async {
    final demandString = switch (demandPriority.name) {
      "none" => null,
      _ => demandPriority.name,
    };

    final query = {
      "user_id": userId,
      "wpep_mode": demandPriority.toInt().toString(),
      if (demandString != null) "demand": demandString,
    };

    final url = Uri.parse(backendUrl)
        .replace(path: "/career_adviser/advice", queryParameters: query);

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw Exception("Błąd: ${response.body}");
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return CareerAdvice.fromJson(data);
  }
}
