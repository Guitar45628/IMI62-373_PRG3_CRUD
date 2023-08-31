import 'package:flutter/material.dart';
import 'package:test_crud/models/users.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Users;

    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
              ListTile(
                title: Text("Name"),
                subtitle: Text("${user.fullname}"),
              ),
              ListTile(
                title: Text("Email"),
                subtitle: Text("${user.email}"),
              ),
              ListTile(
                title: Text("Gender"),
                subtitle: Text("${user.gender}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
