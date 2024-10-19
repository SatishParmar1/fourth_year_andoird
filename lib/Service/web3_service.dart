import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

class BlockchainService {
  final String _rpcUrl = "https://sepolia.infura.io/v3/693da7e285a74fe7965fc3d7357c3310"; // Replace with your Infura ID
  final String _contractAddress = "0xa25eAc76453822dc692ACf6156E981e58817e8f7"; // Replace with your contract address
  late CountProvider myProvider;
  final String _abi = [
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "string",
          "name": "_details",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "_pinNO",
          "type": "uint256"
        },
        {
          "internalType": "address[]",
          "name": "_allowedAddress",
          "type": "address[]"
        },
        {
          "components": [
            {
              "internalType": "bool",
              "name": "isallowed",
              "type": "bool"
            },
            {
              "internalType": "uint256",
              "name": "startTime",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "endTime",
              "type": "uint256"
            }
          ],
          "internalType": "struct HomeAutomation.allowedAddresses[]",
          "name": "_allowedAddresses",
          "type": "tuple[]"
        },
        {
          "internalType": "bool",
          "name": "ismultiparams",
          "type": "bool"
        },
        {
          "internalType": "uint8[5]",
          "name": "_multiParamsPin",
          "type": "uint8[5]"
        }
      ],
      "name": "addAppliances",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "string",
          "name": "_roomName",
          "type": "string"
        }
      ],
      "name": "addRoom",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        }
      ],
      "name": "addRoomOwner",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        }
      ],
      "name": "AddRoomOwner",
      "type": "event"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        }
      ],
      "name": "changeState",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "newState",
          "type": "uint256"
        }
      ],
      "name": "changeState",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceid",
          "type": "uint256"
        },
        {
          "internalType": "address",
          "name": "_allowed",
          "type": "address"
        }
      ],
      "name": "removeApplianceAccess",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "_applianceid",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "address",
          "name": "_allowed",
          "type": "address"
        }
      ],
      "name": "RemoveApplianceAccess",
      "type": "event"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        }
      ],
      "name": "removeRoomOwner",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "address",
          "name": "_owner",
          "type": "address"
        }
      ],
      "name": "RemoveRoomOwner",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "roomId",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "applianceId",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "state",
          "type": "uint256"
        }
      ],
      "name": "multiStateChange",
      "type": "event"
    },
    {
      "anonymous": false,
      "inputs": [
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "roomId",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "uint256",
          "name": "applianceId",
          "type": "uint256"
        },
        {
          "indexed": false,
          "internalType": "bool",
          "name": "state",
          "type": "bool"
        }
      ],
      "name": "stateChange",
      "type": "event"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        },
        {
          "internalType": "address",
          "name": "_allowed",
          "type": "address"
        }
      ],
      "name": "checkAllowedAddress",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        }
      ],
      "name": "checkIsMultiparams",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "room",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "applianceId",
          "type": "uint256"
        }
      ],
      "name": "data",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "roomId",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "applianceId",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "pinNo",
          "type": "uint256"
        },
        {
          "internalType": "bool",
          "name": "state",
          "type": "bool"
        },
        {
          "internalType": "string",
          "name": "details",
          "type": "string"
        },
        {
          "internalType": "bool",
          "name": "ismultiparameters",
          "type": "bool"
        },
        {
          "internalType": "uint256",
          "name": "multiparams",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getAllRooms",
      "outputs": [
        {
          "components": [
            {
              "internalType": "uint256",
              "name": "roomId",
              "type": "uint256"
            },
            {
              "internalType": "string",
              "name": "roomName",
              "type": "string"
            },
            {
              "internalType": "uint256",
              "name": "noOfAppliances",
              "type": "uint256"
            }
          ],
          "internalType": "struct HomeAutomation.Room[]",
          "name": "",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        }
      ],
      "name": "getApplianceCount",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        }
      ],
      "name": "getApplianceDetails",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        }
      ],
      "name": "getMultiparamsState",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        }
      ],
      "name": "getPinNo",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getRoomCount",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        }
      ],
      "name": "getRoomName",
      "outputs": [
        {
          "internalType": "string",
          "name": "",
          "type": "string"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "_roomid",
          "type": "uint256"
        },
        {
          "internalType": "uint256",
          "name": "_applianceId",
          "type": "uint256"
        }
      ],
      "name": "getSwitchState",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        },
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "name": "owner",
      "outputs": [
        {
          "internalType": "bool",
          "name": "",
          "type": "bool"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [
        {
          "internalType": "uint256",
          "name": "",
          "type": "uint256"
        }
      ],
      "name": "rooms",
      "outputs": [
        {
          "internalType": "uint256",
          "name": "roomId",
          "type": "uint256"
        },
        {
          "internalType": "string",
          "name": "roomName",
          "type": "string"
        },
        {
          "internalType": "uint256",
          "name": "noOfAppliances",
          "type": "uint256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "superAdmin",
      "outputs": [
        {
          "internalType": "address",
          "name": "",
          "type": "address"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ]; // Replace with your contract ABI

  late Web3Client _client;
  late DeployedContract _contract;
  late EthereumAddress _userAddress; // Store user's wallet address

  BlockchainService() {
    _client = Web3Client(_rpcUrl, Client());
    _loadContract();
  }

  void _loadContract() {
    final abi = ContractAbi.fromJson(_abi, 'HomeAutomation');
    _contract = DeployedContract(abi, EthereumAddress.fromHex(_contractAddress));
  }


  Future<void> connectToMetaMask() async {

    WidgetsBinding.instance.addPostFrameCallback((_) {
      myProvider = Provider.of<CountProvider>(context, listen: false);
      // Perform any initial action using the provider
      print("Provider Data in initState: ${myProvider.walletaddress}");
      // You can also call methods on the provider
      myProvider.updateData();
    });
      _userAddress = EthereumAddress.fromHex('myProvider'); // Store the user's address

  }

  Future<void> addRoom(String roomName) async {
    final ethFunction = _contract.function('addRoom');

    await _client.sendTransaction(
      null, // MetaMask signs the transaction, no private key needed here
      Transaction.callContract(
        contract: _contract,
        function: ethFunction,
        parameters: [roomName],
        from: _userAddress, // Use the user wallet address
      ),
      chainId: 11155111, // Sepolia Chain ID
    );
  }

// You can add more functions here for other blockchain interactions.
}
