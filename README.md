# Elpo - Sign Language Translator
__________________________________________________________________________________
Elpo is a Flutter-based mobile application that provides a bridge for communication between sign language users and non-sign language users. The app utilizes machine learning to perform live translations of sign language through image recognition or audio input. It also provides a dictionary with images of all words for users to learn and reference sign language.

# Features

# 1. User Authentication
Firebase Authentication: Users can sign up, log in, and manage their accounts securely using Firebase.
# 2. Sign Language Dictionary
Image-based Dictionary: Users can browse and search a comprehensive dictionary of sign language words, with each word represented as an image showing the corresponding sign.
Firebase Integration: The dictionary is connected to Firebase, allowing for easy updates and scalability.
# 3. Live Sign Language Translation
Machine Learning Integration: The app uses machine learning to perform live translations of sign language gestures:
Live Translation: Users can translate sign language in real-time using their device's camera.
Image Upload Translation: Users can upload an image, and the app will recognize the sign language in the image and translate it.
Capture a Sign: Users can capture a sign using their camera, and the app will process and translate the sign.
# 4. Audio-to-Sign Translation
Audio Input: The app can translate spoken language into corresponding sign language images. Users can speak into the app, and it will generate images of the sign language that matches the spoken words.
Getting Started
Prerequisites
Flutter installed on your machine.
A Firebase project with authentication and Firestore enabled.
Machine learning model integrated for sign language recognition.
Installation

# Firebase Setup
Elpo uses Firebase for user authentication and for storing the sign language dictionary.


# Machine Learning Model
Elpo uses a custom machine learning model to recognize sign language from images and live camera input.

# Audio Translation
To translate audio into sign language, the app uses speech-to-text services, and the recognized text is converted into corresponding sign language images from the dictionary.

# Video
https://github.com/user-attachments/assets/663b09b1-5a6b-4d90-b513-fd8b20e0c0bb

