/// Demonstrates the **Strategy** pattern.
///
/// Defines a family of interchangeable algorithms, allowing you
/// to swap them at runtime.
library;

/// A function that sorts a list of integers.
typedef SortStrategy = List<int> Function(List<int> data);

/// Sorts [data] using the bubble sort algorithm.
List<int> bubbleSort(List<int> data) {
  final list = List<int>.of(data);
  for (var i = 0; i < list.length; i++) {
    for (var j = 0; j < list.length - i - 1; j++) {
      if (list[j] > list[j + 1]) {
        final temp = list[j];
        list[j] = list[j + 1];
        list[j + 1] = temp;
      }
    }
  }
  return list;
}

/// Sorts [data] using Dart's built-in sort (delegates to optimized sort).
List<int> quickSort(List<int> data) => (List<int>.of(data)..sort());

/// A sorter that delegates sorting to a pluggable [strategy].
class Sorter {
  /// The current sorting strategy.
  SortStrategy strategy;

  /// Creates a sorter with the given [strategy].
  Sorter(this.strategy);

  /// Sorts [data] using the current strategy.
  List<int> sort(List<int> data) => strategy(data);
}

void main() {
  final sorter = Sorter(bubbleSort);
  print(sorter.sort([3, 1, 2])); // [1, 2, 3]

  // Swap strategy at runtime
  sorter.strategy = quickSort;
  print(sorter.sort([9, 5, 7])); // [5, 7, 9]
}
