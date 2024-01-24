part of 'counter_bloc.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}

class InitialState extends CounterState {}

class UpdateState extends CounterState {
  final int counter;
  UpdateState(this.counter);
}
