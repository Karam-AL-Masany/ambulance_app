import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../crud/crud.dart';
import '../server/linkapi.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String select = "Select your Districts";

  TextEditingController cnicNum = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController type = TextEditingController();

  Crud _crud = Crud();

  bool _isVisible = false;

  signUp() async {
    if (myFile == null) return print('choose image');
    var response = await _crud.postWithImage(
      linkSignUp,
      {
        "cnicNum": cnicNum.text,
        "email": email.text,
        "fullName": fullName.text,
        "phone": phone.text,
        "pass": pass.text,
        "address": address.text,
        "district": select,
        "type": "person",
      },
      myFile!,
    );

    if (response['status'] == "success") {
      Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
    } else {
      print("failed");
    }
  }

  File? myFile;

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
                  "SIGNUP",
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
                  "imgs/sign up.png",
                )),
            SizedBox(height: 30),
            TextFormField(
              controller: email,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "Enter user email",
                labelText: "User email",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
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
            SizedBox(height: 10),
            TextFormField(
              controller: cnicNum,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "CNIC Number",
                labelText: "CNIC Number",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                filled: true,
                fillColor: Colors.red,
                prefixIcon: Icon(
                  Icons.payment,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: fullName,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "Full Name",
                labelText: "Full Name",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                filled: true,
                fillColor: Colors.red,
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: phone,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "Phone",
                labelText: "Phone",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                filled: true,
                fillColor: Colors.red,
                prefixIcon: Icon(
                  Icons.phone_in_talk_rounded,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: pass,
              obscureText: !_isVisible,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "Password",
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
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
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: address,
              style: TextStyle(color: Colors.white, fontSize: 18),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 5),
                hintText: "Address",
                labelText: "Address",
                labelStyle: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.bold),
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                filled: true,
                fillColor: Colors.red,
                prefixIcon: Icon(
                  Icons.location_on_rounded,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.red,
              child: Align(
                alignment: Alignment.centerRight,
                child: DropdownButton(
                  underline: Divider(),
                  icon: Icon(Icons.arrow_right, size: 45, color: Colors.white),
                  dropdownColor: Colors.red,
                  style: TextStyle(
                      color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                 // isExpanded: false,
                  items: ["Select your Districts", "Shooob", "Azzal"].map((String item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      select = value!;
                    });
                  },
                  value: select,
                ),
              ),
            ),

            SizedBox(height: 10),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: 150,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Choose image",
                              style: TextStyle(fontSize: 20)),
                        ),
                        InkWell(
                          onTap: () async {
                            PickedFile? xfile = await ImagePicker()
                                .getImage(source: ImageSource.camera);
                            Navigator.of(context).pop();
                            setState(() {});
                            myFile = File(xfile!.path);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Text("from camera",
                                style: TextStyle(fontSize: 18)),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            PickedFile? xfile = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            Navigator.of(context).pop();
                            setState(() {});
                            myFile = File(xfile!.path);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Text("from gallery",
                                style: TextStyle(fontSize: 18)),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Image.asset(
                    "imgs/personal CNIC.png",
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(height: 10),
            MaterialButton(
              onPressed: () async {
                await signUp();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              height: 45,
              child: Text(
                "SIGNUP",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              color: Colors.red,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Don't have an account",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("login");
                  },
                  child: Text(
                    "Signin",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
