import 'dart:async';

import 'package:ccaexplorer/common_method/common_method_authentication.dart';
import 'package:ccaexplorer/src/authentication_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Club {
  String id;
  String bgImg;
  String icon;
  String name;
  String type;
  String score;
  num download;
  num review;
  String desc;
  String contact;
  List<String> imgs;
  String clubnum;
  bool isMember;
  Club(
      this.id,
      this.bgImg,
      this.icon,
      this.name,
      this.type,
      this.score,
      this.download,
      this.review,
      this.desc,
      this.contact,
      this.imgs,
      this.clubnum,
      this.isMember);

  static List<Club> generateClubs(
      String id,
      String logourl,
      String clubname,
      String category,
      String description,
      String membernum,
      String rating,
      String contact,
      bool isMember) {
    return [
      Club(
        id,
        logourl,
        logourl,
        clubname,
        category,
        rating,
        300,
        400,
        description,
        'Tel:$contact',
        [
          'assets/club/album1.JPG',
          'assets/club/album2.JPG',
          'assets/club/album3.JPG',
        ],
        membernum,
        isMember,
      ),
    ];
  }
}
