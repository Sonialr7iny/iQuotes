 ![iquotes](https://github.com/Sonialr7iny/iQuotes/blob/master/screenshots/iqutes_app.png)

A Flutter application for saving and managing your favorite quotes locally. Built with a focus on clean state management using Bloc/Cubit and secure local data storage with SQLite.

## Features

*   **User Authentication:**
    *   Secure user registration with password validation (using regular expressions).
    *   Password hashing using BCrypt for enhanced security.
    *   Login system with session persistence (using `shared_preferences`).
*   **Quote Management:**
    *   Browse and view a collection of quotes.sh
    *   Save quotes to your personal collection.
    *   Mark quotes as "Favorites" for quick access.
    *   Archive quotes you want to keep but separate from your main list.
    *   Unarchive quotes to return them to your main collection.
*   **Local Data Storage:**
    *   All user data and quotes are stored locally and privately on the device using an SQLite database.
*   **State Management:**
    *   Clean and predictable state management implemented using the Bloc library (Cubit).

## Tech Stack & Key Packages

*   **Flutter & Dart:** Core framework and language.
*   **State Management:** `flutter_bloc` / `Cubit`
*   **Local Database:** `sqflite`
*   **Secure Password Hashing:** `bcrypt`
*   **Session Persistence:** `shared_preferences`
*   **Form Validation:** (Implicitly through regular expressions and Flutter's Form widgets)

---


1.  **App Name:** iQuotes.
2.  **BCrypt Package:** bcrypt: ^1.1.3.
3.  **Screenshots:** 
    *   Welcome Screen ![welcome_screen](https://github.com/Sonialr7iny/iQuotes/blob/master/Screenshot_welcome.png)
    *   Register Screen ![register_screen](https://github.com/Sonialr7iny/iQuotes/blob/master/Screenshot_register.png)
    *   Main Quote List Screen ![quotes_screen](https://github.com/Sonialr7iny/iQuotes/blob/master/screenshots/Screenshot_iquotes.png)
    *   Favorites Screen ![favorite_screen](https://github.com/Sonialr7iny/iQuotes/blob/master/screenshots/Screenshot_favorites.png)
    *   Archived Screen ![archived_screen](https://github.com/Sonialr7iny/iQuotes/blob/master/screenshots/Screenshot_more.png)

