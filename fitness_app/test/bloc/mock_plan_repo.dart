class MockPlanRepository {
  // Simulates fetching a plan
  Future<String> fetchPlan(String userId) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    if (userId == 'validUserId') {
      return 'Mocked Split Data for $userId';
    } else {
      throw Exception('Failed to fetch plan');
    }
  }

  // Simulates updating a plan
  Future<String> updatePlan(String userId, String split) async {
    await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
    if (userId == 'validUserId') {
      return split;
    } else {
      throw Exception('Failed to update plan');
    }
  }
}
