import 'dart:io';
import 'package:ambulance_booking/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import '../crud/crud.dart';
import '../server/linkapi.dart';

class SelectLocation extends StatefulWidget {
  final type ;
  const SelectLocation({Key? key, this.type}) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();

}

class _SelectLocationState extends State<SelectLocation> {


  bool major = false;
  bool minor = false;

  Crud _crud = new Crud();

  addBooking() async {
    if (myFile == null) return print('choose image');
    var response = await _crud.postWithImage(
      linkBookingAdd,
      {
        "type": widget.type,
        "quantity": major == true ? "Major" : minor == true ? "Minor" : "no chhosen",
        "count": "1",
        "userId": sharedPref.getString("id").toString(),
         "date" : DateTime.now().toString(),
        "bookingCase" : "pending" ,
        "bookingActive" : "new"
      },
      myFile!,
    );

    if (response['status'] == "success") {
      Navigator.of(context).pushNamed("OperationCase");

    } else {
      print("failed");
    }
  }

  File? myFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:



      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text("BOOK AN",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                    Text("AMBULANCE",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                SizedBox(width: 40,),
                Expanded(child: Image.asset("imgs/sign up.png",height: 100,))
              ],
            ),


            SizedBox(height: 30,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Major",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Switch(value: major, onChanged: (val){
                  setState(() {
                    major=val;
                  });
                  }),

                Text("Minor",
                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                Switch(value: minor, onChanged: (val){
                  setState(() {
                    minor=val;
                  });
                 }),
              ],
            ),

            Container(
              height: 300,
              padding: EdgeInsets.all(4.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red, width: 2),
              ),
              child:  FlutterMap(
                options: MapOptions(
                  center: LatLng(15.366581, 44.192180),
                  zoom: 18.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            Row(
              children: [
                MaterialButton(onPressed: ()async{
                  await  addBooking();
                },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  height: 45,
                  minWidth: 220,
                  child: Row(
                    children: [
                      Icon(Icons.location_on_rounded,color: Colors.white,),
                      SizedBox(width: 2,),
                      Text("BOOK CASE",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  color: Colors.red,
                ),

                SizedBox(width: 10,),

                Expanded(
                  child: MaterialButton(onPressed: (){
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    height: 45,
                    minWidth: 60,
                      color: myFile == null ? Colors.red : Colors.green,
                      child:
                              myFile == null ? Icon(Icons.arrow_upward,color: Colors.white) :  Icon(Icons.check,color: Colors.white54,),
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
