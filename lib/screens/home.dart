import 'package:flutter/material.dart';
import 'package:test_crud/config.dart';
import 'package:test_crud/main.dart';
import 'package:test_crud/models/users.dart';
import 'package:http/http.dart' as http;

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
    // TODO: implement initState
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: SideMenu(),
      body: mainBody,
    );
  }

  Widget showUsers() {
    return ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          Users user = _userList[index];
          return Card(
            child: Dismissible(
            key: UniqueKey(),
            child: ListTile(
              title: Text("${user.name}"),
              subtitle: Text("${user.email}"),
              onTap: () {},
              trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
              ),
            ),
            onDismissed: (direction) {},
            background: Container(
              color: Colors.red,
              margin: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.centerRight,
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),
          );
        });
  }
}
