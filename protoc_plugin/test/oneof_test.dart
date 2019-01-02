// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library one_of_test;

import 'package:test/test.dart';

import '../out/protos/oneof.pb.dart';

void main() {
  test('empty oneof', () {
    Foo foo = Foo();
    expectOneofNotSet(foo);
  });

  test('set oneof', () {
    Foo foo = Foo();
    foo.first = 'oneof';
    expectFirstSet(foo);

    foo.second = 1;
    expectSecondSet(foo);

    foo.third = true;
    expect(foo.whichOneofField(), Foo_OneofField.third);
    expect(foo.hasFirst(), false);
    expect(foo.first, '');
    expect(foo.hasSecond(), false);
    expect(foo.second, 0);
    expect(foo.hasThird(), true);
    expect(foo.third, true);
    expect(foo.hasFourth(), false);
    expect(foo.fourth, []);
    expect(foo.hasFifth(), false);
    expect(foo.fifth, Bar());
    expect(foo.hasSixth(), false);
    expect(foo.sixth, enum_type.A);

    foo.fourth = [1, 2];
    expect(foo.whichOneofField(), Foo_OneofField.fourth);
    expect(foo.hasFirst(), false);
    expect(foo.first, '');
    expect(foo.hasSecond(), false);
    expect(foo.second, 0);
    expect(foo.hasThird(), false);
    expect(foo.third, false);
    expect(foo.hasFourth(), true);
    expect(foo.fourth, [1, 2]);
    expect(foo.hasFifth(), false);
    expect(foo.fifth, Bar());
    expect(foo.hasSixth(), false);
    expect(foo.sixth, enum_type.A);

    foo.fifth = Bar()..i = 1;
    expect(foo.whichOneofField(), Foo_OneofField.fifth);
    expect(foo.hasFirst(), false);
    expect(foo.first, '');
    expect(foo.hasSecond(), false);
    expect(foo.second, 0);
    expect(foo.hasThird(), false);
    expect(foo.third, false);
    expect(foo.hasFourth(), false);
    expect(foo.fourth, []);
    expect(foo.hasFifth(), true);
    expect(foo.fifth, Bar()..i = 1);
    expect(foo.hasSixth(), false);
    expect(foo.sixth, enum_type.A);

    foo.sixth = enum_type.B;
    expect(foo.whichOneofField(), Foo_OneofField.sixth);
    expect(foo.hasFirst(), false);
    expect(foo.first, '');
    expect(foo.hasSecond(), false);
    expect(foo.second, 0);
    expect(foo.hasThird(), false);
    expect(foo.third, false);
    expect(foo.hasFourth(), false);
    expect(foo.fourth, []);
    expect(foo.hasFifth(), false);
    expect(foo.fifth, Bar());
    expect(foo.hasSixth(), true);
    expect(foo.sixth, enum_type.B);
  });

  test('set and clear oneof', () {
    Foo foo = Foo()..first = 'oneof';
    expectFirstSet(foo);

    foo.clearOneofField();
    expectOneofNotSet(foo);

    foo.first = 'oneof';
    expectFirstSet(foo);

    foo.clearFirst();
    expectOneofNotSet(foo);
  });

  test('serialize and parse oneof', () {
    Foo foo = Foo()..first = 'oneof';
    expectFirstSet(foo);

    foo = Foo.fromBuffer(foo.writeToBuffer());
    expectFirstSet(foo);
  });

  test('JSON serialize and parse oneof', () {
    Foo foo = Foo()..second = 1;
    expectSecondSet(foo);

    foo = Foo.fromJson(foo.writeToJson());
    expect(foo.whichOneofField(), Foo_OneofField.second);
    expectSecondSet(foo);
  });

  test('serialize and parse concat oneof', () {
    Foo foo = Foo()..first = 'oneof';
    expectFirstSet(foo);

    Foo foo2 = Foo()..second = 1;
    expectSecondSet(foo2);

    List<int> concat = []
      ..addAll(foo.writeToBuffer())
      ..addAll(foo2.writeToBuffer());
    foo = Foo.fromBuffer(concat);
    expectSecondSet(foo);
  });

  test('JSON serialize and parse concat oneof', () {
    Foo foo = Foo()..first = 'oneof';
    expectFirstSet(foo);

    Foo foo2 = Foo()..second = 1;
    expectSecondSet(foo2);

    String jsonConcat =
        '${foo2.writeToJson().substring(0, foo2.writeToJson().length - 1)}, '
        '${foo.writeToJson().substring(1)}';
    foo = Foo.fromJson(jsonConcat);
    expectFirstSet(foo);
  });

  test('set and clear second oneof field', () {
    Foo foo = Foo();
    expectOneofNotSet(foo);

    foo.red = 'r';
    expect(foo.whichColors(), Foo_Colors.red);
    expect(foo.hasRed(), true);
    expect(foo.red, 'r');
    expect(foo.hasGreen(), false);
    expect(foo.green, '');

    foo.green = 'g';
    expect(foo.whichColors(), Foo_Colors.green);
    expect(foo.hasRed(), false);
    expect(foo.red, '');
    expect(foo.hasGreen(), true);
    expect(foo.green, 'g');
  });
}

void expectSecondSet(Foo foo) {
  expect(foo.whichOneofField(), Foo_OneofField.second);
  expect(foo.hasFirst(), false);
  expect(foo.first, '');
  expect(foo.hasSecond(), true);
  expect(foo.second, 1);
  expect(foo.hasThird(), false);
  expect(foo.third, false);
  expect(foo.hasFourth(), false);
  expect(foo.fourth, []);
  expect(foo.hasFifth(), false);
  expect(foo.fifth, Bar());
  expect(foo.hasSixth(), false);
  expect(foo.sixth, enum_type.A);
}

void expectFirstSet(Foo foo) {
  expect(foo.whichOneofField(), Foo_OneofField.first);
  expect(foo.hasFirst(), true);
  expect(foo.first, 'oneof');
  expect(foo.hasSecond(), false);
  expect(foo.second, 0);
  expect(foo.hasThird(), false);
  expect(foo.third, false);
  expect(foo.hasFourth(), false);
  expect(foo.fourth, []);
  expect(foo.hasFifth(), false);
  expect(foo.fifth, Bar());
  expect(foo.hasSixth(), false);
  expect(foo.sixth, enum_type.A);
}

void expectOneofNotSet(Foo foo) {
  expect(foo.whichOneofField(), Foo_OneofField.notSet);
  expect(foo.hasFirst(), false);
  expect(foo.first, '');
  expect(foo.hasSecond(), false);
  expect(foo.second, 0);
  expect(foo.hasThird(), false);
  expect(foo.third, false);
  expect(foo.hasFourth(), false);
  expect(foo.fourth, []);
  expect(foo.hasFifth(), false);
  expect(foo.fifth, Bar());
  expect(foo.hasSixth(), false);
  expect(foo.sixth, enum_type.A);

  expect(foo.whichColors(), Foo_Colors.notSet);
  expect(foo.hasRed(), false);
  expect(foo.red, '');
  expect(foo.hasGreen(), false);
  expect(foo.green, '');
}