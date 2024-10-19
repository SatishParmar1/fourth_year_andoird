import 'package:fourth_year/User Deshbord/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'package:fourth_year/Provider/provider_changenotifier.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  late W3MService _w3mService;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final Set<String> excludedWalletIds = {
    'c57ca95b47569778a828d19178114f4db188b89b763c899ba0be274e97267d96', // MetaMask
    '4622a2b2d6af1c9844944291e5e7351a6aa24cd7b23099efac1b2fd875da31a0', // Trust
  };

String ?address = "hy";
  @override
  void initState(){
    super.initState();
    initializeState();

  }

  void initializeState() async{
    _w3mService = W3MService(
      projectId: 'd6babd37edea26b992ae0233bd63e25d',
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'w3w://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );
 await _w3mService.init();

    if (_w3mService.isConnected) {
      print("already connected");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Modify the provider value by calling the provider's method
        Provider.of<CountProvider>(context, listen: false).address(_w3mService.session?.address);
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    }
    _w3mService.addListener(() {
      if (_w3mService.isConnected) {
        address = _w3mService.session?.address;
        print(address);
        print("add listener");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()),
        );
      }else{
        print("please connect account");
      }
    });
  }




  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Data"),
        backgroundColor: Colors.blueGrey.shade400,
      ),
      body:
      Consumer<CountProvider>(
        builder: (context,proname, child){
          if(_w3mService.isConnected) {
            proname.walletaddress = _w3mService.session?.address;
            proname.address(_w3mService.session?.address);
            print("addres new address");
          }

          proname.walletstatus =true;
          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Column(
            children: [
              // Username TextField

            TextField(controller: _name,style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: 'Your Name',
                suffixIcon: Icon(Icons.person_2_rounded,size: 30,),
                suffixIconColor: Colors.grey,

                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1,),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey,width: 2,),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),

              ),
            ),

            SizedBox(height: 15,),
            TextField(controller: _password,
              style: TextStyle(fontSize: 20),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Moblie Number',
                suffixIcon: Icon(Icons.call_end_rounded,size: 30,),
                suffixIconColor: Colors.grey,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black,width: 1,),
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey,width: 2,),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
              ),
            ),
              ],
            ),
              SizedBox(height: 35,),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              W3MConnectWalletButton(
              service: _w3mService,
              size: BaseButtonSize.big,
                ),

              W3MNetworkSelectButton(service: _w3mService),
              /*
              const SizedBox(height: 30),
              W3MAccountButton(service: _w3mService),*/
              ],
              ),
            ],
          )



          );
        }

      ),



    );




  }
}
