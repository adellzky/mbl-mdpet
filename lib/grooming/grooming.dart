import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GroomingPage extends StatelessWidget {
  const GroomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Grooming(),
    );
  }
}

class Grooming extends StatefulWidget {
  const Grooming({super.key});

  @override
  State<Grooming> createState() => _GroomingState();
}

class _GroomingState extends State<Grooming> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    final _formKey = GlobalKey<FormState>();
    TextEditingController _date = TextEditingController();

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            "GROOMING",
            style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0XFFBE83B2),
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          expandedHeight: 12,
          backgroundColor: Color.fromARGB(255, 230, 230, 230),
          iconTheme: IconThemeData(color: Color(0XFFBE83B2)),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: mediaQuery.size.height / 12,
                decoration: BoxDecoration(
                    color: Color(0XFFBE83B2),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17))),
                child: Container(
                  margin: EdgeInsets.only(left: 30, top: 13),
                  child: Text(
                    'Grooming Schedules',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17))),
                padding: const EdgeInsets.all(16.0),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Time to Grooming at 1 November 2023',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Your pet have a grooming schedule at Monday, 1 November 2023, 5 PM',
                      style: TextStyle(fontSize: 15),
                    ),
                    Divider(height: 23, color: Colors.blueGrey, thickness: 1.0),
                    Text(
                      'Time to Grooming at 2 November 2023',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Your pet have a grooming schedule at Tuesday, 2 November 2023, 2 PM',
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                height: mediaQuery.size.height / 12,
                decoration: BoxDecoration(
                    color: Color(0XFFBE83B2),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(17),
                        bottomRight: Radius.circular(17))),
                child: Container(
                  margin: EdgeInsets.only(left: 30, top: 13),
                  child: Text(
                    'Grooming Form',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: mediaQuery.size.height / 1.4,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: _date,
                        decoration: const InputDecoration(
                          labelText: 'date',
                          icon: Icon(Icons.calendar_month_outlined),
                        ),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          if (pickeddate != null) {
                            print(
                                "Date Selected: ${pickeddate.day}-${pickeddate.month}-${pickeddate.year}");
                          }
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0XFFBE83B2)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Processing Data')));
                            }
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
