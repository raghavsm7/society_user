import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final messageList = [
    {"message": "Hii Galina", "time": "1.30 pm", "isMe": false},
    {"message": "Hii, how are you ?", "time": "1.30 pm", "isMe": true},
    {"message": "Fine..Canyou send me pic", "time": "1.30 pm", "isMe": false},
    {"message": "Ok. wait a minute", "time": "1.30 pm", "isMe": true},
    {"message": "Okay..plz dont forget", "time": "1.30 pm", "isMe": false},
    {"image": "assets/chat/image.png", "time": "1.30 pm", "isMe": true},
    {"message": "Okay..Thank you😍😍", "time": "1.30 pm", "isMe": false},
    {"message": "😍😍😍😍😍", "time": "1.30 pm", "isMe": true},
  ];

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        titleSpacing: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: black33Color,
          ),
        ),
        title: Row(
          children: [
            Container(
              height: 42.0,
              width: 42.0,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/chat/send-image.png",
                  ),
                ),
              ),
            ),
            widthSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Wade warren",
                  style: semibold16Black33,
                ),
                heightBox(3.0),
                const Text(
                  "Block A - 302",
                  style: semibold14Grey,
                )
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/call', arguments: {"id": 0});
            },
            icon: const Icon(
              Icons.call_outlined,
              color: primaryColor,
              size: 22,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                  left: fixPadding * 2.0,
                  right: fixPadding * 2.0,
                  bottom: fixPadding),
              reverse: true,
              itemCount: messageList.length,
              itemBuilder: (context, index) {
                int reverseIndex = messageList.length - index - 1;
                return messageList[reverseIndex]['isMe'] == true
                    ? sendMessages(reverseIndex, size)
                    : receiveMessages(reverseIndex);
              },
            ),
          ),
          messageField(),
        ],
      ),
    );
  }

  messageField() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            blurRadius: 6.0,
          )
        ],
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              cursorColor: primaryColor,
              style: semibold15Black33.copyWith(height: 1.2),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: fixPadding * 1.5),
                prefixIcon: const Icon(
                  CupertinoIcons.smiley,
                  color: primaryColor,
                ),
                hintText: getTranslate(context, 'messages.type_text_here'),
                hintStyle: regular14Primary.copyWith(height: 1.2),
              ),
            ),
          ),
          Container(
            width: 1,
            height: 60.0,
            color: primaryColor.withOpacity(0.2),
          ),
          sendButton()
        ],
      ),
    );
  }

  sendButton() {
    return SizedBox(
      height: 60.0,
      child: GestureDetector(
        onTap: () {
          if (messageController.text.isNotEmpty) {
            setState(() {
              messageList.add({
                "message": messageController.text,
                "time": DateFormat.jm().format(DateTime.now()),
                "isMe": true
              });
              messageController.clear();
              messageList;
            });
          }
        },
        child: Container(
          height: 37.0,
          width: 37.0,
          margin: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: whiteColor,
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.25),
                blurRadius: 5.0,
              )
            ],
            border: Border.all(
              color: primaryColor,
            ),
          ),
          alignment: Alignment.center,
          child: const Icon(
            Icons.send,
            color: primaryColor,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  receiveMessages(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      child: Row(
        mainAxisAlignment: languageValue == 4
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: languageValue == 4
                ? MainAxisAlignment.start
                : MainAxisAlignment.end,
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/chat/send-image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              heightBox(8.0)
            ],
          ),
          width5Space,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: fixPadding, vertical: fixPadding * 1.4),
                  margin: languageValue == 4
                      ? const EdgeInsets.only(left: fixPadding * 7.0)
                      : const EdgeInsets.only(right: fixPadding * 7.0),
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.1),
                    borderRadius: languageValue == 4
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          )
                        : const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                  ),
                  child: Text(
                    messageList[index]['message'].toString(),
                    style: semibold14Primary,
                  ),
                ),
                heightBox(3.0),
                Text(
                  messageList[index]['time'].toString(),
                  style: semibold12Grey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  sendMessages(int index, Size size) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: fixPadding),
      child: Row(
        mainAxisAlignment: languageValue == 4
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                messageList[index]['message'] != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: fixPadding, vertical: fixPadding * 1.4),
                        margin: languageValue == 4
                            ? const EdgeInsets.only(right: fixPadding * 7.0)
                            : const EdgeInsets.only(left: fixPadding * 7.0),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          boxShadow: [
                            BoxShadow(
                                color: primaryColor.withOpacity(0.2),
                                blurRadius: 6.0)
                          ],
                          borderRadius: languageValue == 4
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                        ),
                        child: Text(
                          messageList[index]['message'].toString(),
                          style: semibold14White,
                        ),
                      )
                    : Container(
                        height: 96,
                        width: size.width * 0.4,
                        margin: languageValue == 4
                            ? const EdgeInsets.only(right: fixPadding * 7.0)
                            : const EdgeInsets.only(left: fixPadding * 7.0),
                        decoration: BoxDecoration(
                          borderRadius: languageValue == 4
                              ? const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomRight: Radius.circular(10.0),
                                )
                              : const BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0),
                                ),
                          boxShadow: [
                            BoxShadow(
                              color: primaryColor.withOpacity(0.2),
                              blurRadius: 6.0,
                            )
                          ],
                          image: DecorationImage(
                            image: AssetImage(
                              messageList[index]['image'].toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                heightBox(3.0),
                Text(
                  messageList[index]['time'].toString(),
                  style: semibold12Grey,
                )
              ],
            ),
          ),
          width5Space,
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 25,
                width: 25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage("assets/chat/profile-image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              heightBox(8.0)
            ],
          )
        ],
      ),
    );
  }
}
