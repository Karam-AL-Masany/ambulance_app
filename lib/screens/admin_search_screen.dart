import 'package:ambulance_booking/crud/crud.dart';
import 'package:flutter/material.dart';

import '../server/linkapi.dart';
import '../wedgits/bottom_nav.dart';


class AdminSearch extends StatefulWidget {
  const AdminSearch({Key? key}) : super(key: key);

  @override
  State<AdminSearch> createState() => _AdminSearchState();
}

class _AdminSearchState extends State<AdminSearch> with Crud {

  getBookingsActive() async{
    var response = await postRequest(linkBookingViewActive,
        {

        }
    ) ;

    return response ;
  }


  editBookingBlocked(String id , String bookingCase) async {
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
    return  Scaffold(
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

            SizedBox(height: 10,),

            MaterialButton(onPressed: (){
              //Navigator.of(context).pushNamed("home");
            },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              height: 45,
              child:

              Row(
                children: [
                  Icon(Icons.search,color: Colors.white54,size: 30,),
                  SizedBox(width: 10,),
                  Text("Search by email",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              color: Colors.red,
            ),

            SizedBox(height: 10,),

            FutureBuilder(
                future: getBookingsActive(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data['status'] == 'failed')
                      return Center(
                          child: Text("There's not cases",
                            style: TextStyle(fontSize: 22,),
                          ));
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context , i){
                          return
                            FutureBuilder(
                                future: getBookingsActive(),
                                builder: (BuildContext context,AsyncSnapshot snapshot){
                                  if(snapshot.hasData){
                                    if(snapshot.data['status'] == 'failed')
                                      return Center(
                                          child: Text("There's not cases",
                                            style: TextStyle(fontSize: 22,),
                                          ));
                                    return ListView.builder(
                                        itemCount: snapshot.data['data'].length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context , i){
                                          return
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                SizedBox(height: 10,),


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
                                                              child: Text("ACTIVE",
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 13,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                              color: Colors.lightGreen,
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
                                                          child:Image.network(
                                                            "$linkImgName/${snapshot.data['data'][i]['img']}",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),


                                                        SizedBox(height: 20,),

                                                        MaterialButton(onPressed: () async{
                                                          await editBookingBlocked("${snapshot.data['data'][i]['id'].toString()}","blocked");
                                                          setState(() {

                                                          });
                                                        },
                                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                          height: 45,
                                                          child:

                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(Icons.west_outlined,color: Colors.white54,size: 30,),
                                                              SizedBox(width: 10,),
                                                              Text("Block",
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 18,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          color: Colors.red,
                                                        ),


                                                      ],
                                                    )
                                                ),



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










          ],
        ),
      ),
    );
  }
}
