import 'dart:async';
import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return new MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fruit and Nut Cultivars Database (FNCD)',
            theme: new ThemeData(
                primarySwatch: Colors.red,
            ),
            home: new BasicPage(),
        );
    }

}

class BasicPage extends StatefulWidget {
    // ExamplePage({ Key key }) : super(key: key);
    @override
    _BasicAppBarState createState() => _BasicAppBarState();
}


class _BasicAppBarState extends State<BasicPage> {

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Contact Us'),
            ),
            body: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    _buildTopCard(),
                    _buildCard(),

                ],
            ),
        );

    }
}


Widget _buildCard() => SizedBox(
    height: 210,
    child: Card(
        child: Column(
            children: [
                ListTile(
                    title: Text('College of Agricultural, Human, and Natural Resource Sciences',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text('Pullman, WA 99164'),
                    leading: Icon(
                        Icons.school,
                        color: Colors.blue[500],
                    ),
                ),
                Divider(),
                ListTile(
                    title: Text('(509) 335-3564',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                        Icons.contact_phone,
                        color: Colors.blue[500],
                    ),
                ),
                ListTile(
                    title: Text('http://www.fruitandnutlist.org'),
                    leading: Icon(
                        Icons.web,
                        color: Colors.blue[500],

                    ),
                ),
            ],
        ),
    ),
);

Widget _buildTopCard() => SizedBox(
    child: Card(
        child: Column(
            children: [
                new Container(
                    constraints: BoxConstraints.expand(height: 200),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            image: AssetImage('img/map.png'),
                            fit: BoxFit.cover
                        ),
                    ),
                ),
            ],
        ),
    ),
);