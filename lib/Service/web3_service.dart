import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:web3dart/contracts.dart';
import 'package:web3dart/crypto.dart';

class BlockchainService {
  final String rpcUrl = "https://data-seed-prebsc-1-s1.binance.org:8545/";
  final String contractAddress = "0xYourSmartContractAddress";

  Future<String> callFunction(String functionName,
      [List<dynamic> args = const []]) async {
    final response = await http.post(
      Uri.parse(rpcUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "eth_call",
        "params": [
          {
            "to": contractAddress,
            "data": encodeFunctionCall(functionName, args)
          },
          "latest"
        ],
        "id": 1,
      }),
    );

    final responseBody = jsonDecode(response.body);
    if (responseBody["error"] != null) {
      throw Exception(responseBody["error"]["message"]);
    }
    return responseBody["result"];
  }

  String encodeFunctionCall(String functionName, List<dynamic> args) {
    final abi = ContractAbi.fromJson(
        '[{ "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "inputs": [], "name": "getMessage", "outputs": [{ "internalType": "string", "name": "", "type": "string" }], "stateMutability": "view", "type": "function" }, { "inputs": [{ "internalType": "string", "name": "newMessage", "type": "string" }], "name": "setMessage", "outputs": [], "stateMutability": "nonpayable", "type": "function" }]',
        'YourContractName'
    );
    final function = abi.functions.firstWhere((func) => func.name == functionName);
    final encoded = function.encodeCall(args);
    return bytesToHex(encoded, padToEvenLength: true);
  }

}
