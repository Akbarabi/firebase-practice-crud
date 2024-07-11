# Firebase Practice CRUD

A Flutter project to practice and demonstrate CRUD (Create, Read, Update, Delete) operations using Firebase Firestore.

## Overview

This project is a simple application built with Flutter to perform CRUD operations on Firebase Firestore. It serves as a practice and learning tool for developers who want to understand how to integrate Firebase Firestore with Flutter and manage data efficiently.

## Features

- **Create:** Add new records to Firestore.
- **Read:** Fetch and display records from Firestore.
- **Update:** Modify existing records in Firestore.
- **Delete:** Remove records from Firestore.
-**Continuous Updates:** I plan to improve this project, add new features and much more.

## Getting Started

Follow the instructions below to set up and run the project on your local machine.

### Prerequisites

Make sure you have the following installed:

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- [Git](https://git-scm.com/)
- Any IDE that supports Flutter, such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. **Clone the repository:**

   ```sh
   git clone https://github.com/yourusername/firebase-practice-crud.git
   cd firebase-practice-crud
   
2. **Install dependencies:**
   
    ```
    flutter pub get
    ```
    
3. **Configure Firebase:**

   -Create a Firebase project in the Firebase Console.
   -Add an Android and/or iOS app to your Firebase project.
   -Download the `google-services.json` (for Android) and/or `GoogleService-Info.plist` (for iOS) and place them in the appropriate directories:
     -`android/app for google-services.json`
     -`ios/Runner for GoogleService-Info.plist`
   -Ensure the Firebase project is properly configured by running:
   ```
   flutterfire configure
   ```

5. **Run the app:**
   Connect your device or start an emulator, then run:
   ```
   flutter run
   ```
## Usage
-Add new items by entering text and pressing the "Add" button.
-View the list of items fetched from Firestore.
-Edit an item by clicking on it and making changes.
-Delete an item by swiping it to the left.

## Built With
-Flutter - The UI toolkit for building natively compiled applications.
-Firebase Firestore - The database used for storing and syncing data.
