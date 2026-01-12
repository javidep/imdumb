import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdumb/core/utils/navigation_methods.dart';
import 'package:imdumb/design/app_color.dart';
import 'package:imdumb/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:imdumb/features/movies/presentation/pages/movie_list.dart';
import 'package:imdumb/features/movies/presentation/widgets/category_movie_card.dart';
import 'package:imdumb/injection_container.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({
    super.key,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  MoviesBloc bloc = sl<MoviesBloc>();

  @override
  Widget build(BuildContext context) {
    double? screenSizeWidth = MediaQuery.of(context).size.width;
    double? screenSizeEight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: BlocProvider(
        create: (context) => bloc..add(GetCategoryEvent()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Categorías de Películas',
              style: GoogleFonts.montserrat(
                color: AppColor.primaryWhite,
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: AppColor.primaryWine,
            elevation: 0.0,
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
                      if (state.categoryModelList!.isNotEmpty) {
                        return SizedBox(
                          width: screenSizeWidth * 1,
                          height: screenSizeEight * 1,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.categoryModelList!.length,
                            itemBuilder: (context, index) {
                              return CategoryMovieCard(
                                name: state.categoryModelList![index].name,
                                posterUrl: state.categoryModelList![index].posterUrl,
                                onTap: () =>
                                  NavigatorExtension.push(MovieList(
                                      categoryModel: state.categoryModelList![index],
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
                            'No hay categorías disponibles',
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