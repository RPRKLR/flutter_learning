import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:provider/provider.dart';

import '../models/user.dart' as model;
import '../providers/user_provider.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    model.User? user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text(user.email),
            ),
    );
  }
}
