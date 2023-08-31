import 'package:flutter/material.dart';
import 'package:test_crud/config.dart';
import 'package:test_crud/main.dart';
import 'package:test_crud/models/users.dart';
import 'package:http/http.dart' as http;
import 'package:test_crud/screens/user_info.dart';
import 'package:test_crud/screens/userform.dart';

class Home extends StatefulWidget {
  static const routeName = "/";
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget mainBody = Container();

  @override
  void initState() {
    super.initState();
    Users user = Configure.login;
    if (user.id != null) {
      getUser();
    }
  }

  List<Users> _userList = [];

  Future<void> getUser() async {
    var url = Uri.http(Configure.server, "users");
    var resp = await http.get(url);
    setState(() {
      _userList = usersFromJson(resp.body);
      mainBody = showUsers();
    });
    return;
  }

  Future<void> removeUsers(user) async {
    var url = Uri.http(Configure.server, "users/${user.id}");
    var res = await http.delete(url);
    print(res.body);
    _userList.remove(user); // Remove from the list
    setState(() {});
    return;
  }

  Future<bool> showDeleteConfirmationDialog(user) async {
    return await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from being dismissed
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this user?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm
              },
              child: const Text("Delete"),
            ),
            FilledButton.tonal(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 5,
      ),
      drawer: const SideMenu(),
      body: mainBody,
      floatingActionButton:
          FloatingActionButton(child: const Icon(Icons.add), onPressed: () async {
            String result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => const UserForm(),));
              if(result == "refresh"){
                getUser();
              }
          }),
    );
  }

  Widget showUsers() {
    return ListView.builder(
      itemCount: _userList.length,
      itemBuilder: (context, index) {
        Users user = _userList[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) async {
            bool confirmed = await showDeleteConfirmationDialog(user);
            if (confirmed) {
              removeUsers(user);
            } else {
              // Reinsert the dismissed item back into the list
              setState(() {
                getUser();
              });
            }
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            title: Text("${user.fullname}"),
            subtitle: Text("${user.email}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserInfo(),
                  settings: RouteSettings(arguments: user),
                ),
              );
            },
            trailing: IconButton(
              onPressed: () async {
                String result = await Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => const UserForm(),
                settings: RouteSettings(
                  arguments: user
                  )));
                if(result == "refresh"){
                  getUser();
                }
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        );
      },
    );
  }

}
