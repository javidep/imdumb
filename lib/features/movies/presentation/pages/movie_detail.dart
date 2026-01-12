import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdumb/design/app_color.dart';
import 'package:imdumb/features/movies/data/models/movies_model.dart';

class MovieDetail extends StatefulWidget {
  const MovieDetail({
    super.key,
    required this.moviesModel,
  });

  final MoviesModel moviesModel;

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.moviesModel.name,
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
        backgroundColor: Colors.black,
        bottomNavigationBar: _recommendButton(),

        body: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: SafeArea(
                child: PageView.builder(
                  itemCount: widget.moviesModel.images.length,
                  onPageChanged: (i) => setState(() => index = i),
                  itemBuilder: (_, i) {
                    return Image.network(
                      widget.moviesModel.images[i],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    widget.moviesModel.name,
                    style: GoogleFonts.montserrat(
                      color: AppColor.primaryWhite,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  _Stars(rating: widget.moviesModel.score),

                  const SizedBox(height: 16),

                  Text(
                    widget.moviesModel.des,
                    style: GoogleFonts.montserrat(
                      color: AppColor.primaryWhite,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Actores',
                    style: GoogleFonts.montserrat(
                      color: AppColor.primaryWhite,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _ActorsList(actors: widget.moviesModel.actors),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openRecommendModal() {
    final TextEditingController controller = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColor.primaryBlack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recomendar película',
                style: GoogleFonts.montserrat(
                  color: AppColor.primaryWhite,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                widget.moviesModel.des,
                style: GoogleFonts.montserrat(
                  color: AppColor.primaryWhite,
                  fontSize: 12.0,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                controller: controller,
                maxLines: 3,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Escribe tu recomendación...',
                  hintStyle: const TextStyle(color: AppColor.primaryWhite),
                  filled: true,
                  fillColor: AppColor.primaryGrey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryWine,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    _showConfirmDialog(controller.text);
                  },
                  child: Text(
                    'Confirmar',
                    style: GoogleFonts.montserrat(
                      color: AppColor.primaryWhite,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          title: Text(
            'Confirmar recomendación',
            style: GoogleFonts.montserrat(
              color: AppColor.primaryWhite,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(
            '¿Deseas enviar esta recomendación?',
            style: GoogleFonts.montserrat(
              color: AppColor.primaryWhite,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // cerrar dialog
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // cerrar dialog
                Navigator.pop(context); // cerrar modal
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }


  Widget _recommendButton() {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(12),
      color: Colors.black,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryWine,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          _openRecommendModal();
        },
        child: Text(
          'Recomendar',
          style: GoogleFonts.montserrat(
            color: AppColor.primaryWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  final int rating;

  const _Stars({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        5,
            (i) => Icon(
          i < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        ),
      ),
    );
  }
}

class _ActorsList extends StatelessWidget {
  final List<String> actors;

  const _ActorsList({required this.actors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemCount: actors.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) {
          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              actors[i],
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
