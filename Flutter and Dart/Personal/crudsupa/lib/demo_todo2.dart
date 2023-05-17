import 'package:flutter/material.dart';

class Todo {
  final String title;
  bool isCompleted;

  Todo({
    required this.title,
    this.isCompleted = false,
  });
}

class TodoScreen2 extends StatefulWidget {
  static const routeName = '/to2';
  @override
  _TodoScreen2State createState() => _TodoScreen2State();
}

class _TodoScreen2State extends State<TodoScreen2> {
  List<Todo> todos = [
    Todo(title: 'Go to the gym'),
    Todo(title: 'Buy groceries'),
    Todo(title: 'Call mom'),
    Todo(title: 'Finish work project'),
  ];

  int _points = 0;
  int _experience = 0;

  void _completeTask(int index) {
    setState(() {
      todos[index].isCompleted = true;
      _points += 10;
      _experience += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo List'),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: todos[index].isCompleted
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.radio_button_unchecked),
            title: Text(
              todos[index].title,
              style: TextStyle(
                decoration: todos[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: todos[index].isCompleted
                ? null
                : TextButton(
                    child: Text('Complete'),
                    onPressed: () => _completeTask(index),
                  ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Points',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '$_points',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Experience',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '$_experience',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
