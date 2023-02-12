part of 'counter_cubit.dart';

class CounterState {
  CounterState({
    required this.counterValue,
    required this.wasIncremented,
     required this.wasDecremented,
     required this.themeChanged,
    });
  int counterValue;
  bool wasIncremented;
  bool wasDecremented;
  bool themeChanged;
}