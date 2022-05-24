import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:com.firebase_test/globals.dart';

class ListItem{
  int value;
  String name;
  ListItem(this.value, this.name);
}
DateTime now = DateTime.now();
String formattedDate = DateFormat('dd MMMM yyyy').format(now);

final FirebaseAuth _auth = FirebaseAuth.instance;

class buatLaporan extends StatefulWidget {
  // final FirebaseAuth _auth = FirebaseAuth.instance;

  buatLaporan({Key key}) : super(key: key);

  @override
  State<buatLaporan> createState() => _buatLaporanState();

}



class _buatLaporanState extends State<buatLaporan> {
  // final Future<FirebaseApp> _future = Firebase.initializeApp();
  final databaseRef = FirebaseDatabase.instance.reference(); //database reference object

  String emailnya = Singleton().emailnya;

  void addData(
      String submitDate,
      emailUser,
      project_name,
      reqDate,
      targetDate,
      adrfNum,
      adrfTitle,
      reqDesc,
      classNJ,
      reqStatus,
      uatDoc,
      uatDate,
      signOffDate,
      uatStatus,
      deployDate,
      notes) {
    databaseRef.child("Reports").push().set({
      'Submitted date' : submitDate,
      'Email Account' : emailUser,
      'Nama Project': project_name,
      'Request Date': reqDate,
      'Target Delivery Date': targetDate,
      'ADRF Number' : adrfNum,
      'Title' : adrfTitle,
      'Request Desc' : reqDesc,
      'Class' : classNJ,
      'Request Status' : reqStatus,
      'UAT Doc Number' : uatDoc,
      'UAT Date' : uatDate,
      'Sign Off Date' : signOffDate,
      'UAT Status' : uatStatus,
      'Deployment Date' : deployDate,
      'Notes' : notes
      });

  }

