import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler/ui/cubit/add_task_page_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  var tfTaskName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(d.add_task),
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
                    context.read<AddTaskPageCubit>().save(tfTaskName.text);
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(d.cannot_add_empty),
                      ),
                    );
                  }
                },
                child: Text(d.add),
              )
            ],
          ),
        ),
      ),
    );
  }
}
