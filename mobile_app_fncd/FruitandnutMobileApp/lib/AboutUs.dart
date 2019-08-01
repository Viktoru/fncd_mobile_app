import 'package:flutter/material.dart';
import 'package:path/path.dart';

class AboutUs extends StatelessWidget {
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
                title: const Text('About Us'),
            ),

            body: _buildBodyCard(),

        );
    }
}


Widget _buildBodyCard() => SizedBox(

    child: Card(
        child: Container(
            child: new Column(
                children: <Widget>[
                    new Card(
                        child: new Container(
                            padding: const EdgeInsets.all(10.0),
                            child: new Column(
                                children: <Widget>[
                                    new Text('Welcome', style: TextStyle(fontFamily: 'OpenSans', fontSize: 23.0),),
                                    new Text('The Fruit and Nut Cultivars Database (FNCD).'
                                        'From this site you can search and download all the information provided'
                                        'in the American Pomological Society.',
                                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0), ),
                                ],

                            ),
                        ),
                    ),
                    
                    new Card(
                        child: new Container(
                            padding: const EdgeInsets.all(10.0),
                            child: new Column(
                                children: <Widget>[
                                    new Text('Supported by a partnership of APS, ASHS, NRSP10,'
                                        'Industry and US Land Grant Universities',
                                        style: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0), ),
                                ],
                            ),
                        ),
                    )
                ],
            ),
        ),
    ),
);