import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';

class Users with ChangeNotifier {

  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }//all

  int get count {
    return _items.length;
  }//count

  User byIndex(i){
    return _items.values.elementAt(i);
  }//byIndex

  void put(User user){
    if(user == null){
      return;
    }//if

    if( user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)){
      _items.update(user.id, (_) => User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,

      ));
    }//if
    else{

    //adicionar
       final id = Random().nextDouble().toString();
    _items.putIfAbsent(id, () => User(
      id: id,
      name: user.name,
      email: user.email,
      avatarUrl: user.avatarUrl,
    ));

    }//else

    notifyListeners();

  }//put

  void remove (User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      notifyListeners();

    }//if
  }//remove

  
} // class