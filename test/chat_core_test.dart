import 'package:flutter_test/flutter_test.dart';
import 'package:smart_assistant/view_model/chat_vm.dart';
import 'package:smart_assistant/data/datasources/repositories/chat_repository.dart';

class FakeRepo implements ChatRepository {
  @override
  Future<String> getReply(String message) async {
    return "Flutter is an open-source UI toolkit by Google used to build cross-platform applications.";
  }

  @override
  void saveMessage(Map<String, dynamic> message) {}

  @override
  List<Map<String, dynamic>> getLocalMessages() => [];

  @override
  void clearChat() {}
}

class FailingRepo implements ChatRepository {
  @override
  Future<String> getReply(String message) async {
    throw Exception("API failed");
  }

  @override
  void saveMessage(Map<String, dynamic> message) {}

  @override
  List<Map<String, dynamic>> getLocalMessages() => [];

  @override
  void clearChat() {}
}

void main() {
  late ChatViewModel vm;

  setUp(() {
    vm = ChatViewModel(FakeRepo());
  });

  test("should add user + bot message (real data)", () async {
    await vm.sendMessage("What is Flutter?");

    expect(vm.messages.length, 2);
    expect(vm.messages[0].text, "What is Flutter?");
    expect(vm.messages[1].text.contains("Flutter"), true);
  });

  test("should not send empty message", () async {
    await vm.sendMessage("");

    expect(vm.messages.isEmpty, true);
  });

  test("should handle API failure", () async {
    final vm = ChatViewModel(FailingRepo());

    await vm.sendMessage("Test");

    expect(vm.messages.last.text, "Something went wrong");
  });
}