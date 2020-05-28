import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl = 'https://flutter-firebase-crud01.firebaseio.com/';

  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    print('users.dat > get all ');
    return [..._items.values];
  } //all

  int get count {
    print('users.dat > get count ');
    return _items.length;
  } //count

  User byIndex(i) {
    return _items.values.elementAt(i);
  } //byIndex

  Future<void> put(User user) async {
    if (user == null) {
      return;
    } //if

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
        
        await http.patch(
        "$_baseUrl/users/${user.id}.json",
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        } //body 
            ), //json
      ); //patch

      _items.update(
          user.id,
          (_) => User(
                id: user.id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    } //if
    else {
      //adicionar
      final response = await http.post(
        "$_baseUrl/users.json",
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'avatarUrl': user.avatarUrl,
        } //body 
            ), //json
      ); //post

      final id = json.decode(response.body)['name'];
      print('id: ${id}');
      //final mail = json.decode(response.body)['name']['email'];
      //print('id: ${mail.toString()}');
      print (json.decode(response.body));

      _items.putIfAbsent(
          id,
          () => User(
                id: id,
                name: user.name,
                email: user.email,
                avatarUrl: user.avatarUrl,
              ));
    } //else

    notifyListeners();
  } //put

  void remove(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    } //if
  } //remove

} // class
