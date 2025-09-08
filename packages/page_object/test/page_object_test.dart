import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:page_object/page_object.dart';

void main() {
  test('PageObject should delegate calls to internal finder.', () {
    final testElement = TestElement();
    final testFinder = TestFinder(testElement);
    final pageObject = PageObject(testFinder);
    expect(pageObject.apply([]), hasLength(1));
    expect(pageObject.apply([]).first, equals(testElement));
    expect(pageObject.description, equals('This is a test finder.'));
    expect(pageObject.evaluate(), hasLength(1));
    expect(pageObject.evaluate().first, equals(testElement));
    expect(pageObject.precache(), isTrue);
  });
}

class TestFinder extends Finder {
  TestFinder(this.testElement);

  final Element testElement;

  @override
  Iterable<Element> apply(Iterable<Element> candidates) => [testElement];

  @override
  String get description => 'This is a test finder.';

  @override
  FinderResult<Element> evaluate() => FinderResult(
    (candidates) => 'Found ${candidates.name} matching element(s)',
    [testElement],
  );
  @override
  bool precache() => true;
}

class TestElement extends Element {
  TestElement() : super(const TestWidget());

  @override
  bool get debugDoingBuild => true;

  @override
  void performRebuild() {
    super.performRebuild();
  }

  // Nuevos métodos requeridos en Flutter 3.x

  @override
  Widget build() => widget;
}

// Widget simple para usar con TestElement
class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
