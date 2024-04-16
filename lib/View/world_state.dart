import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/world_state_record.dart';
import '../Services/state_services.dart';
import 'countries.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen();

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

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

    StatesServices stateServices = StatesServices();


    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),

          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01,),

               FutureBuilder(
                   future: stateServices.fetchWorldStatesRecord(),
                   builder: (context,AsyncSnapshot<WorldStateRecord> snapshot){

                     if(!snapshot.hasData){
                        return Expanded(
                          flex: 1,
                            child: SpinKitFadingCircle(
                              color: Colors.white,
                              size: 50,
                              controller: _controller,
                            )
                        );
                     }else{
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                'Total' : double.parse(snapshot.data!.cases.toString()),
                                'Recovered' : double.parse(snapshot.data!.recovered.toString()),
                                'Deaths' : double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
                              chartRadius: MediaQuery.of(context).size.width / 3.2,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                              animationDuration: const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),

                                
                                child: Column(

                                  children: [


                                    ReuseAbleRow(title: 'Total',value: snapshot.data!.cases.toString(),),
                                    ReuseAbleRow(title: 'Deaths',value: snapshot.data!.deaths.toString(),),
                                    ReuseAbleRow(title: 'Recovered',value: snapshot.data!.recovered.toString(),),
                                    ReuseAbleRow(title: 'Active',value: snapshot.data!.active.toString(),),
                                    ReuseAbleRow(title: 'Critical',value: snapshot.data!.critical.toString(),),
                                    ReuseAbleRow(title: 'Today Deaths',value: snapshot.data!.todayDeaths.toString(),),
                                    ReuseAbleRow(title: 'Today Recovered',value: snapshot.data!.todayRecovered.toString(),),
                                  ],
                                ),
                              ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesView()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(child: Text('Track Countries'),),
                              ),
                            )
                          ],
                        );
                     }
                   }
               ),
               


            ],
          ),
        ),
      ),
    );
  }
}
class ReuseAbleRow extends StatelessWidget {
  String title, value;
  ReuseAbleRow({Key? key, required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {



    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 5),
      child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 1,),
          const Divider(),
        ],
      ),
    );
  }
}
