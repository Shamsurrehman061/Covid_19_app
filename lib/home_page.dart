import 'package:covid_19_app/Services/apis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import 'Models/all_world_data.dart';
import 'SplashScreen/countries_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  Api api = Api();
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                FutureBuilder(
                    future: api.getAllWorldData(),
                    builder: (BuildContext context, AsyncSnapshot<AllWorldData> snapshot){
                      if (!snapshot.hasData){
                        return Center(
                          child: SpinKitFadingCircle(
                            color: Colors.white,
                            size: 50.0,
                          ),
                        );
                      } else
                        {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total cases": double.parse(snapshot.data!.cases.toString()),
                                "Total deaths": double.parse(snapshot.data!.deaths.toString()),
                                "Total recover": double.parse(snapshot.data!.recovered.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              animationDuration: const Duration(milliseconds: 1200),
                              legendOptions:
                              const LegendOptions(legendPosition: LegendPosition.left),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.08,
                            ),
                            Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString(),
                                  ),
                                  ReusableRow(
                                    title: "Death",
                                    value: snapshot.data!.deaths.toString(),
                                  ),
                                  ReusableRow(
                                    title: "Recover",
                                    value: snapshot.data!.recovered.toString(),
                                  ),
                                  ReusableRow(
                                    title: "Active",
                                    value: snapshot.data!.active.toString(),
                                  ),
                                  ReusableRow(
                                    title: "Critical",
                                    value: snapshot.data!.critical.toString(),
                                  ),
                                  ReusableRow(
                                    title: "Today Deaths",
                                    value: snapshot.data!.todayDeaths.toString(),
                                  ),
                                  ReusableRow(
                                    title: "Today recover",
                                    value: snapshot.data!.todayRecovered.toString(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const CountriesList())),
                              child: Container(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: const Center(
                                  child: Text("Track Countries"),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    }),



              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  const ReusableRow({Key? key, required this.value, required this.title})
      : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
