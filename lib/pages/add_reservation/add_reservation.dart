import 'package:courtreserve/providers/courts.dart';
import 'package:courtreserve/providers/reservations.dart';
import 'package:courtreserve/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCourt extends StatefulWidget {
  @override
  _AddCourtState createState() => _AddCourtState();
}

class _AddCourtState extends State<AddCourt> {
  TextEditingController _name = TextEditingController();
  TextEditingController _date = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String courtId = "";
  double width;
  bool canReserve = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Reserve"),
        ),
        body: _widgetForm(context));
  }

  Widget _widgetForm(context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _widgetInputName(),
                SizedBox(height: 20),
                _widgetInputDate(),
                SizedBox(height: 20),
                _widgetDropdown(context)
              ],
            ),
            _submitBtn(context)
          ],
        ),
      ),
    );
  }

  Widget _widgetInputName() {
    return TextFormField(
      controller: _name,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Colors.black54,
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.green, width: 1)),
          hintText: "Full Name",
          focusColor: AppColors.green),
      onChanged: (String val) {
        setState(() {});
      },
      validator: (v) {
        if (v.length == 0) {
          return "Submit your name";
        }
        return null;
      },
    );
  }

  Widget _widgetInputDate() {
    return TextFormField(
      controller: _date,
      readOnly: true,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.calendar_today,
            color: Colors.black54,
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 1)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87, width: 1)),
          hintText: "Date",
          focusColor: AppColors.green),
      onTap: () => _selectDate(context),
      validator: (v) {
        if (v.length == 0) {
          return "Select a date";
        }
        return null;
      },
    );
  }

  Widget _widgetDropdown(context) {
    final cp = Provider.of<CourtsProvider>(context);

    return DropdownButtonFormField(
      validator: (v) {
        if (v.length == 0) {
          return "Select a court";
        }
        if (canReserve) {
          return "This court has reached the limit of players";
        }
        return null;
      },
      isExpanded: true,
      itemHeight: 70,
      value: null,
      onChanged: (e) {
        // if (rp.reservations.where((el) => el["id"] == courtId).length == 3) {
        //   setState(() {
        //     canReserve = false;
        //   });
        // } else {
        //   setState(() {
        //     canReserve = true;
        //   });
        // }
      },
      items: cp.courts
          .map((e) => DropdownMenuItem(
                value: e,
                onTap: () {
                  setState(() {
                    print(e);
                    courtId = e["id"];
                  });
                },
                child: Container(
                    padding: EdgeInsets.only(left: 16), child: Text(e['name'])),
              ))
          .toList(),
      isDense: true,
      hint: Container(
        padding: EdgeInsets.only(left: 14),
        child: Text("Select a court"),
      ),
    );
  }

  Widget _submitBtn(context) {
    final rp = Provider.of<ReservationsProvider>(context);

    return Container(
        child: InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          print(_name.text);
          print(_date.text);

          rp.add({
            "courtId": courtId,
            "date": _date.text,
            "user": _name.text,
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.green, borderRadius: BorderRadius.circular(7)),
        padding: EdgeInsets.symmetric(vertical: 14),
        alignment: Alignment.center,
        width: width,
        child: Text(
          "Add Reservation",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ));
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime.now(),
        lastDate: DateTime(2025),
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: AppColors.green,
              ),
            ),
            child: child,
          );
        });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }
}
