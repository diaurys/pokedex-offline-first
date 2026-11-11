import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers.dart';
import '../../../pokemon/domain/entities/pokemon_entity.dart';

/// StreamProvider reactivo que observa la lista de Pokémon favoritos desde SQLite (RF-FAV-01 a RF-FAV-04)
final favoritesStreamProvider = StreamProvider<List<PokemonListItem>>((ref) {
  final repository = ref.watch(favoritesRepositoryProvider);
  return repository.watchFavorites();
});
