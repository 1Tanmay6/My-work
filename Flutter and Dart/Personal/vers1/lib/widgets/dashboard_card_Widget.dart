import 'package:flutter/material.dart';

class DashboardCardWidget extends StatefulWidget {
  const DashboardCardWidget({super.key});

  @override
  State<DashboardCardWidget> createState() => _DashboardCardWidgetState();
}

class _DashboardCardWidgetState extends State<DashboardCardWidget> {
  @override
  Widget build(BuildContext context) {
    final texttheme = Theme.of(context).textTheme;
    return ListView.builder(
      itemBuilder: (context, index) => Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.height * 0.25,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(8),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(colors: [
                    Colors.black.withOpacity(0.25),
                    Colors.black.withOpacity(0.2)
                  ])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Task',
                    style: texttheme.bodyMedium!.copyWith(fontSize: 19),
                  ),
                  Text(
                    'Connect your app to Supabase',
                    style: texttheme.bodyMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child:
                            Image.asset('lib/assets/images/logo/Tornado.png'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Supabase')
                    ],
                  )
                ],
              ),
            ),
          )),
      itemCount: 5,
      scrollDirection: Axis.horizontal,
    );
  }
}
