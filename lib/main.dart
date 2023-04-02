import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_application/view/tabbar/first_tab.dart';
import 'package:movie_application/view/tabbar/second_tab.dart';
import 'package:movie_application/view/tabbar/third_tab.dart';


import 'package:tmdb_api/tmdb_api.dart';

import 'controller/authcontroller.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.green),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final listCtrl = Get.put(AuthController());

  final String apikey = '95617d459fd606c6d69527cc2b0545e0';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NTYxN2Q0NTlmZDYwNmM2ZDY5NTI3Y2MyYjA1NDVlMCIsInN1YiI6IjY0MjdlMzcxOGE4OGIyMDA3NzMxOThkNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.g_vrA6CHKh6FD0jq9bwOic3HeDmVjKCLLj9dmd2EawY';

  // RxBool isShow = false.obs;
  List trendingmovies = [];
  List topratedmovies = [];
  List upcoming = [];

  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.movies.getPopular();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map topupcomingresult = await tmdbWithCustomLogs.v3.movies.getUpcoming();

    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      upcoming = topupcomingresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {},
          ),
          backgroundColor: Colors.black,
          appBar: AppBar(

              actions: [
                Obx(
                      () => Visibility(
                      visible: listCtrl.isShow.value,
                      child: Expanded(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              listCtrl.updateSearch();
                            },
                            controller: listCtrl.searchCtrl,
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                disabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                prefixIcon:
                                const Icon(Icons.search, color: Colors.white),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      listCtrl.isShow.value = !listCtrl.isShow.value;
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ))),
                          ))),
                ),
                Obx(
                      () => Visibility(
                    visible: listCtrl.isShow.isFalse,
                    child: IconButton(
                        splashRadius: 30,
                        onPressed: () {
                          listCtrl.isShow.value = !listCtrl.isShow.value;
                        },
                        icon: const Icon(Icons.search)),
                  ),
                ),
              ],

            title: Text("Movies"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    text: "Popular",
                  ),
                  Tab(
                    text: "Top Rated",
                  ),
                  Tab(
                    text: "Upcoming",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  TrendingMovies(
                    trending: trendingmovies,
                  ),
                  TopRatedMovies(
                    toprated: topratedmovies,
                  ),
                  UpcomingMovie(
                    upcome: upcoming,
                  ),
                ]),
              )
            ],
          )),
    );
  }
}
