```
# aes_flutter_technical

A Flutter application built as part of the Enhanzer Mobile Developer Assignment. This app features a login system with validation,
API integration, SQLite storage, and a user details screen, developed using Clean Architecture, Riverpod, and Dio.

---

## Getting Started

This project is a starting point for a Flutter application. Below are the steps to build and run the app, along with resources for beginners.

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.x recommended)
- Dart (comes with Flutter)
- An IDE (e.g., Android Studio, VS Code)
- Android/iOS emulator or physical device

### Build Guide
Follow these steps to build the app from source:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Mhmd-SHA/ASE-Technical
   cd aes_flutter_technical
   

2. **Install Dependencies**:
   ```bash
   flutter pub get
   

3. **Set Up Environment Variables**:
   - Create a `.env` file in the root directory:
     ```
     API_URL="" -> add yours not mine, LOL
     ```
   - Generate the environment file using `envied`:
     ```bash
     flutter pub run build_runner build --delete-conflicting-outputs
     ```

4. **Run the App**:
   - For debugging:
     ```bash
     flutter run
     ```
   - For a release build (APK):
     ```bash
     flutter build apk --release
     ```
     The APK will be located at `build/app/outputs/flutter-apk/app-release.apk`.

5. **Test the App**:
   - Use the credentials:
   - Validate login, view user details, and ensure data is stored in SQLite.


### Installing the APK
To install the pre-built APK on an Android device:

1. **Enable Unknown Sources**:
   - Go to `Settings > Security` (or `Settings > Apps & Notifications > Special app access > Install unknown apps` on newer Android versions).
   - Enable installation from your browser or file manager.

2. **Download the APK**:
   - Click the button below to download the latest release APK:
     [![Download APK](https://img.shields.io/badge/Download-APK-blue?style=for-the-badge)](https://github.com/Mhmd-SHA/ASE-Technical/releases/download/V1.0.0/ASE-TECHINICAL.app-release.apk)
   

3. **Install the APK**:
   - Open the downloaded `app-release.apk` file on your device.
   - Follow the prompts to install.
   - Launch the app from your app drawer.


## Features
- **Login Screen**: Validates username (email format) and password (min 6 characters).
- **API Integration**: Uses Dio to fetch data from the Enhanzer API.
- **SQLite Storage**: Stores user data, locations, and permissions.
- **User Details**: Displays fetched data post-login.
- **State Management**: Riverpod for reactive UI updates.
- **Clean Architecture**: Separates presentation, domain, and data layers.



