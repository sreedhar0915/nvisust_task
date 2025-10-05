# nvisust_task

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Login Screen:
The login screen allows users to enter their email and password. It includes proper form validation to ensure both fields are filled correctly. If the user is not registered, they can navigate to the registration screen.

Registration Screen:
The registration screen contains fields for name, email, password, and confirm password. It performs validation to check for valid email format, password strength, and password confirmation match. After successful registration, the user is redirected to the profile screen.

Profile Screen:
The profile screen displays user details such as name and email, along with a logout button. It also includes a product list fetched from an API or local model.

Data Persistence:
User login details are securely saved using SharedPreferences, allowing automatic login and retaining user session until logout.

statemanagement tool as provider

packages:
provider
image picker
shared preference