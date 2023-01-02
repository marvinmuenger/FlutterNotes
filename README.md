# Flutter Markdown Notes

This is a Proof of Concept for a Flutter app that supports taking and organizing notes. Each note has a title and body, and can be added and edited within the app. The app uses a `Note` class to represent a single note, and a `NoteProvider` class to manage a list of `Note` objects and provide methods for adding and updating notes.

## Current Features

- Create and edit notes
- View a list of all notes

## Roadmap 

The following features are planned for future development:

- Database integration: Store notes in a database for persistent storage and easier data management.
- Note organization: Allow the user to organize notes into folders or tags.
- Note search: Implement a search feature to allow the user to quickly find a specific note.
- Note history: Allow the user to view past versions of a note and restore to a previous version if needed.
- Rich text formatting: Allow markdown formatting for notes to improve handling of code related notes.

The app will get a design overhaul once the basic features have been fully mapped out.

## Getting Started

To get started with the app, clone the repository and open it in your preferred Flutter development environment. Then, run the app using the instructions for your environment.

``` bash
git clone https://github.com/marvinmuenger/FlutterNotes.git
cd flutter-markdown-notes
flutter run
```


## Prerequisites

- Flutter
- A Flutter development environment (e.g. Android Studio, Visual Studio Code)

## Built With

- [Flutter](https://flutter.dev/) - The framework used

## Author

- Marvin Münger - Initial work

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

