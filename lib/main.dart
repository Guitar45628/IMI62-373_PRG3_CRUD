import 'package:flutter/material.dart';
import 'package:test_crud/config.dart';
import 'package:test_crud/models/users.dart';
import 'package:test_crud/screens/home.dart';
import 'package:test_crud/screens/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green, // เปลี่ยนเป็น Colors.green
        primaryColor: Colors.green, // เปลี่ยนเป็น Colors.green
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const Login(),
      },
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = '...';
    String accountEmail = '...';
    Users user = Configure.login;
    var accountUrl = "";
    print(user.toJson().toString());
    if (user.id != null) {
      accountName = user.fullname!;
      accountEmail = user.email!;
      accountUrl =
          'https://cdn-icons-png.flaticon.com/256/11920/11920698.png';
    }
    return Drawer(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        UserAccountsDrawerHeader(
          accountName: Text(accountName),
          accountEmail: Text(accountEmail),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(accountUrl),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.pushNamed(context, Home.routeName);
          },
        ),
        ListTile(
          leading: const Icon(Icons.login),
          title: const Text("Login"),
          onTap: () {
            Navigator.pushNamed(context, Login.routeName);
          },
        )
      ],
    ));
  }
}
