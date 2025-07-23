import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';

class GetProfileView extends StatelessWidget {
  const GetProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Column(
        children: [

          Text(
            userProvider.getUser()!.user!.name.toString(),
            style: TextStyle(fontSize: 40),
          ),
          Text(
            userProvider.getUser()!.user!.email.toString(),
            style: TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
