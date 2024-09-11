import 'package:flutter/material.dart';
class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int ind = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white54,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.black,
      selectedFontSize: 18,
      unselectedFontSize: 15,
      iconSize: 40,
      currentIndex: ind,
      onTap: (index){
        ind = index ;
          if(index == 0) {
            Navigator.of(context).pushNamed("adminScreen");
            ind = index ;
            setState(() {

            });
          } else if(ind == 1){
            Navigator.of(context).pushNamed("adminSearch");
            ind = index ;
            setState(() {

            });
          } else if(ind == 2){
            Navigator.of(context).pushNamed("adminBlocked");
            ind = index ;
            setState(() {

            });
          }
        setState(() {

        });


      },
      items: [
        BottomNavigationBarItem(
            label: "Home",icon: Icon(Icons.home,color: Colors.red,
        )
        ),

        BottomNavigationBarItem(
            label: "Users",icon: Icon(Icons.person,color: Colors.red,
          )
        ),

        BottomNavigationBarItem(
            label: "Blocked",icon: Icon(Icons.block_outlined,color: Colors.red,
        )
        ),

      ],
    );
  }
}

