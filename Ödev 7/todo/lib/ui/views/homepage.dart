import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler/data/entity/task.dart';
import 'package:kisiler/ui/cubit/homepage_cubit.dart';
import 'package:kisiler/ui/views/add_task_page.dart';
import 'package:kisiler/ui/views/edit_task_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().uploadToDos();
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            ? TextField(
                decoration: InputDecoration(
                  hintText: d.search,
                ),
                onChanged: (value) {
                  context.read<HomePageCubit>().search(value);
                },
              )
            : Text(d.app_name),
        actions: [
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                  icon: const Icon(Icons.close))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = true;
                    });
                  },
                  icon: const Icon(Icons.search))
        ],
      ),
      body: BlocBuilder<HomePageCubit, List<Task>>(
        builder: (context, taskLists) {
          if (taskLists.isNotEmpty) {
            return ListView.builder(
              itemCount: taskLists.length,
              itemBuilder: (context, index) {
                var task = taskLists[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTaskPage(
                          task: task,
                        ),
                      ),
                    ).then((value) {
                      context.read<HomePageCubit>().uploadToDos();
                    });
                  },
                  child: Card(
                    child: SizedBox(
                      height: height / 8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(task.task),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("${task.task} ${d.deleted}"),
                                  action: SnackBarAction(
                                    label: d.yes,
                                    onPressed: () {
                                      context
                                          .read<HomePageCubit>()
                                          .deleteTask(task.id);
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(d.empty),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTaskPage(),
              )).then((value) {
            context.read<HomePageCubit>().uploadToDos();
          });
        },
      ),
    );
  }
}
