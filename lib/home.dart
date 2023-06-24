import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text('Warning'),
                          content: Text('Do you want delete all task?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  tasks.clear();
                                  if (mounted) {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  }
                                },
                                child: Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('No')),
                          ],
                        ));
              },
              icon: Icon(Icons.playlist_remove))
        ],
      ),
      body: ListView.separated(
          itemCount: tasks.length,
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemBuilder: (context, index) {
            return ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              tileColor:
                  tasks[index].status ? Colors.green[100] : Colors.red[100],

              onLongPress: () {
                tasks[index].status = !tasks[index].status;
                setState(() {});
              },

              leading: tasks[index].status
                  ? const Icon(Icons.done)
                  : const Icon(Icons.not_interested),
              title: Text(tasks[index].title),
              subtitle: Text(tasks[index].des),

              // IconButton(onPressed: (){}, icon: Icon(Icons.edit_note)),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Are you sure?'),
                                content: const Text(
                                    'Are you sure you want to delete this task?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        tasks.removeAt(index);
                                        if (mounted) {
                                          setState(() {});
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: const Text('Yes')),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('cancle'))
                                ],
                              );
                            });
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(Icons.delete)),
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showtaskadd();
            if (mounted) {
              setState(() {});
            }
          },
          label: const Text('Add Task')),
    );
  }

  void showtaskadd() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Image.network(
                  'https://cdn3.iconfinder.com/data/icons/documents-and-files-2/512/Add_Task-512.png',
                  width: 50,
                  height: 50,
                ),
              ),
              const Center(
                  child: Text('Add your Task',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: title,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: const Text('add task Title'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.orange))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: description,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      label: const Text('add task description'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.orange))),
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 150, vertical: 15)),
                  onPressed: () {
                    if (title.text.trim().isNotEmpty &&
                        description.text.trim().isNotEmpty) {
                      tasks.add(Task(
                          title.text.trim(), description.text.trim(), false));
                      title.clear();
                      description.clear();
                      if (mounted) {
                        setState(() {});
                        Navigator.pop(context);
                      }
                    } else {
                      (showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Warning'),
                                content: Text('Empty Value Not allow'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('okay'))
                                ],
                              )));
                    }
                  },
                  child: const Text('Add Task')),
            ],
          );
        });
  }
}


void edittask(index){



}

class Task {
  String title;
  String des;
  bool status;
  Task(this.title, this.des, this.status);
}
