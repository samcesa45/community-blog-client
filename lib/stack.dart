void main() {
  // final stack = new Stack<int>();
  // stack.push(1);
  // stack.push(2);
  // stack.push(3);

  void printInReverse<E>(List<E> list) {
    final stack = Stack<E>();
    for (E value in list) {
      stack.push(value);
    }
    while (stack.isNotEmpty) {
      print(stack.pop());
    }
  }
}

class Stack<E> {
  Stack() : _storage = <E>[];
  final List<E> _storage;

  @override
  String toString() {
    // TODO: implement toString
    return '---TOP---\n'
        '${_storage.reversed.join('\n')}'
        '\n---';
  }

  void push(E element) => _storage.add(element);
  E pop() => _storage.removeLast();
  E get peek => _storage.last;
  bool get isEmpty => _storage.isEmpty;
  bool get isNotEmpty => !isEmpty;

  Stack.of(Iterable<E> elements) : _storage = List<E>.of(elements);
}
