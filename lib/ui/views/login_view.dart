import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_project/providers/auth_provider.dart';
import 'package:twitter_project/providers/login_form_provider.dart';
import 'package:twitter_project/router/router.dart';
import 'package:twitter_project/ui/buttons/custom_outlined_button.dart';
import 'package:twitter_project/ui/buttons/link_text%20copy.dart';
import 'package:twitter_project/ui/inputs/custom_inputs.dart';

class LoginView extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);
    
    return ChangeNotifierProvider(
      create: ( _ ) => LoginFormProvider(),
      child: Builder(builder: ( context ){

        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);


        return Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.symmetric( horizontal: 20 ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints( maxWidth: 370 ),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: loginFormProvider.formKey,
              child: Column(
                children: [
                  
                  // Email
                  TextFormField(
                    onFieldSubmitted: ( _ ) => onFormSubmit( loginFormProvider, authProvider ),
                    validator: ( value ) {
                      if( !EmailValidator.validate(value ?? '') ) return 'Email no válido';

                      return null;
                    },
                    onChanged: ( value ) => loginFormProvider.email = value,
                    style: const TextStyle( color: Colors.white ),
                    decoration: CustomInputs.loginInputDecoration(
                      hint: 'Ingrese su correo',
                      label: 'Email',
                      icon: Icons.email_outlined
                    ),
                  ),

                  const SizedBox( height: 20 ),

                  // Password
                  TextFormField(
                    onFieldSubmitted: ( _ ) => onFormSubmit( loginFormProvider, authProvider ),
                    onChanged: ( value ) => loginFormProvider.password = value,
                    validator: ( value ) {
                      if ( value == null || value.isEmpty ) return 'Ingrese su contraseña';
                      if ( value.length < 6 ) return 'La contraseña debe de ser de 6 caracteres';

                      return null; // Válido
                    },
                    obscureText: true,
                    style: const TextStyle( color: Colors.white ),
                    decoration: CustomInputs.loginInputDecoration(
                      hint: '*********',
                      label: 'Contraseña',
                      icon: Icons.lock_outline_rounded
                    ),
                  ),
                  
                  const SizedBox( height: 20 ),
                  CustomOutlinedButton(
                    onPressed: () => onFormSubmit( loginFormProvider, authProvider ), 
                    text: 'Ingresar',
                  ),


                  const SizedBox( height: 20 ),
                  LinkText(
                    text: 'Nueva cuenta',
                    onPressed: () {
                      Navigator.pushReplacementNamed( context, Flurorouter.registerRoute );
                    },
                  )

                ],
              )
            ),
          ),
        ),
      );
      })
    );
  }

  void onFormSubmit(LoginFormProvider loginFormProvider, AuthProvider authProvider ) {
    final isValid = loginFormProvider.validateForm();
    if ( isValid ) {
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
    }
  }

}