import 'package:flutter/material.dart';
import 'package:movies/models/makeup.dart';

class MakeupCard extends StatelessWidget {
  final Makeup makeup;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const MakeupCard({
    super.key,
    required this.makeup,
    required this.onTap,
    required this.onFavoriteTap,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      color: isFavorite ? colors.secondaryContainer : colors.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  makeup.imagePath,
                  width: 72,
                  height: 88,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return ColoredBox(
                      color: colors.surfaceContainerHighest,
                      child: const SizedBox(
                        width: 72,
                        height: 88,
                        child: Icon(Icons.brush_outlined, size: 32),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      makeup.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isFavorite
                            ? colors.onSecondaryContainer
                            : colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${makeup.category} · \$${makeup.price}',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          makeup.available
                              ? Icons.inventory_2_outlined
                              : Icons.remove_shopping_cart_outlined,
                          size: 16,
                          color: colors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(makeup.available ? 'Disponible' : 'Agotado'),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: isFavorite
                    ? 'Quitar de favoritos'
                    : 'Agregar a favoritos',
                onPressed: onFavoriteTap,
                icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
                color: colors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
