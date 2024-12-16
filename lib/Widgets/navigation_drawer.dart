import 'package:flutter/material.dart';
class Navigationdrawer extends StatelessWidget {
  const Navigationdrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: CircleAvatar()),
          ListTile(
            title: Text("data 1"),
            onTap: (){},
          ),
          ListTile(
            title: Text("data 1"),
            onTap: (){},
          ),
        ],
      ),
    );
  }
}
