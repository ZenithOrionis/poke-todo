import '../models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> getTodos() {
    return List.from(_todos);
  }

  Todo getTodoById(String id) {
    return _todos.firstWhere((todo) => todo.id == id);
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void updateTodo(String id, Todo todo) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void toggleTodoCompletion(String id) {
    final index = _todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
    }
  }

  // TODO: Add Firebase methods for persistence
  // - saveTodoToFirebase
  // - loadTodosFromFirebase
  // - deleteTodoFromFirebase
}
