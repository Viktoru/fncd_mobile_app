import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

void main() => runApp(new Home());

class Home extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return new MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fruit and Nut Cultivars Database (FNCD)',
            theme: new ThemeData(
                primarySwatch: Colors.red,
            ),
            home: new ExamplePage(),
        );
    }
}

class ExamplePage extends StatefulWidget {
    // ExamplePage({ Key key }) : super(key: key);
    @override
    _ExamplePageState createState() => new _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
    // final formKey = new GlobalKey<FormState>();
    // final key = new GlobalKey<ScaffoldState>();
    var _isLoading = true;
    final TextEditingController _filter = new TextEditingController();
    final dio = new Dio();

    String _searchText = "";
    List titleData = new List();

    List filteredNames = new List();
    Icon _searchIcon = new Icon(Icons.search);
    Widget _appBarTitle = new Text('Search Cultivar');

    _ExamplePageState() {
        _filter.addListener(() {
            if (_filter.text.isEmpty) {
                setState(() {
                    _searchText = "";
                    filteredNames = titleData;
                });
            } else {
                setState(() {
                    _searchText = _filter.text;
                });
            }
        });
    }

    @override
    void initState() {
        this._getNames();
        super.initState();
    }

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: _buildBar(context),
            body: new Center(
                child: _isLoading ? new CircularProgressIndicator() : _buildList(),
            ),
            resizeToAvoidBottomPadding: true,
        );
    }

    Widget _buildBar(BuildContext context) {
        return new AppBar(
            centerTitle: true,
            title: _appBarTitle,
            leading: new IconButton(
                icon: _searchIcon,
                onPressed: _searchPressed,
            ),
            actions: <Widget>[
                new IconButton(
                    icon: new Icon(Icons.refresh),
                    onPressed: () {
                        print("Reloading...");
                        setState(() {
                            _isLoading = false;
                        });
                    }),
            ],
        );
    }

    Widget _buildList() {
        if (!(_searchText.isEmpty)) {
            List tempList = new List();
            for (int i = 0; i < filteredNames.length; i++) {
                if (filteredNames[i]['title']
                    .toLowerCase()
                    .contains(_searchText.toLowerCase())) {
                    tempList.add(filteredNames[i]);
                }
            }
            filteredNames = tempList;
        }
        return ListView.builder(
            itemCount: titleData == null ? 0 : filteredNames.length,
            itemBuilder: (BuildContext context, int index) {
                return new ListTile(
                    title: Text(filteredNames[index]['title'],
                        style: new TextStyle(fontFamily: 'Releway', fontSize: 16.0)),
                    subtitle: Text(filteredNames[index]['field_mlfruitandnut_crop']),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.red, size: 30.0),
                    onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    NextPage(value: filteredNames[index]['body'])),
                        );
                    }

                    //=> print(filteredNames[index]['title']),
                );
            });
    }

    void _searchPressed() {
        setState(() {
            if (this._searchIcon.icon == Icons.search) {
                this._searchIcon = new Icon(Icons.close);
                this._appBarTitle = new TextField(
                    controller: _filter,
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
                );
            } else {
                this._searchIcon = new Icon(Icons.search);
                this._appBarTitle = new Text('Search Cultivar');
                filteredNames = titleData;
                _filter.clear();
            }
        });
    }

    void _getNames() async {
        final response = await dio.get('../data/json');
        if (response.statusCode == 200) {
            setState(() {
                _isLoading = false;
            });
            print(response.data);
        }

        List tempList = new List();

        for (int i = 0; i < response.data['data'].length; i++) {
            tempList.add(response.data['data'][i]);
        }

        setState(() {
            titleData = tempList;
            titleData.shuffle();
            filteredNames = titleData;
        });
    }
}

class NextPage extends StatefulWidget {
    String value;
    NextPage({Key key, this.value}) : super(key: key);

    @override
    _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
    @override
    Widget build(BuildContext context) {
        var html = (widget.value);
        String markdown = html2md.convert(html);
        //new MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(p: Theme.of(context).textTheme.body1.copyWith(fontSize: 23.0));
//  new Markdown(data: markdown);  Symbolic code...
        return new Scaffold(
            appBar: new AppBar(
                title: new Text("Next Page"),
            ),
            body: new Column(
                children: <Widget>[
                    Text(' '),
                    Text('DESCRIPTION', style: TextStyle(fontFamily: 'OpenSans', fontSize: 20.0)),
                    new Container(
                        padding: const EdgeInsets.all(10.0),
                        alignment: Alignment.centerLeft,
                        // MarkdownBody or source as a string: dart html
                        child: new MarkdownBody(
                            data: markdown,
                        ),
                    ),
                ],
            ),

            //new Text("${widget.value}"),
        );
    }
}
