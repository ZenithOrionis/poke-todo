import 'package:flutter/material.dart';

class TodoListScreen extends StatelessWidget {
  final List<Todo> todos;

  const TodoListScreen({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pokemon Todo List')),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (ctx, i) {
          final todo = todos[i];
          return ListTile(
            leading: todo.pokemonName != null
                ? Image.network('https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${todo.pokemonName}.png')
                : null,
            title: Text(todo.title),
            trailing: Checkbox(
              value: todo.done,
              onChanged: (_) { /* toggle */ },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
