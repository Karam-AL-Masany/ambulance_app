import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../crud/crud.dart';
import '../main.dart';
import '../server/linkapi.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();
  Crud _crud = Crud();



  bool _isVisible = false;

  login() async {
    var response = await _crud.postRequest(linkLogin, {
      "email": email.text,
      "pass": pass.text
    });

    if (response['status'] == "success") {
      sharedPref.setString("id", response['data']['id'].toString());
      sharedPref.setString("name", response['data']['fullName']);
      sharedPref.setString("email", response['data']['email']);
      sharedPref.setString("type", response['data']['type']);
      if (response['data']['type'] == "person")
        Navigator.of(context)
            .pushNamedAndRemoveUntil("bookingCategory", (route) => false);
      else if (response['data']['type'] == "admin")
        Navigator.of(context)
            .pushNamedAndRemoveUntil("adminScreen", (route) => false);
      else if (response['data']['type'] == "driver")
        Navigator.of(context)
            .pushNamedAndRemoveUntil("driverScreen", (route) => false);
    } else {
      print("login failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
                height: 200,
                margin: EdgeInsets.only(top: 20),
                child: Image.asset(
                  "imgs/logo.png",
                )),
            SizedBox(height: 30,),
            TextFormField(
              controller: email,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "Enter user email",
                labelText: "User email",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                filled: true,
                fillColor: Colors.red,
                prefixIcon: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: pass,
              obscureText: !_isVisible, // استخدام الحالة لإخفاء كلمة المرور
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "Password",
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18),
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                filled: true,
                fillColor: Colors.red,
                prefixIcon: Icon(
                  Icons.password,
                  color: Colors.white,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Forget Password",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
            SizedBox(height: 10,),
            MaterialButton(
              onPressed: () async => await login(),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              height: 45,
              child: Text(
                "LOGIN",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              color: Colors.red,
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Don't have an acccount",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed("signUp"),
                  child: Text(
                    "SignUp",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
