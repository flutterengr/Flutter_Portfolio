// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import '../api/CafeApi.dart';
import '../models/http/users_response.dart';
import '../models/http/usuario.dart';


class UsersProvider extends ChangeNotifier {

  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;
  
  UsersProvider() {
    this.getPaginatedUsers();
  }


  getPaginatedUsers() async {
    
    final resp = await CafeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResp = UsersResponse.fromMap(resp);
    this.users = [ ... usersResp.usuarios ];
    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserById( String uid ) async {
    
    try {
      final resp = await CafeApi.httpGet('/usuarios/$uid');
      final user = Usuario.fromMap(resp);
      return user;
      
    } catch (e) {
      return null;
    }
  }


  void sort<T>( Comparable<T> Function( Usuario user ) getField  ) {

    users.sort(( a, b ) {

        final aValue = getField( a );
        final bValue = getField( b );

        return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();

  }


  void refreshUser( Usuario newUser ) {

    this.users = this.users.map(
      (user){
        if ( user.uid == newUser.uid ) {
          user = newUser;
        }

        return user;
      }
    ).toList();


    notifyListeners();
  }

}