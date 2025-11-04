# 📚 Task App

**Task App** is a Flutter application built using the `OpenLibrary` API that allows users to search for authors, view detailed information, and explore their works. The project follows clean architecture principles with clearly separated `data`, `domain`, and `presentation` layers. It uses `Bloc` for state management, `Dio` for networking, and `GetIt` for dependency injection.

---

## 🚀 Features

* 🔍 Search authors by name using the `OpenLibrary Search API`
* 📄 View detailed author information
* 📚 Browse author’s works
* 🧱 Clean Architecture (Entity, Model, Repository)
* 🌐 REST API integration using `Dio`
* 🧩 Dependency injection with `GetIt`
* ⚙️ State management using `Bloc`

---

## 🧰 Technologies

| Technology              | Purpose                                |
| ----------------------- | -------------------------------------- |
| **Flutter**             | UI development                         |
| **Dio**                 | Networking and HTTP requests           |
| **Bloc**                | State management                       |
| **GetIt**               | Service locator / dependency injection |
| **Retrofit**            | API interface generator                |

---

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── constants/
│   ├── error/
│   └── network/
│       ├── dio_interceptor.dart
│       ├── dio_client.dart
│       └── data_state.dart
│
├── data/
│   ├── models/
│   │   ├── author_model.dart
│   │   └── author_response_model.dart
│   ├── sources/
│   │   └── remote/authors_api_service.dart
│   └── repositories/
│       └── authors_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── author_entity.dart
│   │   └── doc_entity.dart
│   └── repositories/
│       └── authors_repository.dart
│
├── presentation/
│   ├── bloc/authors_bloc.dart
│   ├── pages/
│   │   ├── authors_page.dart
│   │   └── author_detail_page.dart
│   └── widgets/
│
└── injection_container.dart  // GetIt setup
```

---

## ⚙️ Installation & Setup

### 1️⃣ Clone the repository

```bash
git clone https://github.com/<username>/task_app.git
cd task_app
```

### 2️⃣ Install dependencies

```bash
flutter pub get
```

### 3️⃣ Generate Retrofit files with `build_runner`

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4️⃣ Run the app

```bash
flutter run
```

---

## 🌍 API Source

This project uses the public `OpenLibrary` API:

* **Search Authors:**
  `https://openlibrary.org/search/authors.json?q=<query>`



## 🧩 Dependency Injection (`GetIt`)

Example from `di.dart`:

```dart
final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(baseUrl: Urls.baseUrl)));
  sl.registerLazySingleton<AuthorsApiService>(() => AuthorsApiService(sl()));
  sl.registerLazySingleton<AuthorsRepository>(() => AuthorsRepositoryImpl(sl()));
  sl.registerFactory(() => AuthorsBloc(sl()));
}
```

---


```

---

## 🧪 Build & Test

```bash
flutter analyze
flutter test
```

---

## 📦 Release Build

For Android:

```bash
flutter build apk --release
```

For iOS:

```bash
flutter build ios --release
```

---



---

## 💬 Contact

If you have any questions or encounter an issue, feel free to contact:

📧 Email: [sdlazamov@gmail.com(](mailto:sdlazamov@gmail.com()
🐙 GitHub: [github.com/IsmoilAzamov](https://github.com/IsmoilAzamov)
