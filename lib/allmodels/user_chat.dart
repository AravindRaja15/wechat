import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ichat_app/allConstants/constants.dart';

class UserChat{
  String id;
  String photoUrl;
  String nickname;
  String aboutMe;
  String phoneNumber;

  UserChat({
    required this.id,
    required this.phoneNumber,
    required this.nickname,
    required this.aboutMe,
    required this.photoUrl,
  });

  Map<String, String> toJson(){
    return{
      FirestoreConstants.nickname : nickname,
      FirestoreConstants.aboutMe : aboutMe,
      FirestoreConstants.photoUrl : photoUrl,
      FirestoreConstants.phoneNumber : phoneNumber,
    };
  }

  factory UserChat.fromDocument(DocumentSnapshot doc){
    String aboutMe ="";
    String photourl ="";
    String nickname ="";
    String phoneNumber ="";
    try{
      aboutMe =doc.get(FirestoreConstants.aboutMe);
    }catch (e){}
    try{
      aboutMe =doc.get(FirestoreConstants.photoUrl);
    }catch (e){}
    try{
      aboutMe =doc.get(FirestoreConstants.nickname);
    }catch (e){}
    try{
      aboutMe =doc.get(FirestoreConstants.phoneNumber);
    }catch (e){}
    return UserChat(
        id: doc.id,
        phoneNumber: phoneNumber,
        nickname: nickname,
        aboutMe: aboutMe,
        photoUrl: photourl,
    );

  }
}