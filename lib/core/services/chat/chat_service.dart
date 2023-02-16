import 'package:chat/core/services/chat/chat_mock_service.dart';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';

abstract class ChatService {
  //Stream de novas mensagens.
  Stream<List<ChatMessage>> messagesStream();

//Salvar mensagens recebidas (params mensagem e usuario que enviou.)
  Future<ChatMessage> save(String text, ChatUser user);

  factory ChatService() {
    return ChatMockService();
  }
}
