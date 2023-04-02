import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../description.dart';

class UpcomingMovie extends StatelessWidget {
  final List? upcome;

  const UpcomingMovie({super.key, this.upcome});
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
                  itemCount: upcome!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 4,
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                      mainAxisExtent: 200),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Description(
                                      name: upcome![index]['title'],
                                      bannerurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              upcome![index]['backdrop_path'],
                                      posterurl:
                                          'https://image.tmdb.org/t/p/w500' +
                                              upcome![index]['poster_path'],
                                      description: upcome![index]['overview'],
                                      vote: upcome![index]['vote_average']
                                          .toString(),
                                      launch_on: upcome![index]['release_date'],
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
                                          upcome![index]['poster_path']),
                                ),
                              ),
                              height: 150,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: Text(upcome![index]['title'] ?? 'Loading'),
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
