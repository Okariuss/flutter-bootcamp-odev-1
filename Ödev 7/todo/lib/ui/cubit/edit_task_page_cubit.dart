import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler/data/repo/todo_dao_repository.dart';

class EditTaskPageCubit extends Cubit<void> {
  EditTaskPageCubit() : super(null);

  var tRepo = ToDoDaoRepository();

  Future<void> update(int id, String task) async {
    await tRepo.updateTask(id, task);
  }
}
