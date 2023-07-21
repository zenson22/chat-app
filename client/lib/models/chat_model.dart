import 'package:scoped_model/scoped_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import './User.dart';
import './Message.dart';
class ChatModel extends Model {
  List<User> users = [
    User('IronMan', '111'),
    User('Captain America', '222'),
    User('Antman', '333'),
    User('Hulk', '444'),
    User('Thor', '555'),
  ];
  late User currentUser;
  List<User> friendList = [];
  List<Message> messages = [];
  late IO.Socket socketIO;

  void init() {
    currentUser = users[0];
    friendList =
        users.where((user) => user.chatID != currentUser.chatID).toList();

    socketIO = IO.io('http://localhost:8080', <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socketIO.connect();

    socketIO.on('receive_message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      messages.add(Message(
          data['content'], data['senderID'], data['receiverID']));
      notifyListeners();
    });

    socketIO.onConnect((_) {
      print('Connection established');
    });
    socketIO.onDisconnect((_) => print('Connection Disconnection'));
    socketIO.onConnectError((err) => print(err));
    socketIO.onError((err) => print(err));
  }
  void sendMessage(String text, String receiverID) {
    messages.add(Message(text, currentUser.chatID, receiverID));
    socketIO.emit(
      'send_message',
      json.encode({
        'receiverID': receiverID,
        'senderID': currentUser.chatID,
        'content': text,
      }),
    );
    notifyListeners();
  }
  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }
}