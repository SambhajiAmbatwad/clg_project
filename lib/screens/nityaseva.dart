import 'package:clg_project/Widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';

class Nityaseva extends StatefulWidget {
  const Nityaseva({super.key});

  @override
  State<Nityaseva> createState() => _NityasevaState();
}

class _NityasevaState extends State<Nityaseva> {
  bool _isChecked = false; // State to track the checkbox value
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "NityaSeva",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              // White menu icon
              onPressed: () {
                // Open the drawer using the correct context from the Builder widget
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_active,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Navigationdrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CheckboxListTile(
              fillColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Colors.orange; // Color when checked
                }
                return Colors.white; // Color when unchecked
              }),              checkColor: Colors.white,
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue!;
                });
              },
              title: Text("अवजंडी सेवा अंतिम नोंद करा"),
              controlAffinity: ListTileControlAffinity.leading, // Places checkbox before text
            ),
          ),
        ],
      ),
    );
  }
}
