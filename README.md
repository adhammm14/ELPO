# Elpo — Sign Language Translator

**Flutter · Dart · Firebase · Machine Learning**

A cross-platform mobile app that bridges communication between sign language users and
non-signers, using on-device machine learning to translate signs from live camera input,
uploaded images, or spoken audio.

---

## The Problem

Sign language users and non-signers have no shared medium for spontaneous conversation.
Existing tools translate in one direction or require a human interpreter. Elpo handles both
directions — sign-to-text and speech-to-sign — on a phone the user already owns.

---

## Features

**Live sign translation**
Point the camera at a signer and the app recognises gestures in real time via an integrated
ML model.

**Image-based translation**
Upload or capture a still image of a sign; the model classifies it and returns the meaning.

**Speech-to-sign**
Speak into the app and it converts speech to text, then renders the matching sign language
images from the dictionary — enabling the non-signing side of the conversation.

**Sign language dictionary**
A searchable, image-backed reference of sign vocabulary, stored in Firestore so it can be
expanded without shipping an app update.

**User accounts**
Firebase Authentication handles sign-up, login, and session management.

---

## Architecture

| Layer | Technology |
|---|---|
| UI / App | Flutter (Dart) — Android, iOS, Web, macOS, Linux, Windows targets |
| Authentication | Firebase Authentication |
| Dictionary storage | Cloud Firestore |
| Sign recognition | Custom ML image-classification model |
| Speech input | Speech-to-text service |

---

## Demo

<!-- Re-upload the demo video here. The current link in the repo is a temporary
     signed URL and will stop working. Drag the .MOV into a GitHub issue to get a
     permanent URL, or add a GIF to /assets and embed it. -->

---

## Getting Started

**Prerequisites**

- Flutter SDK ([install guide](https://docs.flutter.dev/get-started/install))
- A Firebase project with Authentication and Firestore enabled
- The trained sign recognition model placed in `assets/`

**Setup**

```bash
git clone https://github.com/adhammm14/Elpo-Sign-Language-Translator.git
cd Elpo-Sign-Language-Translator
flutter pub get
```

**Configure Firebase**

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

This generates `lib/firebase_options.dart` for your own Firebase project.

**Run**

```bash
flutter run
```

---

## Project Structure

```
lib/          Application source — screens, models, services
assets/       Sign language dictionary images and ML model
android/      Android platform target
ios/          iOS platform target
web/          Web platform target
test/         Widget and unit tests
```

---

## About

Built as a capstone project combining mobile development with applied machine learning —
covering model integration on-device, real-time camera inference, and cloud-backed content
management in a single production-shaped Flutter application.
