import 'package:flutter/material.dart';

import '../crud/crud.dart';
import '../main.dart';
import '../server/linkapi.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with Crud {

  getUser() async{
    var response = await postRequest(linkView,
        {
          "id" : sharedPref.getString("id")
        }
    ) ;

    return response ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 35,right: 20,left: 20),
        children: [

          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                    onTap:() => Navigator.of(context).pushNamed("bookingCategory"),
                    child: Icon(Icons.keyboard_arrow_right_outlined))
              ]
          ),

          Container(
            height: 150,
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(255, 213, 255, 1),
              child: Icon(Icons.person,color: Colors.white,size: 100,),
            ),
          ),


          SizedBox(height: 10,),


          FutureBuilder(
              future: getUser(),
              builder: (BuildContext context,AsyncSnapshot snapshot){
                if(snapshot.hasData){
                  if(snapshot.data['status'] == 'failed')
                    return Center(
                        child: Text("There is not user",
                          style: TextStyle(fontSize: 22,),
                        ));
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context , i){
                        return Column(
                          children: [
                            Text("${snapshot.data['data'][i]['fullName']}",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                            SizedBox(height: 20,),
                            Text("${snapshot.data['data'][i]['cnicNum']}",
                                style: TextStyle(
                                fontSize: 19,
                            ),
                            ),
                            Text("${snapshot.data['data'][i]['phone']}",
                              style: TextStyle(
                                fontSize: 19,
                              ),),
                            Text("${snapshot.data['data'][i]['email']}",
                              style: TextStyle(
                                fontSize: 19,
                              ),),
                            Text("${snapshot.data['data'][i]['address']}",
                              style: TextStyle(
                                fontSize: 19,
                              ),),

                            SizedBox(height: 20,),

                            Text("YOUR CNIC",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),),

                            SizedBox(height: 20,),

                            Image.network("$linkImgName/${snapshot.data['data'][i]['cnicImg']}",),

                            SizedBox(height: 100,),

                            MaterialButton(onPressed: (){
                              sharedPref.clear();
                              Navigator.of(context).pushNamed("login");
                            },
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              height: 45,
                              minWidth: 150,
                              child:

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.exit_to_app,color: Colors.white,),
                                  SizedBox(width: 10,),
                                  Text("LOGOUT",
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

                            SizedBox(height: 20,),


                          ],
                        );
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
    );
  }
}
