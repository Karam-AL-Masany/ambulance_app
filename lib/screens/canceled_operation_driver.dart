import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../crud/crud.dart';
import '../server/linkapi.dart';



class CanceledOperationDriver extends StatefulWidget {
  final id ;
  const CanceledOperationDriver({Key? key , this.id}) : super(key: key);

  @override
  State<CanceledOperationDriver> createState() => _CanceledOperationDriverState();
}

class _CanceledOperationDriverState extends State<CanceledOperationDriver> with Crud {


  editBooking( String bookingCase) async {
    var response = await postRequest(linkBookingEdit, {
      "id": widget.id,
      "bookingCase": bookingCase,
    });
    if(response['status'] == 'success'){
      print("edit done");
    } else {
      print("failed");
    }
  }


  showConfirmDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text('Alert',
          style: TextStyle(fontSize: 25),),
        content: Text( 'Do you want to Canceled the Case',
          style: TextStyle(fontSize: 16),),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          CupertinoDialogAction(
            child: Text('Confirm'),
            onPressed: () async {
              await editBooking("canceled");
              setState(() {

              });
              Navigator.of(
                  context).pushNamed("driverScreen");
            },
            isDestructiveAction: true,
          ),
        ],
      ),
    );
  }


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



            Container(
               height: 300,
                padding: EdgeInsets.all(4.5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.red, width: 2),
                ),
            ),

                SizedBox(height: 20,),

                MaterialButton(onPressed: () async{

                 await   showConfirmDialog(context);

                },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  height: 45,
                  minWidth: 240,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check,color: Colors.white,size: 40,),
                      SizedBox(width: 2,),
                      Text("COMPLETE",
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








          ],
        ),
      ),
    );
  }
}
