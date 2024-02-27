import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/application/auth/auth_bloc.dart';
import 'package:weather_app/presentation/auth/sign_in_screen.dart';
import 'package:weather_app/presentation/weather/location_screen.dart';

class SignupPage extends StatefulWidget {
  static String page = "signup_page";

  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  dynamic userid = "";

  dynamic psswrd = "";

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final firre = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.w900),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocConsumer<AuthBloc,AuthBlocState>(
            listener: (context,state){
              if(state is SignInCompleted){
                Navigator.pushReplacementNamed(context,LocationPage.page);
              } else if(state is DataValueFailed){
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
                      context
                          .read<AuthBloc>()
                          .add(PerformSignUp(userid, psswrd));
                      Navigator.pushReplacementNamed(context, LocationPage.page);
                    },
                    child: const Text('Sign Up'),
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      const Text("Already user?"),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SigninPage.page);
                          },
                          child: const Text(
                            " SignIn here",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, color: Colors.purple),
                          ))
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void Snack() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your Email is already register with us'),
      ),
    );
  }
}
