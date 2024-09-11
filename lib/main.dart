import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/login.dart';
import 'Auth/signup.dart';
import 'crud/connect_sqlite.dart';
import 'screens/admin_blocked_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/admin_search_screen.dart';
import 'screens/booking_category.dart';
import 'screens/canceled_operation_driver.dart';
import 'screens/complete_operation_driver.dart';
import 'screens/driver_screen.dart';
import 'screens/operation_case_of_booking.dart';
import 'screens/profile.dart';
import 'screens/select_location.dart';

late SharedPreferences sharedPref ;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sharedPref.getString("type") == "person" ? BookingCategory() : sharedPref.getString("type")  == "driver" ? DriverScreen() : sharedPref.getString("type")  == "admin" ? AdminScreen() : Login() ,
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        buttonColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        "login" : (context) => Login() ,
        "signUp" : (context) => SignUp() ,
        "bookingCategory" : (context) => BookingCategory(),
        "selectLocation" : (context) => SelectLocation(),
        "OperationCase" : (context) => OperationCase(),
        "profile" : (context) => Profile(),
        "driverScreen" : (context) => DriverScreen(),
        "completeOperationDriver" : (context) => CompleteOperationDriver(),
        "adminScreen" : (context) => AdminScreen(),
        "adminSearch" : (context) => AdminSearch(),
        "adminBlocked" : (context) => AdminBlocked(),
        "completeOperation" : (context) => CompleteOperationDriver(),
        "canceledOperation" : (context) => CanceledOperationDriver(),



      },
    );
  }
}

