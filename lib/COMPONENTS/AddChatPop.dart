import 'package:flutter/material.dart';

class AddChatPop extends StatelessWidget {
  final List<Widget> userList;

  const AddChatPop({
    Key key,
    this.userList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      width: MediaQuery.of(context).size.width,
      constraints: BoxConstraints(
        maxHeight: (MediaQuery.of(context).size.height * 0.92),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 5.0,
            width: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.grey,
            ),
            margin: const EdgeInsets.all(10.0),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Add New Chat',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: userList,
            ),
          ),
        ],
      ),
    );
  }
}
