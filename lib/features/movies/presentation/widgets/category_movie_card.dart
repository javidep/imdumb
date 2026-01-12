import 'package:flutter/material.dart';

class CategoryMovieCard extends StatelessWidget {
  final String name;
  final String posterUrl;
  final VoidCallback? onTap;

  const CategoryMovieCard({
    super.key,
    required this.name,
    required this.posterUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Poster
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.network(
                posterUrl,
                fit: BoxFit.cover,
              ),
            ),

            // Gradient overlay (optional Netflix style)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
              ),
            ),

            // Title
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}