import 'package:flutter_test/flutter_test.dart';
import 'package:movies/models/makeup.dart';

void main() {
  test('Makeup.fromJson parsea el JSON del catalogo', () {
    final makeup = Makeup.fromJson({
      'id': 1,
      'name': 'Labial',
      'category': 'Labios',
      'available': true,
      'price': 25000,
      'description': 'd',
      'imagePath': 'assets/images/labial',
    });
    expect(makeup.name, 'Labial');
  });
}
