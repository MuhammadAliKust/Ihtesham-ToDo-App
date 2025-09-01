import 'package:flutter/material.dart';
import 'package:ihtesham_project/models/task_listing.dart';
import 'package:ihtesham_project/provider/token.dart';
import 'package:ihtesham_project/services/task.dart';
import 'package:provider/provider.dart';

class GetInCompletedTaskView extends StatelessWidget {
  const GetInCompletedTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Get In Completed Task")),
      body: FutureProvider.value(
        value: TaskServices().getInCompletedTask(tokenProvider.getToken()),
        initialData: TaskListingModel(),
        builder: (context, child) {
          TaskListingModel taskListingModel = context.watch<TaskListingModel>();
          return taskListingModel.tasks == null
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
            itemCount: taskListingModel.tasks!.length,
            itemBuilder: (context, i) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(taskListingModel.tasks![i].description.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
