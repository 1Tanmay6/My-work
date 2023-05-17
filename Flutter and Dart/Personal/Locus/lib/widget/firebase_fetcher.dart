import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/data.dart';
import 'fetch.dart';
import '../Screens/details.dart';

class FireBaseFetcher extends StatefulWidget {
  final Stream<List<Data>> stream;

  const FireBaseFetcher(this.stream);
  static const routeName = '/fetcher';

  @override
  State<FireBaseFetcher> createState() => _FireBaseFetcherState();
}

class _FireBaseFetcherState extends State<FireBaseFetcher> {
  void launcher() async {
    String url = "https://mytree.cyclic.app/?id=${Fetch.sorterid}";
    await launch(url); // launching
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        title: const Text('Your Trees'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          // mini: false,
          // backgroundColor: Theme.of(context).accentColor,
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).accentColor),
              fixedSize: MaterialStateProperty.all(
                Size.fromWidth(150),
              ),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)))),

          onPressed: () => launcher(),
          child: FittedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  'lib/assests/Animation/icons8-location-unscreen.gif',
                  fit: BoxFit.cover,
                  height: 23,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Go To Map',
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                )
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder(
          stream: widget.stream,
          builder: ((context, snapshot) {
            if (snapshot.hasError) {
              return Text('ERROR: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final data = snapshot.data as List<Data>;

              return ListView(
                children: data.map(buildUser).toList(),
              );
            } else {
              return CircularProgressIndicator(
                color: Theme.of(context).accentColor,
              );
            }
          }),
        ),
      ),
    );
  }

  Widget buildUser(Data data) {
    if (data.id.toString() == Fetch.sorterid) {
      return InkWell(
        onTap: () {
          print(data.address);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => Details(
                        lat: data.lat,
                        long: data.long,
                        add: data.address,
                        title: data.treeid,
                      ))));
        },
        child: Card(
          color: Theme.of(context).accentColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: const EdgeInsets.all(10),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.asset(
                          alignment: Alignment.topCenter,
                          'lib/assests/images/detailsImg/${data.treeid}.png',
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'lib/assests/images/Error/error.png',
                          fit: BoxFit.cover,
                        );
                      })),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'lib/assests/images/tree.png',
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text('Tree Name')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Bootstrap.card_heading),
                        const SizedBox(
                          width: 4,
                        ),
                        Text('${data.treeid}')
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return const SizedBox(
        height: 0,
      );
    }
  }
}
