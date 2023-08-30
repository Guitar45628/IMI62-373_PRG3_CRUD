import 'package:flutter/material.dart';
import 'package:test_crud/screens/home.dart';
import 'package:test_crud/screens/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
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
    String accountName = 'Dechnarong Matham';
    String accountEmail = 'dechnarong45628@gmail.com';
    String accountUrl =
        'https://cdn-icons-png.flaticon.com/256/11920/11920698.png';
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
          leading: Icon(Icons.home),
          title: Text("Home"),
          onTap: () {
            Navigator.pushNamed(context, Home.routeName);
          },
        ),
        ListTile(
          leading: Icon(Icons.login),
          title: Text("Login"),
          onTap: () {
            Navigator.pushNamed(context, Login.routeName);
          },
        )
      ],
    ));
  }
}
