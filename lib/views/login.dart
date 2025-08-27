import 'package:flutter/material.dart';
import 'package:ihtesham_project/provider/token.dart';
import 'package:ihtesham_project/provider/user.dart';
import 'package:ihtesham_project/services/auth.dart';
import 'package:ihtesham_project/views/get_all_task.dart';
import 'package:ihtesham_project/views/profile.dart';
import 'package:ihtesham_project/views/register.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var tokenProvider = Provider.of<TokenProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(controller: emailController),
          TextField(controller: pwdController),
          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    if (emailController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Email cannot be empty.")),
                      );
                      return;
                    }
                    if (pwdController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password cannot be empty.")),
                      );
                      return;
                    }
                    try {
                      isLoading = true;
                      setState(() {});
                      await AuthServices()
                          .loginUser(
                            email: emailController.text,
                            password: pwdController.text,
                          )
                          .then((val) async {
                            tokenProvider.setToken(val.token.toString());
                            await AuthServices()
                                .getProfile(val.token.toString())
                                .then((userModel) {
                                  isLoading = false;
                                  setState(() {});
                                  userProvider.setUser(userModel);
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Message"),
                                        content: Text("User has been loggedIn"),
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
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                  child: Text("Login"),
                ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterView()),
              );
            },
            child: Text("Go to Register"),
          ),
        ],
      ),
    );
  }
}
