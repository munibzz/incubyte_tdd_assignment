// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:incubyte_tdd_assignment/main.dart';

void main() {
  int add(String numbers) {
    if (numbers.isEmpty) return 0;

    String delimiter = ',';
    String numbersToProcess = numbers;
    List<int> negativeNumbers = [];

    if (numbers.startsWith('//')) {
      var parts = numbers.split('\n');
      delimiter = parts[0].substring(2);
      numbersToProcess = parts[1];
    }

    numbersToProcess = numbersToProcess.replaceAll('\n', delimiter);

    var numbersList = numbersToProcess.split(delimiter).map((str) {
      int number = int.tryParse(str.trim()) ?? 0;
      if (number < 0) {
        negativeNumbers.add(number);
      }
      return number;
    }).toList();

    if (negativeNumbers.isNotEmpty) {
      throw FormatException(
          "Negative numbers are not allowed: ${negativeNumbers.join(', ')}");
    }

    return numbersList.reduce((sum, number) => sum + number);
  }

  group('StringCalculator', () {
    test('should return 0 for empty string', () {
      expect(add(""), equals(0));
    });

    test('should return number itself for single number', () {
      expect(add("1"), equals(1));
    });

    test('should return sum for two numbers', () {
      expect(add("1,5"), equals(6));
    });

    test('should return sum for multiple numbers', () {
      expect(add("1,2,3"), equals(6));
    });

    test('should handle new line as delimiter', () {
      expect(add("1\n2,3"), equals(6));
    });

    test('should handle custom delimiter', () {
      expect(add("//;\n1;2"), equals(3));
      expect(add("//|\n1|2|3"), equals(6));
    });

    test('should throw negative number exception', () {
      expect(add("//;\n1;2"), equals(3));
      expect(add("//|\n-1|-2|-3"), equals(6));
    });
  });
}
