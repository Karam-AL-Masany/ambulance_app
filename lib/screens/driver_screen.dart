import 'package:ambulance_booking/crud/crud.dart';
import 'package:ambulance_booking/screens/complete_operation_driver.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../server/linkapi.dart';
import 'canceled_operation_driver.dart';


class DriverScreen extends StatefulWidget {
  const DriverScreen({Key? key}) : super(key: key);

  @override
  State<DriverScreen> createState() => _DriverScreenState();
}

class _DriverScreenState extends State<DriverScreen> with Crud {

  getBookingsDriver() async{
    var response = await postRequest(linkBookingsViewDriver,
        {

        }
    ) ;

    return response ;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:
      Padding(
        padding:  EdgeInsets.fromLTRB(20,20,20,2),
        child: ListView(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("DRIVER",
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                ),

                //  Expanded(child:
                Image.asset("imgs/ambulance car.png",height: 70,)
                // )
              ],
            ),

            SizedBox(height: 30,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("Pending",
                  style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                ),

                IconButton(onPressed: (){
                  sharedPref.clear();
                  Navigator.of(context).pushNamed("login");
                },icon: Icon(Icons.exit_to_app,size: 30,),),
              ],
            ),

            Divider(height: 30,color: Colors.black12,thickness: 5,),


            FutureBuilder(
                future: getBookingsDriver(),
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
                          return  Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              snapshot.data['data'][i]['bookingCase'].toString() == "completed" ?   Text("Completed",
                                style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
                              ) :   Text("Canceled",
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return CanceledOperationDriver(id :  snapshot.data['data'][i]['id']);
                                }
                            ));
                          },
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          height: 25,
                          child: Text("${snapshot.data['data'][i]['bookingCase']}",
                          style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                          ),
                          ),
                          color: snapshot.data['data'][i]['bookingCase'] == "completed" ? Colors.green : snapshot.data['data'][i]['bookingCase'] == "canceled" ? Colors.red :  Colors.yellow,
                          ),
                          ],
                          )
                          ),


                              snapshot.data['data'][i]['bookingCase'].toString() == "pending" ?
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
                          ): Text(""),


                              Divider(height: 30,color: Colors.black12,thickness: 5,),


                              snapshot.data['data'][i]['bookingCase'].toString() == "pending" ?
                              Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          MaterialButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return CompleteOperationDriver(id :  snapshot.data['data'][i]['id']);
                                }
                            ));
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

                          ],
                          ): Text(""),



                            ],
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
