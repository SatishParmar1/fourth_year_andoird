/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'room_provider.dart';

class AddRoomScreen extends StatelessWidget {
  final TextEditingController _roomNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Room'),
        ),
        body: Consumer<RoomProvider>(
          builder: (context, roomProvider, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _roomNameController,
                    decoration: InputDecoration(labelText: 'Room Name'),
                  ),
                  SizedBox(height: 20),
                  roomProvider.isLoading
                      ? CircularProgressIndicator()
                      : Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          roomProvider.connectToMetaMask();
                        },
                        child: Text('Connect to MetaMask'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          String roomName = _roomNameController.text;
                          if (roomName.isNotEmpty) {
                            roomProvider.addRoom(roomName);
                          }
                        },
                        child: Text('Add Room'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(roomProvider.statusMessage),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
*/
