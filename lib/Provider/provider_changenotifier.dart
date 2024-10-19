import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
//import 'package:fourth_year/Service/web3_service.dart';

class CountProvider extends ChangeNotifier {

String ?walletaddress ="hy";
bool walletstatus = false;
String _message = "";

 Future address(var add)async{
    if (add != null) {
      walletaddress = await add;
      print("somthing address");
    } else {
      print("nothing");
    }
    notifyListeners();
  }


}