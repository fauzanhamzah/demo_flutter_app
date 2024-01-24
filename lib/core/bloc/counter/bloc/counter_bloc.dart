import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int counter = 0;
  CounterBloc() : super(CounterInitial()) {
    on<IncrementEvent>(_onIncrement);
    on<DecrementEvent>(_onDecrement);
  }

  void _onIncrement(IncrementEvent event, Emitter<CounterState> emit) async {
    counter++;
    emit(UpdateState(counter));
  }

  void _onDecrement(DecrementEvent event, Emitter<CounterState> emit) async {
    if (counter > 0) {
      counter--;
      emit(UpdateState(counter));
    }
  }
}
