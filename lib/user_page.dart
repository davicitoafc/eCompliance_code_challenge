import 'package:flutter/material.dart';
import 'package:e_compliance/model/user.dart';
import 'package:e_compliance/bloc/user_bloc.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: null,
      ),
      body: _userList(),
    );
  }

  Widget _userList() {
    return StreamBuilder(
      stream: bloc.userList,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return _progressIndicator();

        List<User> users = snapshot.data;

        return ListView.separated(
            itemCount: users.length,
            itemBuilder: (BuildContext context, int index) {
              User _user = users[index];

              return ListTile(
                onTap: () => showUserDetails(context, _user),
                title: Text(_user.name),
                leading: _avatar(_user),
              );
            },
            separatorBuilder: (context, index) => Divider());
      },
    );
  }

  void showUserDetails(BuildContext context, user) {
    Dialog userDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 400.0,
        width: 350.0,
        child: Column(
          children: <Widget>[
            _userModalAvatar(user),
            _userDetails(user),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            ),
          ],
        ),
      ),
    );
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => userDialog);
  }

  Widget _progressIndicator() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _userModalAvatar(user) {
    return Container(
      width: 140,
      height: 140,
      margin: EdgeInsets.only(top: 30),
      child: _avatar(user),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
      ),
    );
  }

  Widget _avatar(user) {
    return CachedNetworkImage(
      imageUrl: user.avatar,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) =>
          Image.asset('lib/assets/download.png'),
    );
  }

  Widget _userDetails(user) {
    final date = DateTime.parse(user.createdAt);
    final formattedDate = DateFormat('MMMM d, y hh:m a').format(date);

    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              user.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )),
        new Padding(
          padding: EdgeInsets.all(10),
          child: new Text(
            'id: ' + user.id,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        new Padding(
          padding: EdgeInsets.all(10),
          child: new Text(
            'created: ' + formattedDate,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        )
      ],
    );
  }
}
