import 'package:databasee_intro/utils/database_helper.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';

List _users;
void main() async {
  var db = DatabaseHelper();
  //add new users
  await db.saveUser(User("Emilia", "Clarke"));

  //Delete a user
//  int _delete = await db.deleteUser(2);
//  print("Delete: $_delete");

  //get a user
  User anna = await db.getUser(1);
  print("Get User: ${anna.username}, Password: ${anna.password}");

  //update a user
  User annaUpdated = await User.fromMap({
    "username": "updatedAnna",
    "password": "updatedPassword",
    "id"      : 1
  });
  await db.updateUser(annaUpdated);

  //get All users
  _users = await db.getAllUsers();
  for (int i=0; i<_users.length; i++) {
    User user = User.map(_users[i]);
    print("Username: ${user.username}, User ID: ${user.id}");
  }

  //Count the number of users
  int _count = await db.getCount();
  print("Count: $_count");
  
  runApp(
    MaterialApp(
      title: "Database",
      home: Home(),
    )
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Database",
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index){
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                title: Text(
                  "User: ${User.fromMap(_users[index]).username}",
                ),
                subtitle: Text(
                  "ID: ${User.fromMap(_users[index]).id}"
                ),
                onTap: () => debugPrint("${User.fromMap(_users[index]).password}"),
                leading: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  child: Text(
                    "${User.fromMap(_users[index]).username.substring(0,1)}"
                  ),
                ),
              ),
            );
          }),
    );
  }
}
