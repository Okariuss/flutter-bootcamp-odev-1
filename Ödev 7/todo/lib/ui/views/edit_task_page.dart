// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler/data/entity/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/edit_task_page_cubit.dart';

class EditTaskPage extends StatefulWidget {
  final Task task;
  const EditTaskPage({
    required this.task,
  });

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  var tfTaskName = TextEditingController();

  @override
  void initState() {
    super.initState();
    var task = widget.task;
    tfTaskName.text = task.task;
  }

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(d.update_task),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: tfTaskName,
                decoration: InputDecoration(
                  hintText: d.task_name,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (tfTaskName.text.isNotEmpty) {
                    context
                        .read<EditTaskPageCubit>()
                        .update(widget.task.id, tfTaskName.text);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(d.cannot_update_empty),
                      ),
                    );
                  }
                },
                child: Text(d.update),
              )
            ],
          ),
        ),
      ),
    );
  }
}
