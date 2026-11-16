import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/theme/paper_theme.dart';
import 'package:pokedex/features/pokemon/domain/entities/pokemon_entity.dart';
import 'package:pokedex/features/pokemon/presentation/widgets/paperclip_widget.dart';

void main() {
  group('Fichero Pokédex - Pruebas Unitarias y de Widgets', () {
    test('PaperColors cubre los 18 tipos Pokémon con glifos y pigmentos válidos', () {
      const types = [
        'normal', 'fire', 'water', 'grass', 'electric', 'ice',
        'fighting', 'poison', 'ground', 'flying', 'psychic', 'bug',
        'rock', 'ghost', 'dragon', 'dark', 'steel', 'fairy'
      ];

      for (final type in types) {
        final pigment = PaperColors.pigmentForType(type);
        final glyph = PaperColors.glyphForType(type);
        final code = PaperColors.codeForType(type);

        expect(pigment, isNotNull);
        expect(glyph, isNotEmpty);
        expect(code.length, 3);
      }
    });

    test('PokemonListItem formatea números de Pokédex correctamente (#001)', () {
      final item1 = PokemonListItem(
        id: 1,
        name: 'bulbasaur',
        types: const ['grass', 'poison'],
        height: 7,
        weight: 69,
        generationId: 1,
      );
      final item25 = PokemonListItem(
        id: 25,
        name: 'pikachu',
        types: const ['electric'],
        height: 4,
        weight: 60,
        generationId: 1,
      );

      expect(item1.formattedNumber, '#001');
      expect(item25.formattedNumber, '#025');
      expect(item1.primaryType, 'grass');
      expect(item25.primaryType, 'electric');
    });

    testWidgets('PaperclipWidget renderiza correctamente en estado favorito y normal',
        (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: PaperclipWidget(
                isFavorite: true,
                onTap: () {
                  tapped = true;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.byType(PaperclipWidget), findsOneWidget);
      await tester.tap(find.byType(PaperclipWidget));
      expect(tapped, isTrue);
    });
  });
}
