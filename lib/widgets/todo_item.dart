import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/todo.dart';
import '../providers/todo_provider.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<TodoProvider>(context, listen: false).deleteTodo(todo.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${todo.title} removed')),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
               Provider.of<TodoProvider>(context, listen: false).toggleTodo(todo.id);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: todo.isCompleted ? Colors.green : Colors.red,
                  width: 2,
                ),
                color: todo.isCompleted ? Colors.green.withOpacity(0.1) : Colors.white,
              ),
              child: todo.pokemonImageUrl != null && todo.pokemonImageUrl!.isNotEmpty
                  ? Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CachedNetworkImage(
                        imageUrl: todo.pokemonImageUrl!,
                        placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                  )
                  : Icon(
                      todo.isCompleted ? Icons.check : Icons.catching_pokemon,
                      color: todo.isCompleted ? Colors.green : Colors.red,
                    ),
            ),
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          subtitle: todo.pokemonName != null 
              ? Text('Partner: ${todo.pokemonName!.toUpperCase()}', 
                  style: TextStyle(color: Colors.grey[600], fontSize: 12)) 
              : null,
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey),
            onPressed: () {
               Provider.of<TodoProvider>(context, listen: false).deleteTodo(todo.id);
               ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('${todo.title} removed')),
               );
            },
          ),
        ),
      ),
    );
  }
}
