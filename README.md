# order_tracking

A Realtime Order Tracking app built with Flutter using Firebase and Ably Realtime.

## Getting Started
Instructions to run:

1. This project was built with flutter, Please make sure you have that installed
2. First do `flutter pub get` and then `flutter run` to run project


Project Details:

1. The project is structured using clean architecture
2. Riverpod was used as state management
3. Firebase was used to handle Google and Github Authentication
4. Ably was used to handle realtime update of order detail in the application


Packages used:

- State Management - flutter_riverpod
- View Svg Images - flutter_svg
- To Compare Object - equatable
- Realtime Data Updates - ably
- To handle authentication - firebase_auth

Screen flow/Project Structure:
- An authentication screen that allows user sign in with either their google or github account.
- A Screen that display an order detail with their tracking status.
- A Profile Screen that display logged in user details.
- A Track you order screen that shows the current status of the order and it's details.

DOWNLOAD APK:

App Demo:
<p align="center">
    <img src="assets\images\screenshots\app.gif" width="400">
    <img src="assets\images\screenshots\auth.png" width="400">
    <img src="assets\images\screenshots\detail.png" width="400">
    <img src="assets\images\screenshots\timeline.png" width="400">
   </p>