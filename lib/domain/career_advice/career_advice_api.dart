abstract interface class CareerAdviceApi {
  Future<CareerAdvice> getAdvice(String userId, JobDemandPriority demandPriority);
}

enum JobDemand { veryLow, low, medium, high, veryHigh }

enum JobDemandPriority {
  none,
  current,
  in5years;

  int toInt() {
    return switch (this) {
      JobDemandPriority.none => 0,
      JobDemandPriority.current => 1,
      JobDemandPriority.in5years => 2
    };
  }
}

final class CareerAdvice {
  const CareerAdvice(this.jobs, this.scores, this.jobWithDemand, this.absoluteBestJob,
      this.fitsToDemand);

  final List<String> jobs;
  final List<double> scores;
  final String? jobWithDemand;
  final String absoluteBestJob;
  final List<String> fitsToDemand;

  static CareerAdvice fromJson(Map<String, dynamic> json) {
    return CareerAdvice(
      (json['jobs'] as List).map((e) => e.toString()).toList(),
      (json['scores'] as List).map((e) => (e as num).toDouble()).toList(),
      json['job_with_demand'] as String?,
      json['absolute_best_job'] as String,
      (json['fits_to_demand'] as List? ?? []).map((e) => e.toString()).toList(),
    );
  }
}
