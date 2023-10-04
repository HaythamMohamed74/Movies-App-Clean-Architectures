import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app_clean_architectures/core/services/service_locator.dart';
import 'package:movies_app_clean_architectures/core/utills/app_strings.dart';
import 'package:movies_app_clean_architectures/core/utills/contants.dart';
import 'package:movies_app_clean_architectures/core/utills/enum_request_state.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/genere.dart';
import 'package:movies_app_clean_architectures/movies/domain/entities/movie_details.dart';
import 'package:movies_app_clean_architectures/movies/presentation/manager/movies_details_bloc.dart';
import 'package:movies_app_clean_architectures/movies/presentation/manager/movies_details_event.dart';
import 'package:movies_app_clean_architectures/movies/presentation/manager/movies_details_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/entities/recommendations.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;

  const MovieDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: BlocProvider(
        create: (BuildContext context) {
          MoviesDetailsBloc(getIt(), getIt());
          return getIt<MoviesDetailsBloc>()
            ..add(GetMovieDetailsEvent(id))
            ..add(GetRecommendationEvent(id));
        },
        child: BlocBuilder<MoviesDetailsBloc, MoviesDetailsState>(
          builder: (BuildContext context, MoviesDetailsState state) {
            switch (state.detailsRequestState) {
              case RequestState.loading:
                return const SizedBox(
                    height: 250,
                    child: Center(child: CircularProgressIndicator()));
              case RequestState.error:
                return SizedBox(
                    height: 250,
                    child: Center(child: Text(state.detailsMessage)));
              case RequestState.loaded:
                return MovieDetailContent(
                  movie: state.movieDetails,
                  recommendations: state.recommendations!,
                );
            }
          },
        ),
      ),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  final MovieDetails? movie;
  final List<Recommendations> recommendations;

  const MovieDetailContent({
    Key? key,
    required this.movie,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const Key('movieDetailScrollView'),
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Colors.grey.shade800,
          expandedHeight: 250.0,
          flexibleSpace: FlexibleSpaceBar(
            background: FadeIn(
              duration: const Duration(milliseconds: 500),
              child: ShaderMask(
                shaderCallback: (rect) {
                  return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                      Colors.black,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.5, 1.0, 1.0],
                  ).createShader(
                    Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                  );
                },
                blendMode: BlendMode.dstIn,
                child: CachedNetworkImage(
                  width: MediaQuery.of(context).size.width,
                  imageUrl: AppConstants.imageUrl(movie!.imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie!.title,
                      style: GoogleFonts.poppins(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: Colors.white)),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2.0,
                          horizontal: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          movie!.releaseDate.split('-')[0],
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            (movie!.voteAvg / 2).toStringAsFixed(1),
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1.2,
                                color: Colors.white),
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '(${movie!.voteAvg})',
                            style: const TextStyle(
                              fontSize: 1.0,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      Text(
                        _showDuration(movie!.runTime),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    movie!.overView,
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    '${AppString.genres} ${_showGenres(movie!.genres)}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
          sliver: SliverToBoxAdapter(
            child: FadeInUp(
              from: 20,
              duration: const Duration(milliseconds: 500),
              child: Text(
                AppString.moreLikeThis.toUpperCase(),
                style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                    color: Colors.white),
              ),
            ),
          ),
        ),
        // Tab(text: 'More like this'.toUpperCase()),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 24.0),
          sliver: _showRecommendations(),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  Widget _showRecommendations() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final recommendation = recommendations[index];
          return FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: CachedNetworkImage(
                imageUrl: AppConstants.imageUrl(recommendation.imgPath),
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[850]!,
                  highlightColor: Colors.grey[800]!,
                  child: Container(
                    height: 170.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: 180.0,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        childCount: recommendations.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.7,
        crossAxisCount: 3,
      ),
    );
  }
}
