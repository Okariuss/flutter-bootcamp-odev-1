import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler/data/entity/task.dart';
import 'package:kisiler/data/repo/todo_dao_repository.dart';

class HomePageCubit extends Cubit<List<Task>> {
  HomePageCubit() : super(<Task>[]);

  var tRepo = ToDoDaoRepository();

  Future<void> uploadToDos() async {
    var list = await tRepo.uploadToDos();
    emit(list);
  }

  Future<void> search(String word) async {
    var list = await tRepo.search(word);
    emit(list);
  }

  Future<void> deleteTask(int taskId) async {
    await tRepo.deleteTask(taskId);
    uploadToDos();
  }
}
