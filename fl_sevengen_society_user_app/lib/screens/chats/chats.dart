import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/widget/column_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final tabs = [translate('chats.chats'), translate('chats.residents')];

  int selectedIndex = 0;

  final chatsList = [
    {
      "image": "assets/messages/image1.png",
      "name": "Cody Fisher",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image2.png",
      "name": "Albert Flores",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image3.png",
      "name": "Devon Lane",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image4.png",
      "name": "Albert Flores",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image5.png",
      "name": "Marvin McKinney",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image6.png",
      "name": "Jerome Bell",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image7.png",
      "name": "Robert Fox",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image8.png",
      "name": "Annette Black",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image9.png",
      "name": "Jerome Bell",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image10.png",
      "name": "Jerome Bell",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image11.png",
      "name": "Leslie Alexander",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
    {
      "image": "assets/messages/image12.png",
      "name": "jeklin Shah",
      "lastMessage": "Hello, Good morning",
      "time": "2.00am"
    },
  ];

  final residentList = [
    {
      "title": "Block A",
      "list": [
        {
          "image": "assets/messages/blockA1.png",
          "title": "Cody Fisher",
          "flatNo": "Block A-101 (Owner)"
        },
        {
          "image": "assets/messages/blockA2.png",
          "title": "Wade Warren",
          "flatNo": "Block A-102 (Tenant)"
        },
        {
          "image": "assets/messages/blockA3.png",
          "title": "Jane Cooper",
          "flatNo": "Block A-103 (Owner)"
        },
        {
          "image": "assets/messages/blockA4.png",
          "title": "Esther Howard",
          "flatNo": "Block A-104 (Tenant)"
        },
      ]
    },
    {
      "title": "Block B",
      "list": [
        {
          "image": "assets/messages/blockB1.png",
          "title": "Robert Fox",
          "flatNo": "Block B-101 (Owner)"
        },
        {
          "image": "assets/messages/blockB2.png",
          "title": "Leslie Alexander",
          "flatNo": "Block B-102 (Tenant)"
        },
        {
          "image": "assets/messages/blockB3.png",
          "title": "Guy Hawkins",
          "flatNo": "Block B-103 (Owner)"
        },
        {
          "image": "assets/messages/blockB4.png",
          "title": "Ronald Richards",
          "flatNo": "Block B-104 (Tenant)"
        },
      ]
    },
    {
      "title": "Block C",
      "list": [
        {
          "image": "assets/messages/blockC1.png",
          "title": "Robert Fox",
          "flatNo": "Block C-101 (Owner)"
        },
        {
          "image": "assets/messages/blockC2.png",
          "title": "Leslie Alexander",
          "flatNo": "Block C-102 (Tenant)"
        },
        {
          "image": "assets/messages/blockC3.png",
          "title": "Guy Hawkins",
          "flatNo": "Block C-103 (Owner)"
        },
        {
          "image": "assets/messages/blockC4.png",
          "title": "Ronald Richards",
          "flatNo": "Block C-104 (Tenant)"
        },
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 20.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          getTranslate(context, 'chats.chats'),
          style: semibold22Black33,
        ),
        actions: [
          IconButton(
            onPressed: () {
             // Navigator.pushNamed(context, '/search');
            },
            icon: const Icon(
              Icons.search,
              size: 22,
              color: primaryColor,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          tabBar(),
          if (selectedIndex == 0) chatsListContent(),
          if (selectedIndex == 1) residentsListContent()
        ],
      ),
    );
  }

  residentsListContent() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding * 9.0),
        physics: const BouncingScrollPhysics(),
        itemCount: residentList.length,
        itemBuilder: (context, index) {
          List itemData = residentList[index]['list'] as List;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                residentList[index]['title'].toString(),
                style: medium16Primary,
              ),
              height5Space,
              Container(
                height: 4,
                width: 46,
                color: primaryColor,
              ),
              heightSpace,
              ColumnBuilder(
                itemBuilder: (context, i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: fixPadding),
                    child: Row(
                      children: [
                        Container(
                          height: 50.0,
                          width: 50.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                itemData[i]['image'].toString(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        widthSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                itemData[i]['title'].toString(),
                                style: medium16Primary,
                              ),
                              height5Space,
                              Text(
                                itemData[i]['flatNo'].toString(),
                                style: medium14Grey,
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                     /*       Navigator.pushNamed(context, '/call',
                                arguments: {"id": 1});*/
                          },
                          child: const Icon(
                            Icons.phone_outlined,
                            size: 22,
                            color: greyColor,
                          ),
                        ),
                        widthSpace,
                        width5Space,
                        InkWell(
                          onTap: () {
                           // Navigator.pushNamed(context, '/message');
                          },
                          child: const Icon(
                            CupertinoIcons.ellipses_bubble,
                            size: 22,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: itemData.length,
              )
            ],
          );
        },
      ),
    );
  }

  chatsListContent() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0, fixPadding, fixPadding * 2.0, fixPadding * 8.0),
        itemCount: chatsList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: fixPadding),
            child: InkWell(
              onTap: () {
                //Navigator.pushNamed(context, '/message');
              },
              child: Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          chatsList[index]['image'].toString(),
                        ),
                      ),
                    ),
                  ),
                  width5Space,
                  widthSpace,
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chatsList[index]['name'].toString(),
                                style: medium16Primary,
                                overflow: TextOverflow.ellipsis,
                              ),
                              height5Space,
                              Text(
                                chatsList[index]['lastMessage'].toString(),
                                style: medium14Grey,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                        Text(
                          chatsList[index]['time'].toString(),
                          style: semibold14Grey,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  tabBar() {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0, vertical: fixPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.transparent,
      ),
      child: Row(
        children: List.generate(
          tabs.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(fixPadding),
                color: selectedIndex == index ? primaryColor : f6f3Color,
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style:
                      selectedIndex == index ? semibold16White : semibold16Grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
