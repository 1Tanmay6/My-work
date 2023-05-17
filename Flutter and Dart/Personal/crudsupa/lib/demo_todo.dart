import 'package:flutter/material.dart';

class TodoItem {
  final String title;
  bool isDone;

  TodoItem({required this.title, this.isDone = false});
}

class TodoScreen extends StatefulWidget {
  static const routeName = 'todo';
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoItem> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Todo List'),
        // backgroundColor: Colors.blueGrey[800],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Add a new task',
              ),
              onSubmitted: (value) {
                setState(() {
                  _items.add(TodoItem(title: value));
                });
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(item.title),
                    onDismissed: (direction) {
                      setState(() {
                        _items.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${item.title} removed'),
                        duration: Duration(seconds: 2),
                      ));
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: ListTile(
                      title: Text(item.title),
                      leading: Checkbox(
                        value: item.isDone,
                        onChanged: (value) {
                          setState(() {
                            item.isDone = value!;
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
