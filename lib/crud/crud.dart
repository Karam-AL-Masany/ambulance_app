
import 'dart:convert' ;
import 'dart:io';
import 'package:http/http.dart' as http ;
import 'package:path/path.dart';

class Crud {

  getRequest (String url) async{
    try {
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
         var responseBody = jsonDecode(response.body);
         return responseBody ;
      } else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
        print("Error catch $e ");
    }
  }


  postRequest (String url , Map data) async{
    try {
      var response = await http.post(Uri.parse(url),body : data);
      if(response.statusCode == 200){
        var responseBody = jsonDecode(response.body);
        return responseBody ;
      } else{
        print("Error ${response.statusCode}");
      }
    }catch(e){
      print("Error catch $e ");
    }
  }


  postWithImage (String url , Map data , File file) async {
    var request = http.MultipartRequest("POST",Uri.parse(url));
    var stream = http.ByteStream(file.openRead());
    var length = await file.length();
    var mulFile = http.MultipartFile("cnicImg",stream,length,filename: basename(file.path));
    request.files.add(mulFile);
    data.forEach((key, value) {
      request.fields[key] = value ;
    });
    var myRequest = await request.send();
    var response = await http.Response.fromStream(myRequest);
    if(myRequest.statusCode == 200){
      return jsonDecode(response.body);
    } else {
      print('Error ${myRequest.statusCode}');
    }

  }

}