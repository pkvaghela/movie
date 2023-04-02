import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../description.dart';

class TopRatedMovies extends StatelessWidget {
  final List? toprated;

  const TopRatedMovies({this.toprated});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [


            SizedBox(height: 10),
            Container(
                height: 620,
                child: GridView.builder(
                  itemCount: toprated?.length,
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
                                     name: toprated![index]['title'],
                                        bannerurl:
                              'https://image.tmdb.org/t/p/w500' +
                                  toprated![index]['backdrop_path'],
                               posterurl:
                             'https://image.tmdb.org/t/p/w500' +
                                 toprated![index]['poster_path'],
                           description: toprated![index]['overview'],
                          vote: toprated![index]['vote_average']
                           .toString(),
                           launch_on: toprated![index]
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
                                      'https://image.tmdb.org/t/p/w500' +
                                          toprated![index]['poster_path']),
                                ),
                              ),
                              height: 150,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(toprated![index]['title'] ?? 'Loading'),
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
