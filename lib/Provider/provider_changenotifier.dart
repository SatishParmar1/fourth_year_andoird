import 'package:flutter/material.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'package:fourth_year/Service/web3_service.dart';

class CountProvider extends ChangeNotifier {
  final BlockchainService _blockchainService = BlockchainService();

String ?walletaddress ="hy";
bool walletstatus = false;
String _message = "";




  address(var add)async{
    if (add != null) {
      walletaddress = await add;
      print(walletaddress);
      print("somthing address");
    } else {
      print(walletaddress);
      print("nothing");
    }
    notifyListeners();
  }

  String get message => _message;

Future<void> fetchMessage() async {
  try {
    final result = await _blockchainService.callFunction("getMessage");
    _message = result;
    notifyListeners();
  } catch (e) {
    // Handle error
  }
}

}