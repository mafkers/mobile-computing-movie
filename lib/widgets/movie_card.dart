import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool? isFavorite;
  final VoidCallback? onFavoriteTap;
  final VoidCallback onTap;

  const MovieCard({
    super.key,
    required this.movie,
    this.isFavorite,
    this.onFavoriteTap,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Image.network(
              movie.posterUrl,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 150,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.movie, size: 40, color: Colors.grey),
                );
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${movie.year} • ${movie.genre}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey.shade600,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toString(),
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Jika isFavorite null, maka widget IconButton disembunyikan (digunakan pada Halaman Favorit)
            if (isFavorite != null && onFavoriteTap != null)
              IconButton(
                icon: Icon(
                  isFavorite! ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite! ? Colors.red : Colors.grey,
                ),
                onPressed: onFavoriteTap,
              ),
            if (isFavorite != null) const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
