import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../Screens/location_page.dart';
import '../widget/fetch.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static const List<Map<String, String>> creds = [
    {'name': 'Mudit', 'id': 'N1'},
    {'name': 'Amritanshu', 'id': 'N2'},
    {'name': 'Tanmay', 'id': 'N3'},
    {'name': 'Megha', 'id': 'N4'},
    {'name': 'Shounak', 'id': 'N5'}
  ];

  final _titleController = TextEditingController();
  final _iDController = TextEditingController();
  /*-------------------------------------------------------------*/
  void _comparator(String enteredName, String enteredID) async {
    bool login = false;
    Map<String, String> temp = {'name': enteredName, 'id': enteredID};
    for (int i = 0; i < creds.length; i++) {
      if (enteredName.replaceAll(' ', '') == creds[i]['name'] &&
          enteredID.replaceAll(' ', '') == creds[i]['id']) {
        login = true;

        Fetch.idFetcher(enteredID);
        Future.delayed(Duration(milliseconds: 250), () {
          Navigator.popAndPushNamed(context, LocationPage.routeName);
        });
      }
    }

    setState(() {
      log = login;
    });
  }

  bool log = false;
  void _submitData() {
    String enteredName = _titleController.text;
    String enteredID = _iDController.text;

    if (enteredName.isEmpty || enteredID.isEmpty) {
      return;
    } else {}

    _comparator(enteredName, enteredID);
  }

/*-------------------------------------------------------------*/
  bool flagName = false;
  bool flagID = false;
  bool ispotrait = true;

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller, bool log) async {
    Future.delayed(Duration(seconds: 1), () {
      _submitData();
      if (!log) {
        controller.success();
      } else {
        controller.success();
      }

      Future.delayed(Duration(seconds: 1), () {
        controller.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    var orientation = media.orientation;
    if (orientation == Orientation.portrait) {
      setState(() {
        ispotrait = true;
      });
    } else {
      setState(() {
        ispotrait = false;
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ispotrait
                      ? Container(
                          color: Theme.of(context).primaryColor,
                          height: media.size.height * 0.3,
                          child: ClipRRect(
                            child: Image.asset('lib/assests/images/login.png'),
                          ),
                        )
                      : SizedBox(),
                  ispotrait
                      ? Center(
                          child: Column(
                            children: [
                              const Text(
                                'Welcome!',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w500),
                              ),
                              const Text('Please Log in to continue',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        )
                      : Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.lock,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                  ispotrait
                      ? Divider(
                          endIndent: media.size.width * 0.2,
                          indent: media.size.width * 0.2,
                          thickness: 2,
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                  ...view(media)
                ])),
      ),
    );
  }

  List<Widget> view(MediaQueryData media) {
    if (ispotrait) {
      return [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(5),
            color: Theme.of(context).accentColor,
            child: TextField(
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor, fontSize: 19),
              textAlign: TextAlign.center,
              onTap: () {
                setState(() {
                  flagName = true;
                  flagID = false;
                });
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Bootstrap.person,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                suffixIcon: Icon(
                  Icons.keyboard_arrow_right_sharp,
                  color: Theme.of(context).accentColor,
                ),
                border: InputBorder.none,
                hintText: flagName ? '' : 'Enter Name',
                hintStyle: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontSize: 19),
              ),
              cursorColor: Theme.of(context).secondaryHeaderColor,
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
          ),
        ), // SizedBox(

        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            padding: const EdgeInsets.all(5),
            color: Theme.of(context).accentColor,
            child: TextField(
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor, fontSize: 19),
              textAlign: TextAlign.center,
              onTap: () {
                setState(() {
                  flagName = false;
                  flagID = true;
                });
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Bootstrap.key,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                  suffixIcon: Icon(
                    Bootstrap.key,
                    color: Theme.of(context).accentColor,
                  ),
                  hintText: flagID ? '' : 'Unique ID',
                  hintStyle: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 19),
                  border: InputBorder.none,
                  labelStyle:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor)),
              controller: _iDController,
              cursorColor: Theme.of(context).secondaryHeaderColor,
              onSubmitted: (_) => _submitData(),
            ),
          ),
        ),

        SizedBox(
          width: 150,
          height: media.size.height * 0.05,
          child: RoundedLoadingButton(
            color: Theme.of(context).accentColor,
            successColor: Theme.of(context).accentColor,
            successIcon:
                log ? Icons.how_to_reg_outlined : Icons.cancel_outlined,
            valueColor: Theme.of(context).secondaryHeaderColor,
            child: Text(
              'Login',
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor, fontSize: 17),
            ),
            controller: _btnController,
            onPressed: () {
              _doSomething(_btnController, log);
            },
          ),
        )
      ];
    } else {
      return [
        SingleChildScrollView(
            child: const Text(
          'Go back to potrait mode',
          style: TextStyle(fontSize: 20),
        ))
      ];
    }
  }
}
