import 'package:fitness_app/bloc/start/start_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
 
import 'mock_start_repo.dart'; // Import your MockStartRepository

void main() {
  group('StartBloc Test', () {
    late StartBloc startBloc;
    late MockStartRepository mockStartRepository;

    setUp(() {
      mockStartRepository = MockStartRepository();
      startBloc = StartBloc(mockStartRepository);
    });

    blocTest<StartBloc, StartState>(
      'emits [StartLoading, StartLoadedState] when workout fetch is successful',
      build: () => startBloc,
      act: (bloc) => bloc.add(WorkoutRequested(Day: 'Monday')),
      wait: const Duration(seconds: 1),
      expect: () => [StartLoading(), isA<StartLoadedState>()],
    );

    blocTest<StartBloc, StartState>(
      'emits [StartLoading, StartErrorState] when workout fetch fails',
      build: () => startBloc,
      act: (bloc) => bloc.add(WorkoutRequested(Day: 'InvalidDay')),
      wait: const Duration(seconds: 1),
      expect: () => [StartLoading(), isA<StartErrorState>()],
    );

    tearDown(() async {
      await startBloc.close();
    });
  });
}
