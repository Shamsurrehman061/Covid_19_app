import 'package:covid_19_app/home_page.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.todayDeaths, required this.deaths, required this.critical, required this.countryName
  , required this.flag, required this.recovery, required this.todayRecovery, required this.cases}) : super(key: key);

  final String countryName;
  final String flag;
  final int deaths;
  final int recovery;
  final int critical;
  final int todayRecovery;
  final int todayDeaths;
  final int cases;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.countryName),
        centerTitle: true,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:
        [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children:
                    [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ReusableRow(value: widget.cases.toString(), title: "Cases"),
                      ReusableRow(value: widget.deaths.toString(), title: "Deaths"),
                      ReusableRow(value: widget.recovery.toString(), title: "Recovery"),
                      ReusableRow(value: widget.critical.toString(), title: "Critical"),
                      ReusableRow(value: widget.todayDeaths.toString(), title: "Today Deaths"),
                      ReusableRow(value: widget.todayRecovery.toString(), title: "Today Recovery"),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.flag),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
