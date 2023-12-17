# Evento App
## Instalation process:

### 1. Install Flutter:

#### For Windows:

1. Download the Flutter SDK from the official website: [Flutter SDK](https://flutter.dev/docs/get-started/install/windows).
2. Extract the downloaded ZIP file to a location on your machine.
3. Add the `flutter/bin` directory to your system's PATH.

#### For macOS:

1. Download the Flutter SDK from the official website: [Flutter SDK](https://flutter.dev/docs/get-started/install/macos).
2. Extract the downloaded ZIP file to a location on your machine.
3. Add the `flutter/bin` directory to your system's PATH.

#### For Linux:

1. Download the Flutter SDK from the official website: [Flutter SDK](https://flutter.dev/docs/get-started/install/linux).
2. Extract the downloaded tar.gz file to a location on your machine.
3. Add the `flutter/bin` directory to your system's PATH.

### 2. Install Dependencies:

Make sure you have the following dependencies installed on your system:

- For Windows, macOS, and Linux: Git
- For macOS: Xcode (for iOS development)
- For Windows: Visual Studio Code (recommended IDE)

### 3. Run `flutter doctor`:

Open a terminal or command prompt and run:

```bash
flutter doctor
```
If you see that you're missing something on the `flutter doctor` output, be sure to install it.

### 4. Create a Flutter Project:
Run the following commands to create a new Flutter project:

```bash
flutter create my_flutter_app
cd my_flutter_app
```

Now replace lib and assets files.

### 5. Install and Set Up an Android Emulator:

Make sure you have the Android Studio installed on your machine.
Open Android Studio, go to "Configure" in the welcome screen, and select "AVD Manager" (AVD stands for Android Virtual Device).
Create a new virtual device by clicking on "Create Virtual Device" and follow the setup wizard to choose a device definition, system image, and other configurations.
Once the emulator is created, launch it from the AVD Manager.

### 6. Verify Emulator Connection:

Open a terminal or command prompt.
Run the following command to ensure that Flutter recognizes your emulator:
```bash
flutter devices
You should see your emulator listed.
```

### 7. Run the Flutter App:

Navigate to your Flutter project directory using the terminal or command prompt:

```bash
cd path/to/your/flutter/project
```

```bash
flutter run
```
This will build and install the app on the running emulator.

Make sure that your Android emulator is running before executing the flutter run command. If you encounter any issues, double-check that your Flutter environment is set up correctly, and your emulator is configured properly.