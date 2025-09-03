import 'package:flutter/material.dart';
import 'package:ihtesham_project/models/task.dart';
import 'package:ihtesham_project/provider/token.dart';
import 'package:ihtesham_project/services/task.dart';
import 'package:ihtesham_project/views/get_all_task.dart';
import 'package:provider/provider.dart';

class UpdateTaskView extends StatefulWidget {
  final Task model;

  const UpdateTaskView({super.key, required this.model});

  @override
  State<UpdateTaskView> createState() => _UpdateTaskViewState();
}

class _UpdateTaskViewState extends State<UpdateTaskView> {
  TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    descriptionController = TextEditingController(
      text: widget.model.description.toString(),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Update Task")),
      body: Column(
        children: [
          TextField(controller: descriptionController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (descriptionController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Description cannot be empty.")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await TaskServices()
                          .updateTask(
                            token: tokenProvider.getToken(),
                            description: descriptionController.text,
                            taskID: widget.model.id.toString(),
                          )
                          .then((val) {
                            isLoading = false;
                            setState(() {});
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Message"),
                                  content: Text(
                                    "Task has been updated successfully",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GetAllTaskView(),
                                          ),
                                        );
                                      },
                                      child: Text("Okay"),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Update Task"),
                ),
        ],
      ),
    );
  }
}
