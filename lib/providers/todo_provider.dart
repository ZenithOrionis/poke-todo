import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';
import '../services/poke_api_service.dart';

class TodoProvider with ChangeNotifier {
  List<Todo> _todos = [];
  final PokeApiService _pokeApiService = PokeApiService();
  
  List<Todo> get todos => _todos;

  TodoProvider() {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? todosString = prefs.getString('todos');
    if (todosString != null) {
      final List<dynamic> jsonList = json.decode(todosString);
      _todos = jsonList.map((x) => Todo.fromJson(x)).toList();
      notifyListeners();
    }
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final String todosString = json.encode(_todos.map((t) => t.toJson()).toList());
    prefs.setString('todos', todosString);
  }

  Future<void> addTodo(String title) async {
    // Determine the next Pokemon to assign (random or sequential?)
    // Let's optimize: fetch a random pokemon for the task!
    final pokemon = await _pokeApiService.fetchRandomPokemon();
    
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      pokemonId: pokemon?.id,
      pokemonName: pokemon?.name,
      pokemonImageUrl: pokemon?.imageUrl,
    );
    
    _todos.add(newTodo);
    _saveTodos();
    notifyListeners();
  }

  void toggleTodo(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].isCompleted = !_todos[index].isCompleted;
      _saveTodos();
      notifyListeners();
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    _saveTodos();
    notifyListeners();
  }
}
