import 'package:flutter/material.dart';
import 'package:note_app/AddNewNote.dart';
import 'package:note_app/EditNote.dart';
import 'package:note_app/sqldb_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Sqldb sqldb = Sqldb(dataname: 'noteapp.db',tablename: 'notes');

  Future<List<Map>> readdata() async {
    List<Map> response = await sqldb.readdata();
    return response;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.white12,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/x');
            },
            tooltip: 'Add New Note',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 21,
          ),
        ],
        title: const Text('notes'),
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: readdata(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SizedBox(
                            height: 100,
                            child: Card(
                                elevation: 8.0,
                                child: Column(

                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Text('${snapshot.data![index]['name']}'),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                            '${snapshot.data![index]['value']}'),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                            '${snapshot.data![index]['color']}'),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        IconButton(
                                            iconSize: 40,
                                            tooltip: 'delete',
                                            color: Colors.redAccent,
                                            onPressed: () async {
                                              setState(() {});
                                              int response = await sqldb.deletedata(
                                                  'DELETE FROM notes WHERE id = ${snapshot.data![index]['id']} ');
                                            },
                                            icon: const Icon(
                                                Icons.remove_circle_outlined)),
                                        IconButton(
                                            iconSize: 35,
                                            tooltip: 'edit',
                                            color: Colors.green,
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditNote(
                                                            id: snapshot.data![
                                                                index]['id'],
                                                            value:snapshot.data![index]['value'] ,
                                                            name: snapshot.data![index]['name'],
                                                            color: snapshot.data![index]['color'],
                                                            
                                                          )));
                                            },
                                            icon: const Icon(Icons.edit))
                                      ],
                                    )
                                  ],
                                )),
                          ),
                        );
                      });
                }
                return const Center(child: CircularProgressIndicator());
              })
        ],
      ),
    );
  }
}
