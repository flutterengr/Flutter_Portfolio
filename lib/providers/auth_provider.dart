import 'package:flutter/material.dart';
import 'package:twitter_project/models/http/usuario.dart';
import 'package:twitter_project/router/router.dart';
import 'package:twitter_project/services/local_storage.dart';
import 'package:twitter_project/services/navigation_service.dart';

import '../api/CafeApi.dart';
import '../models/http/auth_response.dart';
import '../services/notifications_service.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated
}

class AuthProvider extends ChangeNotifier {

  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user;

  AuthProvider() {
    isAuthenticated();
  }


  login( String email, String password ) {

    final data = {
      'correo': email,
      'password': password
    };

    CafeApi.post('/auth/login', data ).then(
      (json) {
        print(json);
        final authResponse = AuthResponse.fromMap(json);
        user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        CafeApi.configureDio();

        notifyListeners();

      }
      
    ).catchError( (e){
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });

  }

  register( String email, String password, String name ) {
    
    final data = {
      'nombre': name,
      'correo': email,
      'password': password
    };

    CafeApi.post('/usuarios', data ).then(
      (json) {
        print(json);
        final authResponse = AuthResponse.fromMap(json);
        user = authResponse.usuario;

        authStatus = AuthStatus.authenticated;
        LocalStorage.prefs.setString('token', authResponse.token );
        NavigationService.replaceTo(Flurorouter.dashboardRoute);

        CafeApi.configureDio();
        notifyListeners();

      }
      
    ).catchError( (e){
      print('error en: $e');
      NotificationsService.showSnackbarError('Usuario / Password no válidos');
    });
    
    
    

  }

  Future<bool> isAuthenticated() async {

    final token = LocalStorage.prefs.getString('token');

    if( token == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    
    try {
      final resp = await CafeApi.httpGet('/auth');
      final authReponse = AuthResponse.fromMap(resp);
      LocalStorage.prefs.setString('token', authReponse.token );
      
      user = authReponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;

    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

  }


  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }

}
