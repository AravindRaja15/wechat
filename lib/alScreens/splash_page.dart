import 'package:flutter/material.dart';
import 'package:ichat_app/alScreens/home_page.dart';
import 'package:ichat_app/alScreens/login_page.dart';
import 'package:ichat_app/allConstants/color_constants.dart';
import 'package:ichat_app/allProviders/auth_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if(isLoggedIn){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage() ));
    return;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Loginpage() ));
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("images/splash.png",width: 300,height: 300,),
            SizedBox(height: 20,),
            Text("We Chat",style: TextStyle(color: ColorConstants.themeColor),),
            SizedBox(height: 20,),
            Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: ColorConstants.themeColor ,),
            )
          ],
        ),
      ),
    );
  }
}
