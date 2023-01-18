import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ichat_app/alScreens/login_page.dart';
import 'package:ichat_app/alScreens/setting_page.dart';
import 'package:ichat_app/allConstants/color_constants.dart';
import 'package:ichat_app/allProviders/auth_provider.dart';
import 'package:ichat_app/allmodels/popup_choices.dart';
import 'package:ichat_app/main.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _limitIncrement = 20;
  String _textSearch ="";
  bool isLoading =false;

  late String currentUserId;
  late AuthProvider authProvider;
  //late HomeProvider homeProvider;

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(title: 'Settings',icon: Icons.settings),
    PopupChoices(title: 'Sign out',icon: Icons.exit_to_app),
  ];

  Future<void> handleSignOut() async{
    authProvider.handleSignOut();
    Navigator.push(context, MaterialPageRoute(builder: (context)=> Loginpage()));
  }
  void scrollListener(){
    if(listScrollController.offset >= listScrollController.position.maxScrollExtent && !listScrollController.position.outOfRange){
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

void onItemMenuPress(PopupChoices choice){
  if(choice.title == "Sign out"){
    handleSignOut();
    }
  else{
     Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
  }
}


  Widget buildPopupMenu(){
    return PopupMenuButton<PopupChoices>(
      icon: Icon(Icons.more_vert,color: Colors.grey,),
        onSelected: onItemMenuPress,
        itemBuilder: (BuildContext context){
          return choices.map((PopupChoices choice){
            return PopupMenuItem<PopupChoices>(
              value: choice,
                child: Row(
                  children: <Widget>[
                     Icon(
                      choice.icon,
                      color: ColorConstants.primaryColor,
                    ),
                    Container(
                      width: 10,
                    ),
                    Text(
                      choice.title,
                    style: TextStyle(color: ColorConstants.primaryColor),
                    )
            ],
                )
            );
          }
          ).toList();
        }
    );
  }

  @override
  void initState() {
    super.initState();
    authProvider = context.read<AuthProvider>();
    //homeProvider = context.read<HomeProvider>();

    if(authProvider.getUserFirebaseId()?.isNotEmpty == true){
      currentUserId = authProvider.getUserFirebaseId()!;
    }
    else{
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Loginpage()), (Route<dynamic> route) => false);
    }
    listScrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar:  AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        leading: IconButton(
          icon: Switch(
            value: isWhite,
            onChanged: (value){
              setState(() {
                isWhite = value;
                print(isWhite);
              });
            },
            activeColor: Colors.white,
            activeTrackColor: Colors.grey,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.white,
          ),
          onPressed: ()=> "",
        ),
        actions: <Widget>[
          buildPopupMenu(),
        ],
      ),
    );
  }
}


