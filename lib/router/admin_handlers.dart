import 'package:fluro/fluro.dart';

import '../ui/views/login_view.dart';
import '../ui/views/register_view.dart';

class AdminHandlers {

  static Handler login = Handler(
    handlerFunc: ( context, params ) {
      return const LoginView();
    }
  );

  static Handler register = Handler(
    handlerFunc: ( context, params ) {
      return const RegisterView();
    }
  );


}

