import 'package:flutter/material.dart';

import '../Services/state_services.dart';

class CountriesView extends StatefulWidget {
  const CountriesView();

  @override
  State<CountriesView> createState() => _CountriesViewState();
}

class _CountriesViewState extends State<CountriesView> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    StatesServices stateServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),

      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchController,
                onChanged: (_){
                  setState(() {

                  });
                },

                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  )
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: stateServices.countryListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10,width: 89,color: Colors.white,),
                                  subtitle: Container(height: 10,width: 89,color: Colors.white,),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )

                              ],
                            );
                          });
                    }else{

                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){

                            String name = snapshot.data![index]['country'];

                            if(searchController.text.isEmpty){
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                  )

                                ],
                              );
                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                  )

                                ],
                              );
                            }else{
                              return Container();
                            }


                      });
                    }
                  },
                )
            )
          ], 
        ),
      ),


    );
  }
}


