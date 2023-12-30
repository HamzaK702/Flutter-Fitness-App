import 'package:fitness_app/bloc/yoga/yoga_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'mock_yoga_repo.dart';  

void main() {
  group('YogaBloc Test', () {
    late YogaBloc yogaBloc;
    late MockYogaRepository mockYogaRepository;

    setUp(() {
      mockYogaRepository = MockYogaRepository();
      yogaBloc = YogaBloc( mockYogaRepository);
    });

    blocTest<YogaBloc, YogaState>(
      'emits [YogaLoading, YogaLoadedState] when workout fetch is successful',
      build: () => yogaBloc,
      act: (bloc) => bloc.add(YogaRequested(Day: 'Monday')),
      wait: const Duration(seconds: 1),
      expect: () => [YogaLoading(), isA<YogaLoadedState>()],
    );

    blocTest<YogaBloc, YogaState>(
      'emits [YogaLoading, YogaErrorState] when workout fetch fails',
      build: () => yogaBloc,
      act: (bloc) => bloc.add(YogaRequested(Day: 'InvalidDay')),
      wait: const Duration(seconds: 1),
      expect: () => [YogaLoading(), isA<YogaErrorState>()],
    );

    tearDown(() async {
      await yogaBloc.close();
    });
  });
}
