import 'package:flutter/material.dart';
import 'package:note_app/Homescreen.dart';
import 'package:note_app/sqldb_model.dart';

class EditNote extends StatefulWidget {
  const EditNote({required this.id,required this.name, required this.value, required this.color});

  final id;
  final name;
  final value;
  final color;


  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final _formkey = GlobalKey<FormState>();
  Sqldb sqldb = Sqldb();
  var name = TextEditingController();
  var value = TextEditingController();
  var color = TextEditingController();
  @override
  void initState() {
    name.text=widget.name;
    value.text=widget.value;
    color.text=widget.color;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            iconSize: 35,
            tooltip: 'edit',
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
            )),
        title: const Text('Add note'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              buildTextFiledForm(
                  Label: 'name', hint: 'name', icon: Icons.ac_unit, text: name),
              buildTextFiledForm(
                  hint: 'value', Label: 'value', icon: Icons.abc, text: value),
              buildTextFiledForm(
                  Label: 'color', hint: 'color', icon: Icons.man, text: color),
              const SizedBox(
                height: 15,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {});
                      int response;

                      if (_formkey.currentState!.validate()) {
                        response = await sqldb.updatedata(tablename: 'notes', value1: name.text, value2: value.text, value3: color.text, id: widget.id);

                        if (response > 0) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      }
                    },
                    child: const Text(' save'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTextFiledForm({
    required String? Label,
    required String? hint,
    required IconData? icon,
    required TextEditingController text,
  }) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
            controller: text,
            validator: (value) {
              if (value!.isEmpty) {
                return 'This filed must not be empty';
              }
              return null;
            },
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              suffixIcon: Icon(
                icon,
                color: Colors.blue,
              ),
              suffixIconColor: Colors.green,
              label: Text(Label!),
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            )),
      );
}
