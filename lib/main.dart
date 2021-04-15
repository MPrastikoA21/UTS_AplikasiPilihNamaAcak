import 'package:flutter/material.dart';
import './profile/profile.dart';
import 'dart:math';

void main() => runApp(RandomPicker());

class RandomPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Add();
  }
}

class LastPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LastPage();
  }
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text(
            "Random Name Picker",
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 20.0,
                fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.greenAccent[700],
              ),
              onPressed: () {},
            ), // IconButton
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                      title: new Center(
                          child: new Image.network(
                    "https://lh3.googleusercontent.com/-l5MINSTzqyo/YHXdxG2djiI/AAAAAAAAIkM/mPUNRhnV1wsd5eYMU0zziS_IJYBXuBqhQCNcBGAsYHQ/0231_secret-person_PNG-1024x768.png",
                    width: 300.0,
                    height: 300.0,
                  ))),
                  ListTile(
                      title: new Center(
                          child: new Text(
                              " Klik 'Sentuh Untuk Lanjut' Lalu Masukan Nama",
                              style: TextStyle(color: Colors.black)))),
                  ListTile(
                      title: new Center(
                          child: new Text(
                              " Klik 'Pilih Acak' Untuk Melihat Salah Satu Nama",
                              style: TextStyle(color: Colors.black)))),
                  ListTile(),
                  ListTile(
                      title: new Builder(
                          builder: (context) => ElevatedButton(
                                child: Text("Sentuh untuk Lanjut"),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Add()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.greenAccent[700]),
                              ))),
                ],
              ),
            ),
          ],
        ));
  }
}

class _Add extends State<Add> {
  static List<String> names = [];
  static String rname;
  TextEditingController kontrolnama = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }),
          title: Text(
            "Daftar Nama",
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 20.0,
                fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      names.removeAt(index);
                    });
                  },
                  child: ListTile(
                    title: Text(names[index],
                        style: TextStyle(color: Colors.black)),
                  ),
                );
              },
            )),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      "Tambahkan Nama",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: kontrolnama,
                            decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 10, bottom: 10),
                                isDense: true),
                          ),
                        ),
                        ElevatedButton(
                          child: Text("Tambah"),
                          onPressed: () {
                            tambahNama();
                            kontrolnama.clear();
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent[800]),
                        )
                      ],
                    ),
                    Builder(
                        builder: (context) => ElevatedButton(
                              child: Text("Pilih Acak"),
                              onPressed: () {
                                var random = Random();
                                rname = names[random.nextInt(names.length)];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LastPage()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent[700]),
                            ))
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void tambahNama() {
    if (kontrolnama.text.isNotEmpty) {
      setState(() {
        names.add(kontrolnama.text);
      });
    }
  }

  void hapusNama() {
    names.remove(rname);
  }
}

class _LastPage extends State<LastPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text(
            "Nama Yang Terpilih",
            style: TextStyle(
                color: Colors.grey[100],
                fontSize: 20.0,
                fontWeight: FontWeight.w900),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent[400],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                      title: Text(_Add.rname,
                          style: TextStyle(color: Colors.black))),
                ],
              ),
            ),
            Builder(
                builder: (context) => ElevatedButton(
                      child: Text("Simpan"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Add()),
                        );
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    )),
            Builder(
                builder: (context) => ElevatedButton(
                      child: Text("Hapus"),
                      onPressed: () {
                        _Add.names.remove(_Add.rname);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Add()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.redAccent[700]),
                    ))
          ],
        ));
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
              image: DecorationImage(
                image: NetworkImage(
                    'https://lh3.googleusercontent.com/-BDSXasEOJq0/YGKjO3Pe9CI/AAAAAAAAIiY/IUzA7GO1FlgT-nra7GwvDCTanbgml__uwCNcBGAsYHQ/pexels-daria-obymaha-1684149.jpg'),
                fit: BoxFit.cover,
              ),
              color: Colors.deepPurpleAccent[400],
            ),
          ),
          ListTile(
            leading: Icon(Icons.adjust_outlined),
            title: Text('Random Name Picker'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle_rounded),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
