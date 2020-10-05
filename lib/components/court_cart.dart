import 'package:courtreserve/providers/reservations_provider.dart';
import 'package:courtreserve/services/weatherRest.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CourtCart extends StatefulWidget {
  int type;
  int index;
  Map data;
  Map realData;
  Key key;
  CourtCart({key, this.type, this.data, this.index}) : super(key: key);
  @override
  _CourtCartState createState() => _CourtCartState();
}

class _CourtCartState extends State<CourtCart> {
  double width;
  double height;
  bool isCourt;
  String weather = '';
  String date;
  @override
  void initState() {
    super.initState();
    setState(() {
      isCourt = widget.type == 0;
    });

    if (!isCourt) {
      DateTime picked =
          DateTime.fromMillisecondsSinceEpoch(widget.data['date']);
      date = "${picked.day}/${picked.month}/${picked.year}";
      RestWeather.latlon(widget.data['geo'], widget.data['date'].toString())
          .then((value) {
        print(value);
        setState(() {
          weather = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Dismissible(
      direction: null,
      key: Key(isCourt ? widget.data["courtId"] : widget.index.toString()),
      confirmDismiss: (d) async {
        return await _showConfirmation(context, "Delete") == true;
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Color(0xffdcdcdc)))),
        child: Row(
          children: [
            Container(
              width: width * 0.3,
              height: height * 0.12,
              decoration: BoxDecoration(
                  color: Color(0xff21BEBC),
                  image: DecorationImage(
                      image: NetworkImage(widget.data['img']),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(7)),
              // child:
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10),
                Container(
                  child: isCourt
                      ? null
                      : Text(
                          widget.data["player"],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                ),
                Container(
                  width: width * 0.5,
                  child: Text(
                    widget.data['name'],
                    overflow:
                        isCourt ? TextOverflow.clip : TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  child: isCourt
                      ? null
                      : Row(
                          children: [
                            // from firestore
                            Icon(
                              Icons.calendar_today,
                              size: 18,
                            ),
                            SizedBox(width: 2),
                            Text(date,
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                            SizedBox(width: 10),
                            // from time api
                            Icon(
                              Icons.cloud_circle,
                              size: 18,
                            ),
                            SizedBox(width: 2),
                            Text(weather,
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                          ],
                        ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _showConfirmation(BuildContext context, String action) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Delete"),
            content: Text("Are you sure?"),
            actions: [
              RaisedButton(
                onPressed: () {
                  final rp = Provider.of<ReservationsProvider>(context);
                  rp.remove(widget.realData).then((res) {
                    Navigator.pop(context, true);
                  });
                },
                child: Text("Delete"),
              ),
              RaisedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text("Cancel"),
              )
            ],
          );
        });
  }
}
