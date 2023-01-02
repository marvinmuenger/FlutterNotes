import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Note {
  String title;
  String body;
  int id;

  Note({required this.title, required this.body, required this.id});
}

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    _notes.where((element) => element.id == note.id).first.title = note.title;
    _notes.where((element) => element.id == note.id).first.body = note.body;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider<NoteProvider>(
      create: (_) => NoteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Markdown Notes',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const NoteList(),
    );
  }
}

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Markdown Notes'),
      ),
      body: ListView.builder(
        itemCount: noteProvider.notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(noteProvider.notes[index].title),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoteEditor(
                      note: noteProvider.notes[index],
                      onSave: noteProvider.updateNote,
                    ),
                  ));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteEditor(
                  note: null,
                  onSave: noteProvider.addNote,
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteEditor extends StatefulWidget {
  final Note? note;
  final Function(Note) onSave;

  const NoteEditor({super.key, required this.note, required this.onSave});

  @override
  // ignore: library_private_types_in_public_api
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _bodyController.text = widget.note!.body;
    }
  }

  void _saveNote() {
    if (_formKey.currentState!.validate()) {
      final note = Note(
        id: widget.note?.id ?? DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        body: _bodyController.text,
      );
      widget.onSave(note);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Note Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  hintText: 'Note Body',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a body';
                  }
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: _saveNote,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