  List<DropdownMenuItem<String>> get classJN{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Class J (Major)"),value: "J"),
      DropdownMenuItem(child: Text("Class N (Minor)"),value: "N"),
    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get reqStatus{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Request Status Done"),value: "Done"),
      DropdownMenuItem(child: Text("Request On Progress"),value: "On Progress"),
    ];
    return menuItems;
  }
  List<DropdownMenuItem<String>> get uatStatus{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text(""),value: ""),
      DropdownMenuItem(child: Text("UAT Status Cancelled"),value: "Cancelled"),
      DropdownMenuItem(child: Text("UAT Status Success"),value: "Success"),
    ];
    return menuItems;
  }
  String selectedClass = "N";
  String selectedStatus = "Done";
  String selectedUatStatus = "";
  var _requestDateController = TextEditingController();
  var _targetDateController = TextEditingController();
  var _uatDateController = TextEditingController();
  var _signOffDateController = TextEditingController();
  var _deployDateController = TextEditingController();
  var _namaProjectcontroller = TextEditingController();
  var uatDocController = TextEditingController();
  var adrfNumController = TextEditingController();
  var adrfTitleController = TextEditingController();
  var _reqDescController = TextEditingController();
  var notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double nilaiSlider = 1;
  bool adrfCheckBox = false;
  bool uatCheckBox = false;
  bool nilaiSwitch = true;
  DateTime _requestDateTime = DateTime.now();
  DateTime _targetDateTime = DateTime.now();
  DateTime _uatDateTime = DateTime.now();
  DateTime _signOffDateTime = DateTime.now();
  DateTime _deployDateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _requestDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _requestDateTime = _pickedDate;
        _requestDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }
  _selectedTodoDate1(BuildContext context) async {
    var _pickedDate1 = await showDatePicker(
        context: context,
        initialDate: _targetDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate1 != null) {
      setState(() {
        _targetDateTime = _pickedDate1;
        _targetDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate1);
      });
    }
  }
  _uatTodoDate(BuildContext context) async {
    var _pickedDate2 = await showDatePicker(
        context: context,
        initialDate: _uatDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate2 != null) {
      setState(() {
        _uatDateTime = _pickedDate2;
        _uatDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate2);
      });
    }
  }
  _signOffTodoDate(BuildContext context) async {
    var _pickedDate3 = await showDatePicker(
        context: context,
        initialDate: _signOffDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate3 != null) {
      setState(() {
        _signOffDateTime = _pickedDate3;
        _signOffDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate3);
      });
    }
  }
  _deployTodoDate(BuildContext context) async {
    var _pickedDate4 = await showDatePicker(
        context: context,
        initialDate: _deployDateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate4 != null) {
      setState(() {
        _deployDateTime = _pickedDate4;
        _deployDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate4);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Buat Laporan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange, Colors.orange],
            )
          ),
      ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return ListView(
          children: [
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 20.0),
                child: Column(
                  children: [
                    // TextField(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _namaProjectcontroller,
                        decoration: InputDecoration(
                          hintText: "Wajib diisi",
                          labelText: "Nama Project",
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic),
                          // icon: Icon(Icons.access_alarm),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                            suffixIcon: IconButton(
                              onPressed: _namaProjectcontroller.clear,
                              icon: Icon(Icons.clear),
                            )
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wajib diisi';

                          }
                          return null;
                        },
                      ),
                    ),
                    Wrap(
                      children: [
                        Container(
                          width: 185,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: _requestDateController,
                                decoration: InputDecoration(
                                  labelText: 'Request Date',
                                  hintText: 'Wajib diisi',
                                  hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic),
                                  icon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  // prefixIcon: InkWell(
                                  //   onTap: () {
                                  //     _selectedTodoDate(context);
                                  //   },
                                  //   child: Icon(Icons.calendar_today),
                                  // ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  _selectedTodoDate(context);
                                  print(Singleton().emailnya);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Wajib diisi';
                                  }
                                  return null;
                                }
                                ),
                          ),
                        ),
                        Container(
                          width: 165,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: _targetDateController,
                                decoration: InputDecoration(
                                  labelText: 'Target Date',
                                  hintText: 'Wajib diisi',
                                  hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic),
                                  // icon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  // prefixIcon: InkWell(
                                  //   onTap: () {
                                  //     _selectedTodoDate(context);
                                  //   },
                                  //   child: Icon(Icons.calendar_today),
                                  // ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  _selectedTodoDate1(context);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Wajib diisi';
                                  }
                                  return null;
                                }
                                ),
                          ),
                        ),
                      ],
                    ),
                    CheckboxListTile(
                      title: Text('ADRF Fields'),
                      subtitle: Text('Centang ini untuk mengisi ADRF'),
                      value: adrfCheckBox,
                      activeColor: Colors.deepPurpleAccent,
                      onChanged: (bool adrfUpdateCheckbox) {
                        setState(() {
                          adrfCheckBox = adrfUpdateCheckbox;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          if(adrfCheckBox)
                          TextFormField(
                            controller: adrfNumController,
                            decoration: InputDecoration(
                                hintText: "(ADRF-xxx/xxx/xxx/xxxxx)",
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic),
                                labelText: "Nomor ADRF",
                                // icon: Icon(Icons.access_alarm),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                suffixIcon: IconButton(
                                  onPressed: adrfNumController.clear,
                                  icon: Icon(Icons.clear),
                                )
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Wajib diisi';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          if(adrfCheckBox)
                          TextFormField(
                            controller: adrfTitleController,
                            decoration: InputDecoration(
                                hintText: "Judul ADRF",
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic),
                                labelText: "Title",
                                // icon: Icon(Icons.access_alarm),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                suffixIcon: IconButton(
                                  onPressed: adrfTitleController.clear,
                                  icon: Icon(Icons.clear),
                                )
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Wajib diisi';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: _reqDescController,
                        decoration: InputDecoration(
                            hintText: "Kegiatan yang dilakukan",
                            labelText: "Request Description",
                            hintStyle: TextStyle(
                                fontStyle: FontStyle.italic),
                            // icon: Icon(Icons.access_alarm),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            suffixIcon: IconButton(
                              onPressed: _reqDescController.clear,
                              icon: Icon(Icons.clear),
                            )
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wajib diisi';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                          isExpanded: true,
                          value: selectedClass,
                          onChanged: (String newValue) {
                            setState(() {
                              selectedClass = newValue;
                            });
                            },
                          items: classJN,
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectedStatus,
                        onChanged: (String newValue) {
                          setState(() {
                            selectedStatus = newValue;
                          });
                        },
                        items: reqStatus,
                      ),
                    ),
                    CheckboxListTile(
                      title: Text('UAT Activity Fields'),
                      subtitle: Text('Centang ini untuk mengisi UAT'),
                      value: uatCheckBox,
                      activeColor: Colors.deepPurpleAccent,
                      onChanged: (bool uatUpdateCheckbox) {
                        setState(() {
                          uatCheckBox = uatUpdateCheckbox;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          if(uatCheckBox)
                            TextFormField(
                              controller: uatDocController,
                              decoration: InputDecoration(
                                  hintText: "(UAT/RDS-xxx/xxxx/xxxxx)",
                                  hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic),
                                  labelText: "Nomor Doc UAT",
                                  // icon: Icon(Icons.access_alarm),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  suffixIcon: IconButton(
                                    onPressed: uatDocController.clear,
                                    icon: Icon(Icons.clear),
                                  )
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Wajib diisi';
                                }
                                return null;
                              },
                            ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if(uatCheckBox)
                        Wrap(
                          children: [
                            Container(
                              width: 185,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    controller: _uatDateController,
                                    decoration: InputDecoration(
                                      labelText: 'UAT Date',
                                      hintText: 'Wajib diisi',
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.italic),
                                      icon: Icon(Icons.calendar_today),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0)),
                                      // prefixIcon: InkWell(
                                      //   onTap: () {
                                      //     _selectedTodoDate(context);
                                      //   },
                                      //   child: Icon(Icons.calendar_today),
                                      // ),
                                    ),
                                    readOnly: true,
                                    onTap: () {
                                      _uatTodoDate(context);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Wajib diisi';
                                      }
                                      return null;
                                    }
                                    ),
                              ),
                            ),
                            Container(
                              width: 165,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                    controller: _signOffDateController,
                                    decoration: InputDecoration(
                                      labelText: 'Sign Off Date',
                                      hintText: 'Wajib diisi',
                                      hintStyle: TextStyle(
                                          fontStyle: FontStyle.italic),
                                      // icon: Icon(Icons.calendar_today),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0)),
                                      // prefixIcon: InkWell(
                                      //   onTap: () {
                                      //     _selectedTodoDate(context);
                                      //   },
                                      //   child: Icon(Icons.calendar_today),
                                      // ),
                                    ),
                                    readOnly: true,
                                    onTap: () {
                                      _signOffTodoDate(context);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Wajib diisi';
                                      }
                                      return null;
                                    }
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        if(uatCheckBox)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            isExpanded: true,
                            value: selectedUatStatus,
                            hint: Text("Pilih salah satu"),
                            onChanged: (String newValue) {
                              setState(() {
                                selectedUatStatus = newValue;
                              });
                            },
                            items: uatStatus,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        if(uatCheckBox)
                        Container(
                          width: 350,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                                controller: _deployDateController,
                                decoration: InputDecoration(
                                  labelText: 'Deployment Date',
                                  hintText: 'Wajib diisi',
                                  hintStyle: TextStyle(
                                      fontStyle: FontStyle.italic),
                                  icon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                  // prefixIcon: InkWell(
                                  //   onTap: () {
                                  //     _selectedTodoDate(context);
                                  //   },
                                  //   child: Icon(Icons.calendar_today),
                                  // ),
                                ),
                                readOnly: true,
                                onTap: () {
                                  _deployTodoDate(context);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Wajib diisi';
                                  }
                                  return null;
                                }
                                ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        if(uatCheckBox)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: notesController,
                            decoration: InputDecoration(
                                hintText: "(Opsional)",
                                labelText: "Notes",
                                hintStyle: TextStyle(
                                    fontStyle: FontStyle.italic),
                                // icon: Icon(Icons.access_alarm),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                suffixIcon: IconButton(
                                  onPressed: notesController.clear,
                                  icon: Icon(Icons.clear),
                                )
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Wajib diisi';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     obscureText: true,
                    //     decoration: InputDecoration(
                    //       labelText: "Password",
                    //       // icon: Icon(Icons.security),
                    //       border: OutlineInputBorder(
                    //           borderRadius: BorderRadius.circular(10.0)),
                    //     ),
                    //     validator: (value) {
                    //       if (value.isEmpty) {
                    //         return 'Password tidak boleh kosong';
                    //       }
                    //       return null;
                    //     },
                    //   ),
                    // ),
                    // SwitchListTile(
                    //   title: Text('Backend Programming'),
                    //   subtitle: Text('Dart, Nodejs, PHP, Java, dll'),
                    //   value: nilaiSwitch,
                    //   activeTrackColor: Colors.pink[100],
                    //   activeColor: Colors.red,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       nilaiSwitch = value;
                    //     });
                    //   },
                    // ),
                    // Slider(
                    //   value: nilaiSlider,
                    //   min: 0,
                    //   max: 100,
                    //   onChanged: (value) {
                    //     setState(() {
                    //       nilaiSlider = value;
                    //     });
                    //   },
                    // ),
                    ElevatedButton(
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            addData(
                                formattedDate,
                              _auth.currentUser.email,
                              _namaProjectcontroller.text.toString(),
                              _requestDateController.text.toString(),
                              _targetDateController.text.toString(),
                              adrfNumController.text.toString(),
                              adrfTitleController.text.toString(),
                              _reqDescController.text.toString(),
                              selectedClass.toString(),
                              selectedStatus.toString(),
                              uatDocController.text.toString(),
                              _uatDateController.text.toString(),
                              _signOffDateController.text.toString(),
                              selectedUatStatus.toString(),
                              _deployDateController.text.toString(),
                              notesController.text.toString()
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
