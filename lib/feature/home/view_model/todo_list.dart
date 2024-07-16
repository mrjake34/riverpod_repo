import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_repo/feature/home/model/todos.dart';
import 'package:riverpod_repo/product/base/constants/custom_urls.dart';
import 'package:http/http.dart' as http;

part 'todo_list.g.dart';

@riverpod
final class TodoList extends _$TodoList {
  @override
  Future<List<Todos>> build() async {
    final response = await http.get(Uri.parse(CustomUrls.todosUrl));
    final List<Todos> todos = (json.decode(response.body) as List)
        .map((data) => Todos.fromJson(data))
        .toList();
    return todos;
  }

  void add(Todos todo) {
    state.value?.add(todo);
  }

  void remove(Todos todo) {
    state.value?.remove(todo);
    state = AsyncValue.data(state.value ?? []);
  }

  void updates(Todos todo) {
    final index = state.value?.indexWhere((element) => element.id == todo.id);
    if (index != null && index >= 0) {
      state.value?[index] = todo;
      state = AsyncValue.data(state.value ?? []);
    }
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}
