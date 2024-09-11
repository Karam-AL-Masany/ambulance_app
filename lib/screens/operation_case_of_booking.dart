import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../crud/crud.dart';
import '../main.dart';
import '../server/linkapi.dart';

class OperationCase extends StatefulWidget {
  const OperationCase({Key? key}) : super(key: key);

  @override
  State<OperationCase> createState() => _OperationCaseState();
}

class _OperationCaseState extends State<OperationCase> with Crud {

  getBookings() async{
    var response = await postRequest(linkBookingsView,
        {
          "id" : sharedPref.getString("id")
        }
    ) ;

    return response ;
  }


  // editBooking(String idBooking , String bookingCase) async {
  //     var response = await postRequest(linkBookingEdit, {
  //         "id": idBooking,
  //         "bookingCase": bookingCase,
  //       });
  //     if(response['status'] == 'success'){
  //       print("edit done");
  //     } else {
  //       print("failed");
  //     }
  // }


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
                Expanded(child: Image.asset("imgs/ambulance car.png",height: 100,))
              ],
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap:() => Navigator.of(context).pushNamed("bookingCategory"),
                      child: Icon(Icons.keyboard_arrow_right_outlined))]),

            SizedBox(height: 30,),


            FutureBuilder(
                future: getBookings(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data['status'] == 'failed')
                      return Center(
                          child: Text("There is not cases",
                            style: TextStyle(fontSize: 22,),
                          ));
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context , i){
                          return   Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${snapshot.data['data'][i]['bookingCase']}",
                                style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                              ),

                              SizedBox(height: 10,),

                              Container(
                                  padding: EdgeInsets.fromLTRB(20, 8, 10, 20),
                                  decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Name : ${snapshot.data['data'][i]['fullName']}",
                                            style: TextStyle(
                                                fontSize: 12,
                                            ),),
                                          Text("Phone : ${snapshot.data['data'][i]['phone']}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),),
                                          Text("Address : ${snapshot.data['data'][i]['address']}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),),
                                          Text("Type : ${snapshot.data['data'][i]['type']}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),),
                                          Text("Date : ${snapshot.data['data'][i]['date']}",
                                            style: TextStyle(
                                              fontSize: 12,
                                            ),),
                                        ],
                                      ),

                                      SizedBox(width: 20,),

                                      Expanded(
                                        child: MaterialButton(onPressed:
                                            () async {
                                          // if("${snapshot.data['data'][i]['bookingCase'].toString()}" == "pending") {
                                          //   await editBooking(
                                          //       "${snapshot.data['data'][i]['id']
                                          //           .toString()}", "completed");
                                          //   setState(() {
                                          //
                                          //   });
                                          // }
                                          // else if("${snapshot.data['data'][i]['bookingCase'].toString()}" == "completed")
                                          //  await   editBooking(snapshot.data['data'][i]['id'].toString(), "canceled");
                                          // setState(() {
                                          //
                                          // });
                                        },
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                          height: 30,
                                          child: Text("${snapshot.data['data'][i]['bookingCase']}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          color: snapshot.data['data'][i]['bookingCase'] == "completed" ? Colors.green : snapshot.data['data'][i]['bookingCase'] == "canceled" ? Colors.red :  Colors.yellow,
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                              Divider(height: 35,color: Colors.black12,thickness: 5,),
                            ],
                          ) ;
                        });
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child:Text("loading...")) ;
                  }
                  return Center(child: Text("connecting...")) ;
                }
            ),


          ],
        ),
      ),
    );
  }
}
