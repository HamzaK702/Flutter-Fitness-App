import 'package:fitness_app/bloc/plan/plan_bloc.dart';
import 'package:fitness_app/bloc/plan/plan_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
 
import 'mock_plan_repo.dart';  

void main() {
  group('PlanBloc Test', () {
    late PlanBloc planBloc;
    late MockPlanRepository mockPlanRepository;

    setUp(() {
      mockPlanRepository = MockPlanRepository();
      planBloc = PlanBloc(mockPlanRepository as PlanRepository);
    });

    blocTest<PlanBloc, PlanState>(
      'emits [PlanLoading, PlanSuccess] when plan fetch is successful',
      build: () => planBloc,
      act: (bloc) => bloc.add(PlanRequested(id: 'validUserId')),
      expect: () => [PlanLoading(), isA<PlanSuccess>()],
    );

    blocTest<PlanBloc, PlanState>(
      'emits [PlanLoading, PlanFailure] when plan fetch fails',
      build: () => planBloc,
      act: (bloc) => bloc.add(PlanRequested(id: 'invalidUserId')),
      expect: () => [PlanLoading(), isA<PlanFailure>()],
    );

    tearDown(() async {
      await planBloc.close();
    });
  });
}
