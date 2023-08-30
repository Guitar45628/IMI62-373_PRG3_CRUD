import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:http/http.dart' as http;
import 'package:test_crud/models/users.dart';
import 'package:test_crud/screens/home.dart';

import '../config.dart';
import '../main.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  Future<void> login(Users user) async {
    var params = {"email": user.email, "password": user.password};
    var url = Uri.http(Configure.server, "users", params);
    var resp = await http.get(url);
    print("This is " + resp.body);
    List<Users> login_result = usersFromJson(resp.body);
    // print(login_result.length);
    if (login_result.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email or Password is invalid!")));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
            key: _formkey,
            child: Column(
              children: [
                // textHeader(),
                emailInputField(),
                passwordInputField(),
                const SizedBox(height: 10),
                Row(
                  children: [
                    submitButton(),
                    const SizedBox(
                      width: 10,
                    ),
                    registerLink()
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: "dechnarong45628@gmail.com",
      decoration: const InputDecoration(
        labelText: "Email",
        icon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an email';
        }
        if (!EmailValidator.validate(value)) {
          return 'Please enter a valid email';
        }
        return null; // ถ้าผ่านเงื่อนไขทั้งหมด
      },
      onSaved: (newValue) => user.email = newValue,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: "00000000",
      obscureText: true,
      decoration:
          const InputDecoration(labelText: "Password:", icon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a password';
        }
        return null; // ถ้าผ่านเงื่อนไขทั้งหมด
      },
      onSaved: (newValue) => user.password = newValue,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          login(user);
        }
      },
      child: const Text("Login"),
    );
  }

  Widget registerLink() {
    return OutlinedButton(
      child: const Text("Sign Up"),
      onPressed: () {
        print("Guitar");
      },
    );
  }
}
