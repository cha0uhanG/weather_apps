import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/auth/auth_bloc.dart';
import 'package:weather_app/injection.dart';
import 'package:weather_app/presentation/auth/sign_up_screen.dart';
import 'package:weather_app/presentation/weather/location_screen.dart';

class SigninPage extends StatefulWidget {
  static String page = "signin_page";

  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  dynamic userid = "";

  dynamic psswrd = "";

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Sign In',
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc,AuthBlocState>(
            listener: (context,state){
              if(state is SignInCompleted){
                Navigator.pushReplacementNamed(context,LocationPage.page);
              }else if(state is DataValueFailed){
                Snack();
              }
            },
            builder: (context,state){
              return state is DataLoading  ?const Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color:Colors.black ,strokeWidth: 10.0),
                  SizedBox(height: 10,),
                  Center(child: Text("Loading",style: TextStyle(fontWeight: FontWeight.w900,fontSize:20 ),))
                ],
              ): Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 300,
                      width: double.infinity,
                      child: Image.asset("images/signinimage.png")),
                  TextField(
                    controller: emailController,
                    onChanged: (valuee) {
                      userid = valuee;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: passwordController,
                    onChanged: (value) {
                      psswrd = value;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      print(psswrd);
                      print(userid);
                      try {
                        context
                            .read<AuthBloc>()
                            .add(PerformSignIn(userid, psswrd));
                        // var loggeduser = await firre.signInWithEmailAndPassword(email: userid, password: psswrd);
                        // print(loggeduser);
                        //  if (loggeduser != null) {
                        // Navigator.pushReplacementNamed(context,LocationPage.page);
                        // }
                      } catch (e) {
                        print(e);
                        Snack();
                      }
                    },
                    child: const Text('Sign In',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, color: Colors.purple)),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      const Text("New user?"),
                      GestureDetector(
                          onTap: () {
                             Navigator.pushNamed(context, SignupPage.page);
                          },
                          child: const Text(
                            " Register here",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.purple),
                          ))
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ) ,
    );
  }

  void Snack() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Your email or password is wrong'),
      ),
    );
  }
}
