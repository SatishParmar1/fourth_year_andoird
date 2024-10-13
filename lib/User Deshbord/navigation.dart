import 'package:flutter/material.dart';
import 'package:fourth_year/login/login.dart';

class navigaitonbar extends StatefulWidget {
  const navigaitonbar({super.key});

  @override
  State<navigaitonbar> createState() => _navigaitonbarState();
}

class _navigaitonbarState extends State<navigaitonbar> {

  int _selectedIndex = 0;
  @override

  void initState(){
    super.initState();

    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(child: CircularProgressIndicator()); // Loading spinner
          }
      );

      // Delay the navigation slightly to show the spinner momentarily
      Future.delayed(Duration(seconds: 1), () {
        _onItemTapped(0);

      });
    });
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
         Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
         );
        break;
      case 1:

        /*  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchPage()),
        );

       */
        break;
      case 2:

        /*Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessagesPage()),
        );
    */
        break;
      case 3:
        print("hello1");
        /*  Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsPage()),
        );
    */
        break;
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {// Handle "Add" button tap
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey.shade100,
        mini: true,
        // Color for FAB
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueGrey.shade700,

      ),

    );
  }
}
