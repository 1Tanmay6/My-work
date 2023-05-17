import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Details extends StatelessWidget {
  final lat;
  final long;
  final add;
  final title;

  Details(
      {required this.lat,
      required this.long,
      required this.add,
      required this.title});

  Widget _buildSectionTitle(String text, BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(ctx).secondaryHeaderColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildcardTitle(String text, BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(ctx).secondaryHeaderColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Theme.of(context).secondaryHeaderColor,
        title: Text('${title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                border: Border.all(
                    color: Theme.of(context).secondaryHeaderColor, width: 1),
              ),
              height: (media.size.height - media.padding.top) * 0.6,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                child: Image.asset(
                  alignment: Alignment.topCenter,
                  'lib/assests/images/detailsImg/${title}.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'lib/assests/images/Error/error.png',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            _buildSectionTitle('Descritption', context),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).accentColor, width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor),
              padding: const EdgeInsets.all(10),
              height: (media.size.height - media.padding.top) * 0.3,
              width: media.size.width * 0.9,
              child: const Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: TextStyle(color: Colors.black),
              ),
            ),
            _buildSectionTitle('Coordinates', context),
            Container(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).accentColor,
                    ),
                    height: 100,
                    width: media.size.width * 0.35,
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).accentColor,
                      child: Column(
                        children: [
                          _buildcardTitle('Latitude', context),
                          Text(lat)
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).accentColor,
                    ),
                    height: 100,
                    width: media.size.width * 0.35,
                    child: Card(
                      elevation: 0,
                      color: Theme.of(context).accentColor,
                      child: Column(
                        children: [
                          _buildcardTitle('Longitude', context),
                          Text(long)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildSectionTitle('Address', context),
            Center(
              child: Card(
                color: Theme.of(context).accentColor,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    add,
                    style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: media.size.height * 0.008,
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: ElevatedButton(
                // mini: false,
                // backgroundColor: Theme.of(context).accentColor,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).accentColor),
                    fixedSize: MaterialStateProperty.all(Size.fromWidth(
                        MediaQuery.of(context).size.width * 0.25)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)))),

                onPressed: (() async {
                  String url = "https://maps.google.com/?q=${lat},${long}";
                  launch(url);
                }),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'lib/assests/Animation/icons8-place-marker-unscreen.gif',
                      fit: BoxFit.cover,
                      height: 23,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Plot',
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   child: Column(
    //     children: [Text(lat), Text(long), Text(add)],
    //   ),
    // );
  }
}
