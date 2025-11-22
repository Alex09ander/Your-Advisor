import 'package:your_advisor/domain/career_advice/career_advice_api.dart';

final class MockCareerAdviceApi implements CareerAdviceApi {
  @override
  Future<CareerAdvice> getAdvice(String userId, JobDemandPriority demandPriority) async {
    await Future.delayed(const Duration(seconds: 3));

    return const CareerAdvice("Business analyst");
  }
}
