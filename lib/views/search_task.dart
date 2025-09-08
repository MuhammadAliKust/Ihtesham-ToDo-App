import 'package:flutter/material.dart';
import 'package:ihtesham_project/models/task.dart';
import 'package:ihtesham_project/provider/token.dart';
import 'package:ihtesham_project/provider/user.dart';
import 'package:ihtesham_project/services/task.dart';
import 'package:provider/provider.dart';

class SearchTaskView extends StatefulWidget {
  const SearchTaskView({super.key});

  @override
  State<SearchTaskView> createState() => _SearchTaskViewState();
}

class _SearchTaskViewState extends State<SearchTaskView> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  List<Task> taskList = [];

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Search Task")),
      body: Column(
        children: [
          TextField(controller: searchController),
          ElevatedButton(
            onPressed: () async {
              try {
                isLoading = true;
                setState(() {});
                await TaskServices()
                    .searchTask(
                      token: tokenProvider.getToken().toString(),
                      searchKey: searchController.text,
                    )
                    .then((val) {
                      isLoading = false;
                      taskList = val.tasks!;
                      setState(() {});
                    });
              } catch (e) {
                isLoading = false;
                setState(() {});
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              }
            },
            child: Text("Search Task"),
          ),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Icon(Icons.task),
                    title: Text(taskList[i].description.toString()),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
