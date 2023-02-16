import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

import '../../models/chat_user.dart';

class ChatMockService implements ChatService {
  static final List<ChatMessage> _msgs = [
    // ChatMessage(
    //   id: "2",
    //   text: "Oi, Bom dia",
    //   createdAt: DateTime.now(),
    //   userId: '2',
    //   userName: "Ana",
    //   userImageURL:
    //       "https://cdn.pixabay.com/photo/2016/08/20/05/38/avatar-1606916_960_720.png",
    // ),
    // ChatMessage(
    //     id: "1",
    //     text: "Oi, Como vai?",
    //     createdAt: DateTime.now(),
    //     userId: '1',
    //     userName: "Ana",
    //     userImageURL: 'assets/images/avatar.png'),
    // ChatMessage(
    //   id: "3",
    //   text: "Fala pessoal !! Bom dia.",
    //   createdAt: DateTime.now(),
    //   userId: '3',
    //   userName: "Teste 3",
    //   userImageURL:
    //       "https://i.ytimg.com/vi/lWS2mrM8oe0/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLA2rRqs1PA9MbRaWhI6TUMdDYXglw",
    // ),
  ];
  static MultiStreamController<List<ChatMessage>>? _controller;

  static final _msgsStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_msgs);
  });

  Stream<List<ChatMessage>> messagesStream() {
    return _msgsStream;
  }

//Salvar mensagens recebidas (params mensagem e usuario que enviou.)
  Future<ChatMessage> save(String text, ChatUser user) async {
    final newMessage = ChatMessage(
        id: Random().nextDouble().toString(),
        text: text,
        createdAt: DateTime.now(),
        userId: user.id,
        userName: user.name,
        userImageURL: user.imageURL);

    _msgs.add(newMessage);
    _controller?.add(_msgs.reversed.toList());
    return newMessage;
  }
}
