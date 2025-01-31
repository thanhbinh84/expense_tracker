# expense_tracker

Personal Expense Tracker App

### Project structure

MVVM pattern is applied with VM is GetxController (GetX)

- Architecture: https://bloclibrary.dev/architecture/

- State Management: https://pub.dev/packages/get

Folders are grouped by features

    feature (e.g dashboard)

    |__ controllers

    |__ screens

    core

    |__ controller [base controller]

    |__ model  [shared model]

    |__ repository

    |__ util

    |__ widget  [shared widget]

### How to run

- `flutter run lib/main.dart`

### How to test

- `flutter test integration_test/add_transaction_test.dart`

- `flutter test --coverage`

- `genhtml coverage/lcov.info -o coverage/html`

- `open coverage/html/index.html`

![Screenshot 2025-01-23 at 15 20 30](https://github.com/user-attachments/assets/4af9a32f-4b0c-4bde-88a5-b3475b8c52f7)

## Screenshots: 

| ![Screenshot_1737641815](https://github.com/user-attachments/assets/5a784ca3-e741-49b9-858f-39529039c688) | ![Screenshot_1737641720](https://github.com/user-attachments/assets/cf0e0d16-09e6-43ee-93ee-98de83bed706)|
| --------------------------------------- | --------------------------------------- |
|![Screenshot_1737641705](https://github.com/user-attachments/assets/9e563545-f52e-45b3-9c32-3c7e2c636ea1)|![Screenshot_1737641730](https://github.com/user-attachments/assets/bedd53c3-e634-48ae-8bea-5d1ff0675e36)|


## Screen record:

https://github.com/user-attachments/assets/3c8ea7be-09db-40a0-bf38-d0065392bb48

## Notes: 

- There is an issue with test coverage tool on Android Studio hence used `lcov` for temporary.


