# Task Manager App

A modern Flutter task management application with a sleek dark theme and intuitive user interface.

## Features

- Create, edit, and delete tasks
- Search functionality with real-time filtering
- SQLite local database integration
- Clean architecture with Provider state management
- Modern UI with smooth animations
- Dark theme optimized for readability

## Screenshots

<img src="/api/placeholder/200/400" alt="Task List Screen">
<img src="/api/placeholder/200/400" alt="Task Detail Screen">
<img src="/api/placeholder/200/400" alt="Search Functionality">

## Tech Stack

- Flutter
- Provider for state management
- SQLite for local storage
- animate_do for animations
- iconsax for modern icons

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/chamathkalharafernando/task_manager.git
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── data/
│   ├── database_helper.dart
│   └── task_repository.dart
├── models/
│   └── task_model.dart
├── view_models/
│   └── task_view_model.dart
├── views/
│   ├── task_list_screen.dart
│   └── task_detail_screen.dart
├── theme/
│   └── app_theme.dart
└── main.dart
```

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.0.5
  sqflite: ^2.3.0
  path: ^1.8.3
  iconsax: ^0.0.8
  animate_do: ^3.0.2
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add YourFeature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
