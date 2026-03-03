typedef SortStrategy = List<int> Function(List<int> data);

List<int> bubbleSort(List<int> data) {
  final list = List.of(data);
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

List<int> quickSort(List<int> data) => (List.of(data)..sort());

class Sorter {
  SortStrategy strategy;
  Sorter(this.strategy);

  List<int> sort(List<int> data) => strategy(data);
}


void main() {
  // --- Usage ---
  final sorter = Sorter(bubbleSort);
  print(sorter.sort([3, 1, 2])); // [1, 2, 3]

  sorter.strategy = quickSort; // Swap strategy at runtime
  print(sorter.sort([9, 5, 7])); // [5, 7, 9]
}
