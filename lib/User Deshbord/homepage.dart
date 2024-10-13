import 'package:flutter/material.dart';
import 'package:fourth_year/Profile/userprofile.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:fourth_year/Provider/provider_changenotifier.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ScrollController _controller = ScrollController();
  String selectedRoom = '';
  int _selectedIndex = 0;
  late W3MService _w3mService;

  @override
  void initState() {
    super.initState();
    _w3mService = W3MService(
      network: 'https://data-seed-prebsc-1-s1.binance.org:8545/',
      chainId: 97,
    );
  }

  void _connectWallet() async {
    String ?userAddress = Provider.of<CountProvider>(context, listen: false).walletaddress;
    // For now, just print the provider details
    print('useraddress');
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        print("hello0");

        break;
      case 1:
        print("hello1");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
        break;
      case 2:
        print("hello2");

        break;
      case 3:
        print("hello4");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Userprofileall()),
        );

        break;
    }

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title:Text("Home Page"),
        backgroundColor: Colors.blueGrey.shade400,
      ),
      body: Consumer<CountProvider>(
    builder: (context,proname, child) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text("Message: ${proname.message}"),
              ElevatedButton(
                onPressed: () => proname.fetchMessage(),
                child: Text("Get Message"),
              ),
            ],
          ),
        ),

      );
    }
    ),



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
            icon: Icon(Icons.ac_unit_rounded),
            label: 'Rooms',
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
