import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';  // For HTTP requests
import 'hello_abi.dart';  // Import the ABI file

class HelloWorldApp extends StatefulWidget {
  @override
  _HelloWorldAppState createState() => _HelloWorldAppState();
}

class _HelloWorldAppState extends State<HelloWorldApp> {
  late Web3Client _client;
  String _rpcUrl = "https://data-seed-prebsc-1-s1.binance.org:8545/";  // Binance Smart Chain Testnet
  String _privateKey = "your-private-key";  // Replace with your private key
  String _contractAddress = "your-contract-address";  // Replace with your contract address
  String _currentMessage = "";
  bool _isLoading = true;
  String _statusMessage = "Connecting to Blockchain...";

  late Credentials _credentials;
  late DeployedContract _contract;
  late ContractFunction _getMessage;
  late ContractFunction _setMessage;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    _client = Web3Client(_rpcUrl, Client());

    // Get credentials from the private key
    _credentials = EthPrivateKey.fromHex(_privateKey);

    // Load the contract's ABI from the imported file and get the deployed contract object
    EthereumAddress contractAddr = EthereumAddress.fromHex(_contractAddress);
    _contract = DeployedContract(
      ContractAbi.fromJson(helloWorldAbi, "HelloWorld"),  // Fetching ABI from contract_abi.dart
      contractAddr,
    );

    // Get contract functions
    _getMessage = _contract.function('getMessage');
    _setMessage = _contract.function('setMessage');

    await _getMessageFromContract();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getMessageFromContract() async {
    final result = await _client.call(
      contract: _contract,
      function: _getMessage,
      params: [],
    );

    setState(() {
      _currentMessage = result.first;
    });
  }

  Future<void> _setMessageOnContract(String newMessage) async {
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
        contract: _contract,
        function: _setMessage,
        parameters: [newMessage],
      ),
      chainId: 97,  // Binance Smart Chain testnet chain ID
    );

    _getMessageFromContract(); // Update message after setting new message
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HelloWorld Smart Contract'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Message from Blockchain:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              _currentMessage,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _setMessageOnContract("Hello from Flutter");
              },
              child: Text("Set New Message"),
            ),
          ],
        ),
      ),
    );
  }
}
