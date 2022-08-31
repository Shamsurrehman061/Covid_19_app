import 'package:covid_19_app/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/apis.dart';
import '../home_page.dart';


class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {


  final TextEditingController _controller = TextEditingController();
  Api api = Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const HomePage()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:
            [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "Search here with country name"
                ),
                controller: _controller,
                onChanged: (value){
                  setState(() {
                  });
                },
              ),
              Expanded(
                flex: 3,
                child: FutureBuilder(
                  future: api.getCountryData(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot)
                  {
                    if(!snapshot.hasData)
                      {
                        return ListView.builder(
                          itemCount: 4,
                            itemBuilder: (context, index){
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(width: 50, height: 50, color: Colors.white,),
                                      title: Container(width: 90, height: 10, color: Colors.white,),
                                      subtitle: Container(width: 90, height: 10, color: Colors.white,),
                                    ),
                                  ],
                                ),
                            );
                        });
                      }
                    else
                      {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                            itemBuilder: (context, index){
                              String name = snapshot.data![index]['country'];

                              if(_controller.text.isEmpty)
                                {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) => DetailScreen(
                                          cases: snapshot.data![index]['cases'],
                                          deaths: snapshot.data![index]['deaths'],
                                          todayRecovery: snapshot.data![index]['todayRecovered'],
                                          countryName: snapshot.data![index]['country'],
                                          recovery: snapshot.data![index]['recovered'],
                                          critical: snapshot.data![index]['critical'],
                                          flag: snapshot.data![index]['countryInfo']['flag'],
                                          todayDeaths: snapshot.data![index]['todayDeaths'],)));
                                  },
                                        child: ListTile(
                                          leading: SizedBox(
                                            height: 50.0,
                                            width: 50.0,
                                            child: Image(
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                            ),
                                          ),
                                          title: Text(snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              else if(name.toLowerCase().contains(_controller.text))
                                {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => DetailScreen(
                                                cases: snapshot.data![index]['cases'],
                                                deaths: snapshot.data![index]['deaths'],
                                                todayRecovery: snapshot.data![index]['todayRecovered'],
                                                countryName: snapshot.data![index]['country'],
                                                recovery: snapshot.data![index]['recovered'],
                                                critical: snapshot.data![index]['critical'],
                                                flag: snapshot.data![index]['countryInfo']['flag'],
                                                todayDeaths: snapshot.data![index]['todayDeaths'],)));
                                        },
                                        child: ListTile(
                                          leading: SizedBox(
                                            height: 50.0,
                                            width: 50.0,
                                            child: Image(
                                              image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                            ),
                                          ),
                                          title: Text(snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]['cases'].toString()),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              else
                                {
                                  return Container();
                                }

                        });
                      }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
