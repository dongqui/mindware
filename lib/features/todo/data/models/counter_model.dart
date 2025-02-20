import 'package:isar/isar.dart';

part 'counter_model.g.dart';

@collection
class CounterModel {
  Id id = Isar.autoIncrement;
  
  @Index()
  final DateTime date;
  final int todoId;
  int count;

  CounterModel({
    required this.date,
    required this.todoId,
    this.count = 0,
  });
} 