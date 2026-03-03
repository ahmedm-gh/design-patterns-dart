/// Demonstrates the **Strategy** pattern.
///
/// Defines a family of interchangeable algorithms, allowing you
/// to swap them at runtime.
library;

typedef SortStrategy = List<int> Function(List<int> data);

// --- استراتيجية الفقاعات ---
// --- Bubble Sort Strategy ---
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

// --- استراتيجية سريعة ---
// --- Quick Sort Strategy ---
List<int> quickSort(List<int> data) => (List.of(data)..sort());

class Sorter {
  SortStrategy strategy;
  Sorter(this.strategy);

  List<int> sort(List<int> data) => strategy(data);
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 🧠 الاستراتيجية | Strategy ---');
  final data = [3, 1, 2, 9, 5, 7];
  print('البيانات الأصلية | Original data: $data');

  print('\n⏳ الفرز باستخدام "الفقاعات" | Sorting using "Bubble Sort":');
  final sorter = Sorter(bubbleSort);
  print('النتيجة | Result: ${sorter.sort(data)}');

  print('\n⚡ التبديل إلى "الفرز السريع" للبيانات | Swapping to "Quick Sort":');
  sorter.strategy = quickSort;
  print('النتيجة | Result: ${sorter.sort(data)}');
}
