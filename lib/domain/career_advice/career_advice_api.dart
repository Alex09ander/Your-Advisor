abstract interface class CareerAdviceApi {
  Future<CareerAdvice> getAdvice(String userId, JobDemandPriority demandPriority);
}

enum JobDemand { low, medium, high }

enum JobDemandPriority {
  none,
  currently,
  in5Years;

  int toInt() {
    return switch (this) {
      JobDemandPriority.none => 0,
      JobDemandPriority.currently => 1,
      JobDemandPriority.in5Years => 2
    };
  }
}

final class CareerAdvice {
  const CareerAdvice(this.bestJob);

  final String bestJob;

  static CareerAdvice fromJson(Map<String, dynamic> json) {
    return CareerAdvice(json["best_job"]);
  }
}
