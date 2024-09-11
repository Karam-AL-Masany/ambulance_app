import 'package:ambulance_booking/crud/crud.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../server/linkapi.dart';
import '../wedgits/bottom_nav.dart';


class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> with Crud {

  getBookingsDriver() async{
    var response = await postRequest(linkBookingNew,
        {

        }
    ) ;

    return response ;
  }


  editBookingActive(String id , String bookingCase) async {
    var response = await postRequest(linkBookingNewEdit, {
      "id": id,
      "bookingActive": bookingCase,
    });
    if(response['status'] == 'success'){
      print("edit done");
    } else {
      print("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      bottomNavigationBar: BottomNav(),
      body:
      Padding(
        padding:  EdgeInsets.fromLTRB(20,20,20,2),
        child: ListView(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                    Text("ADMIN",
                      style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                    ),

              //  Expanded(child:
                Image.asset("imgs/ambulance car.png",height: 70,)
               // )
              ],
            ),

           // SizedBox(height: 2,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("NEW",
                      style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                    ),

                    IconButton(onPressed: (){
                      sharedPref.clear();
                      Navigator.of(context).pushNamed("login");
                    },icon: Icon(Icons.exit_to_app,size: 30,),)
                  ],
                ),

                SizedBox(height: 10,),


                FutureBuilder(
                    future: getBookingsDriver(),
                    builder: (BuildContext context,AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        if(snapshot.data['status'] == 'failed')
                          return Center(
                              child: Text("",
                                style: TextStyle(fontSize: 22,),
                              ));
                        return ListView.builder(
                            itemCount: snapshot.data['data'].length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context , i){
                              return
                                FutureBuilder(
                                    future: getBookingsDriver(),
                                    builder: (BuildContext context,AsyncSnapshot snapshot){
                                      if(snapshot.hasData){
                                        if(snapshot.data['status'] == 'failed')
                                          return Center(
                                              child: Text("",
                                                style: TextStyle(fontSize: 22,),
                                              ));
                                        return ListView.builder(
                                            itemCount: snapshot.data['data'].length,
                                            shrinkWrap: true,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemBuilder: (context , i){
                                              return
                                                Column(
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.fromLTRB(20, 8, 10, 20),
                                                      decoration: BoxDecoration(
                                                          color: Colors.black12,
                                                          borderRadius: BorderRadius.circular(15)
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text("Name : ${snapshot.data['data'][i]['fullName']}"),
                                                                  Text("Phone : ${snapshot.data['data'][i]['phone']}"),
                                                                  Text("Address : ${snapshot.data['data'][i]['address']}"),
                                                                  Text("Type : ${snapshot.data['data'][i]['type']}"),
                                                                  Text("Date : ${snapshot.data['data'][i]['date']}"),
                                                                  Text("Qoantity : ${snapshot.data['data'][i]['quantity']}"),
                                                                  Text("Count : ${snapshot.data['data'][i]['count']}"),
                                                                ],
                                                              ),

                                                              MaterialButton(onPressed: (){
                                                                //Navigator.of(context).pushNamed("home");
                                                              },
                                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                                height: 25,
                                                                child: Text("NEW",
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: 13,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                                color: Colors.yellow,
                                                              ),
                                                            ],
                                                          ),

                                                          SizedBox(height: 10,),

                                                          Container(
                                                            padding: EdgeInsets.zero,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(15),
                                                              border: Border.all(color: Colors.red, width: 2),
                                                            ),
                                                            clipBehavior: Clip.antiAlias,
                                                            child: Image.network(
                                                              "$linkImgName/${snapshot.data['data'][i]['img']}",
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),


                                                          Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight:  Radius.circular(15),
                                                                    topLeft:Radius.circular(7),topRight: Radius.circular(7) ),
                                                                border: Border.all( width:0.2),
                                                              ),
                                                              clipBehavior: Clip.antiAlias,
                                                              child: Image.network("$linkImgName/${snapshot.data['data'][i]['cnicImg']}",
                                                                fit: BoxFit.fill,
                                                              )),


                                                          SizedBox(height: 40,),

                                                          Row(
                                                            children: [
                                                         MaterialButton(
                                                                  onPressed: () async{
    await editBookingActive("${snapshot.data['data'][i]['id'].toString()}","active");
    setState(() {

    });
                                                                  },
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(10)),
                                                                  height: 45,
                                                                  minWidth: 140,
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons.west_outlined,
                                                                        color: Colors.white,
                                                                      ),
                                                                      SizedBox(
                                                                        width: 2,
                                                                      ),
                                                                      Text(
                                                                        "CONTINUE",
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 18,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  color: Colors.red,
                                                                ),


                                                              SizedBox(width: 10,),

                                                              Expanded(child:
                                                              MaterialButton(
                                                                onPressed: () {
                                                                  //Navigator.of(context).pushNamed("home");
                                                                },
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(10)),
                                                                height: 45,
                                                                minWidth: 140,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons.west_outlined,
                                                                      color: Colors.white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      "CANCEL",
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 18,
                                                                          fontWeight: FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                                color: Colors.red,
                                                              ),
                                                              ),


                                                            ],
                                                          ),


                                                        ],
                                                      )
                                                  ),



                                                  SizedBox(height: 40,),



                                                ],
                                              );



                                            });
                                      }
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return Center(child:Text("Check the server , loading...")) ;
                                      }
                                      return Center(child: Text("connecting...")) ;
                                    }
                                );

                            });
                      }
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return Center(child:Text("Check the server , loading...")) ;
                      }
                      return Center(child: Text("connecting...")) ;
                    }
                ),


                // Container(
                //     padding: EdgeInsets.fromLTRB(20, 8, 10, 20),
                //     decoration: BoxDecoration(
                //         color: Colors.black12,
                //         borderRadius: BorderRadius.circular(15)
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text("Name : Karam Mokhtar"),
                //             Text("Phone : +967 774753561"),
                //             Text("Address : Sawan Street"),
                //             Text("Type : Medical"),
                //             Text("Date : 2/9/2024"),
                //             Text("Qoantity : Minor"),
                //             Text("Count : 1"),
                //           ],
                //         ),
                //
                //         MaterialButton(onPressed: (){
                //           //Navigator.of(context).pushNamed("home");
                //         },
                //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                //           height: 25,
                //           child: Text("NEW",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 13,
                //                 fontWeight: FontWeight.bold
                //             ),
                //           ),
                //           color: Colors.yellow,
                //         ),
                //       ],
                //     )
                // ),
                //
                // SizedBox(height: 5,),
                //
                // Container(
                //   padding: EdgeInsets.zero,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     border: Border.all(color: Colors.red, width: 2),
                //   ),
                //   clipBehavior: Clip.antiAlias,
                //   child: Image.asset(
                //     "imgs/accedint.jpg",
                //     fit: BoxFit.cover,
                //   ),
                // ),
                //
                // Container(
                //     padding: EdgeInsets.all(4.5),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       border: Border.all( width:0.5),
                //     ),
                //     child: Image.asset("imgs/personal CNIC.png",
                //     fit: BoxFit.none,
                //     )),
                //
                // SizedBox(height: 40,),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     MaterialButton(
                //       onPressed: () {
                //         //Navigator.of(context).pushNamed("home");
                //       },
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10)),
                //       height: 45,
                //       minWidth: 140,
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.west_outlined,
                //             color: Colors.white,
                //           ),
                //           SizedBox(
                //             width: 2,
                //           ),
                //           Text(
                //             "CONTINUE",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //       color: Colors.red,
                //     ),
                //
                //
                //     MaterialButton(
                //       onPressed: () {
                //         //Navigator.of(context).pushNamed("home");
                //       },
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(10)),
                //       height: 45,
                //       minWidth: 140,
                //       child: Row(
                //         children: [
                //           Icon(
                //             Icons.west_outlined,
                //             color: Colors.white,
                //           ),
                //           SizedBox(
                //             width: 2,
                //           ),
                //           Text(
                //             "CANCEL",
                //             style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.bold),
                //           ),
                //         ],
                //       ),
                //       color: Colors.red,
                //     ),
                //
                //   ],
                // ),




              ],
            ),








          ],
        ),
      ),
    );
  }
}
