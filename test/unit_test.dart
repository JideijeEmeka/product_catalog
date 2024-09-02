import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Add a product to list', () async {
    //Arrange
    List products = [];

    //Act
    products.add("beans");

    //Assert
    expect(products.isEmpty, false);
    expect(products.contains("beans"), true);
  });
}