import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ichat_app/alScreens/home_page.dart';
import 'package:ichat_app/allProviders/auth_provider.dart';
import 'package:ichat_app/allWidgets/loading_view.dart';
import 'package:provider/provider.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {

    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch(authProvider.status){
      case Status.authenticateError:
      Fluttertoast.showToast(msg: "Sign in fail");
      break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: "Sign in canceled");
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: "Sign in Success");
        break;
      default: break;
    }
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          Padding(padding: EdgeInsets.all(20.0),
          child: Image.asset("images/back.png"),
          ),
          Padding(padding: EdgeInsets.all(20.0),
            child:  GestureDetector(
              onTap: ()async{
                bool isSuccess = await authProvider.handleSignIn();
                if(isSuccess){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage() ));
                }
              },
              child: Image.asset("images/google_login.jpg")
            ),
          ),
          Positioned(child: authProvider.status == Status.authenticating ? LoadingView() : SizedBox.shrink(),),
        ],
      ),
    );
  }
}
