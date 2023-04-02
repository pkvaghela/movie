import 'package:flutter/material.dart';

import '../description.dart';


class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
                height: 620,
                child: GridView.builder(
                  itemCount: trending.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      mainAxisExtent: 200),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Description(
                                                    name: trending[index]['title'],
                                                    bannerurl:
                                                    'https://image.tmdb.org/t/p/w500' +
                                                        trending[index]['backdrop_path'],
                                                    posterurl:
                                                    'https://image.tmdb.org/t/p/w500' +
                                                        trending[index]['poster_path'],
                                                    description: trending[index]['overview'],
                                                    vote: trending[index]['vote_average']
                                                        .toString(),
                                                    launch_on: trending[index]
                                                    ['release_date'],
                                                  )));
                      },
                      child: Container(
                        width: 200,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(

                                  image: NetworkImage(
                                    scale: 2,
                                      'https://image.tmdb.org/t/p/w500' +
                                          trending[index]['poster_path']),
                                ),
                              ),
                              height: 150,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(trending[index]['title'] ?? 'Loading'),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
