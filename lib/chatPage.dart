import 'package:crm_firebase_test/modals/customer_modal.dart';
import 'package:crm_firebase_test/modals/message_modal.dart';
import 'package:crm_firebase_test/services/apis.dart';
import 'package:crm_firebase_test/utils/custom_carousel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final CustomerModal customer;
  const ChatPage({super.key, required this.customer});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<MessageModal> messages = [];
  List<String> imageUrls = [
    "https://i.pinimg.com/564x/46/2e/f7/462ef74ca42f640000e5b5e4cf3dfcad.jpg",
    "https://i.pinimg.com/564x/67/91/03/679103895a7f37e882f493612d4bc9bf.jpg"
  ];
  List<String> bodyText = [
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
  ];
  List<String> audioUrls = [];
  final TextEditingController _messageController = TextEditingController();
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customer.cEmail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: ApiServices.getAllMessages(widget.customer),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  // log("Data : ${jsonEncode(data![0].data())}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                    case ConnectionState.active:
                      messages = data
                              ?.map((e) => MessageModal.fromJson(e.data()))
                              .toList() ??
                          [];
                      if (messages.isNotEmpty) {
                        return ListView.builder(
                          reverse: true,
                          itemCount: messages.length,
                          clipBehavior: Clip.antiAlias,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          itemBuilder: (context, index) {
                            return (messages[index].type == MessageType.widget)
                                ? CustomCarousel(
                                    message: messages[index],
                                  )
                                : Text(messages[index].message);
                          },
                        );
                      } else {
                        return const Center(
                          child: Text(
                            "Say hai ... ☻",
                            style: TextStyle(fontSize: 25),
                          ),
                        );
                      }
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type here..",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      // apiServices.sendMessageToCustomer(
                      //     user.uid, widget.customer.id, "hello world");
                      ApiServices.sendMessage(widget.customer,
                          _messageController.text, MessageType.text);
                      _messageController.clear();
                    },
                    child: const Icon(Icons.send),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      ApiServices.sendCustomWidget(
                          widget.customer,
                          MessageType.widget,
                          imageUrls,
                          bodyText,
                          audioUrls,
                          "Material",
                          "");
                    },
                    child: const Icon(Icons.widgets),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
