import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/utils/navigation_methods.dart';
import 'package:imdumb/design/app_color.dart';
import 'package:imdumb/features/movies/data/models/category_model.dart';
import 'package:imdumb/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:imdumb/features/movies/presentation/pages/movie_detail.dart';
import 'package:imdumb/features/movies/presentation/widgets/category_movie_card.dart';
import 'package:imdumb/injection_container.dart';
import 'package:google_fonts/google_fonts.dart';

class MovieList extends StatefulWidget {
  const MovieList({
    super.key,
    required this.categoryModel,
  });

  final CategoryModel categoryModel;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  MoviesBloc bloc = sl<MoviesBloc>();

  @override
  Widget build(BuildContext context) {
    double? screenSizeWidth = MediaQuery.of(context).size.width;
    double? screenSizeEight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: BlocProvider(
        create: (context) => bloc..add(GetMoviesEvent(categoryId: widget.categoryModel.categoryId)),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.categoryModel.name,
              style: GoogleFonts.montserrat(
                color: AppColor.primaryWhite,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColor.primaryWine,
            elevation: 0.0,
            //add back button
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColor.primaryWhite),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: BlocBuilder<MoviesBloc, MoviesState>(
                    builder: (context, state){
                      if (state.loading!) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: screenSizeWidth * 0.45, top: screenSizeEight * 0.40),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (state.moviesModelList!.isNotEmpty) {
                        return SizedBox(
                          width: screenSizeWidth * 1,
                          height: screenSizeEight * 1,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.moviesModelList!.length,
                            itemBuilder: (context, index) {
                              return CategoryMovieCard(
                                name: state.moviesModelList![index].name,
                                posterUrl: state.moviesModelList![index].images.first,
                                onTap: () =>
                                    NavigatorExtension.push(MovieDetail(
                                      moviesModel: state.moviesModelList![index],
                                    ),
                                      context,
                                    ),
                              );
                            },
                          ),
                        );
                      }
                      if (state.message!.isNotEmpty) {
                        return Center(
                          child: Text('Error: ${state.message}',
                            style: GoogleFonts.montserrat(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: AppColor.primaryBlack,
                            ),
                          ),
                        );
                      }
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(left: screenSizeWidth * 0.15, top: screenSizeEight * 0.30),
                          child: Text(
                            'No hay películas disponibles',
                            style: GoogleFonts.montserrat(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: AppColor.primaryBlack,
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}