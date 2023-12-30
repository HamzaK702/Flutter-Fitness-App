import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/bloc/history/history_repository.dart';
import 'package:fitness_app/bloc/history/historyModel.dart';
import 'package:flutter/material.dart'; // Make sure this is imported

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository historyRepository;

  HistoryBloc(this.historyRepository) : super(HistoryInitial()) {
    on<HistoryRequested>(_onHistoryRequested);
    on<UpdateHistory>(_onUpdateHistory);
  }

  Future<void> _onHistoryRequested(HistoryRequested event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final history = await historyRepository.fetchHistory(event.userId);
      emit(HistorySuccess(history));
    } catch (e) {
      emit(HistoryFailure("Failed to fetch workout history: $e"));
    }
  }

  Future<void> _onUpdateHistory(UpdateHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      await historyRepository.updateHistory(event.userId, event.workoutName);
      // Optionally fetch the updated history after updating
      final updatedHistory = await historyRepository.fetchHistory(event.userId);
      emit(HistorySuccess(updatedHistory));
    } catch (e) {
      emit(HistoryFailure("Failed to update workout history: $e"));
    }
  }
}
