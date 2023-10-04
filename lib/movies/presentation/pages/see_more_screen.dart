import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app_clean_architectures/core/utills/enum_request_state.dart';
import 'package:movies_app_clean_architectures/movies/presentation/manager/movies_bloc.dart';
import 'package:movies_app_clean_architectures/movies/presentation/pages/movie_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/services/service_locator.dart';
import '../../../core/utills/contants.dart';
import '../../domain/entities/movie.dart';

class SeeMoreScreen extends StatelessWidget {
  final String category;

  const SeeMoreScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Create an instance of your MoviesBloc here
        return getIt<MoviesBloc>()
          ..add(GetPopularMoviesEvent())
          ..add(GetTopRatedMoviesEvent());
      },
      child: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state.popularMoviesRequestState == RequestState.loading &&
              state.topRatedMoviesRequestState == RequestState.loading) {
            return const SizedBox(
                height: 150, child: Center(child: CircularProgressIndicator()));
          }
          List<Movie> moviesToShow;
          if (category == "Popular") {
            moviesToShow = state.popularMovies ?? [];
          } else if (category == "Top Rated") {
            moviesToShow = state.topRatedMovies ?? [];
          } else {
            moviesToShow = []; // Handle other categories if needed
          }

          return Scaffold(
            backgroundColor: Colors.grey.shade900,
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                    color: Colors.white,
                  )),
              backgroundColor: Colors.grey.shade900,
              title: Text(
                '$category Movies',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            body: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: moviesToShow.length,
              itemBuilder: (context, index) {
                final movie = moviesToShow[index];
                // Render the movie item using movie data
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MovieDetailScreen(id: movie.id)));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                                child: CachedNetworkImage(
                                  width: 100,
                                  height: 120,
                                  fit: BoxFit.cover,
                                  imageUrl: AppConstants.imageUrl(
                                      moviesToShow[index].imgPath),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[850]!,
                                    highlightColor: Colors.grey[800]!,
                                    child: Container(
                                      height: 200,
                                      width: 120.0,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 2.0,
                                          horizontal: 8.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Text(
                                          movie.releaseDate.split('-')[0],
                                          style: const TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 20.0,
                                      ),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        (movie.voteAvg / 2).toStringAsFixed(1),
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 1.2,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 4.0),
                                      // Text(
                                      //   '(${movie.voteAvg})',
                                      //   style: const TextStyle(
                                      //     fontSize: 1.0,
                                      //     color: Colors.red,
                                      //     fontWeight: FontWeight.w500,
                                      //     letterSpacing: 1.2,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Text(movie.overView,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.aBeeZee(
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    // ... other movie information
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
