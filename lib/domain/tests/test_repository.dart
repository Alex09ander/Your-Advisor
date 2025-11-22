import 'package:your_advisor/domain/backend.dart';

abstract interface class TestRepository {
  Future<TestPayload?> psychologyTest(String userId);
  Future<TestPayload?> vocationTest(String userId);
}
