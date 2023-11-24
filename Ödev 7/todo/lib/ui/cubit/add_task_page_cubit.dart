import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler/data/repo/todo_dao_repository.dart';

class AddTaskPageCubit extends Cubit<void> {
  AddTaskPageCubit() : super(null);

  var tRepo = ToDoDaoRepository();

  Future<void> save(String task) async {
    await tRepo.addTask(task);
  }
}
