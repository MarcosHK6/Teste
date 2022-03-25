import 'package:flutter/material.dart';

Widget list = ListView.builder(
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {},
          leading: const Icon(Icons.person),
          title: Text("Person $index"),
          subtitle: Text("Age $index"),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                onPressed: () {},
                child: const Text("Edit", style: TextStyle(color: Colors.blue))
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Delete", style: TextStyle(color: Colors.red))
              )
            ],
          ),
        );
      }
    );