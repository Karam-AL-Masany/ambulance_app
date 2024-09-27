import 'dart:io';
import 'dart:ui';
import 'package:ambulance_booking/screens/select_location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../crud/connect_sqlite.dart';
import '../crud/crud.dart';
import '../server/linkapi.dart';

class BookingCategory extends StatefulWidget {
  const BookingCategory({Key? key}) : super(key: key);

  @override
  State<BookingCategory> createState() => _BookingCategoryState();
}

class _BookingCategoryState extends State<BookingCategory> with Crud {


  Future<void> _phoneCall() async {

  const String phoneNum = '1122';

  try {
  await FlutterPhoneDirectCaller.callNumber(phoneNum);
  } catch (e) {
  print('Could not make call: $e');
  }
  }


  String countPending = "0" ;

  Future<void> _updateCountPending() async {
    var response = await postRequest(linkBookingsPending, {});
    if (response['status'] != 'failed') {
      setState(() {
        countPending = response['data'].length > 0
            ? response['data'][0]['active'].toString()
            : "0";
      });
    } else {
      setState(() {
        countPending = "0";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _updateCountPending();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      "BOOK AN",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "AMBULANCE",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  width: 7,
                ),
                Expanded(
                    child: Image.asset(
                      "imgs/ambulance car.png",
                      height: 70,
                    ))
              ],
            ),
            SizedBox(
              height: 30,
            ),

            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 20, crossAxisSpacing: 20),
              physics: NeverScrollableScrollPhysics(),
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SelectLocation(type : "Medical");
                      }
                    ));
                  } ,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "imgs/medical.png",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                return SelectLocation(type : "Accident");
                }
                ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "imgs/accident.png",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return SelectLocation(type : "Fire");
                        }
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "imgs/fire.png",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return SelectLocation(type : "Other");
                        }
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            "imgs/other.png",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              onPressed: () {
                _phoneCall();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 45,
              child: Text(
                "1122 Call",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              color: Colors.red,
            ),
            SizedBox(
              height: 100,
            ),

            Stack(
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("OperationCase");
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        height: 45,
                        minWidth: 150,
                        child: Row(
                          children: [
                            Icon(
                              Icons.note_add_rounded,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Text(
                                "MY RECORD",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("profile");
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        height: 45,
                        minWidth: 150,
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "PROFILE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),


                Positioned(
                  top: -20,
                  left: 100,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.green,
                    child: Text(
                      "${countPending}",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),






              ],
            ),
          ],
        ),
      ),
    );
  }
}
