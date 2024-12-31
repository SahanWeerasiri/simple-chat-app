# Simple Chat App

A simple chat application built with Flutter.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
  
## Features

- Group chats
- Status
- Sending friend requests

## Installation

1. **Clone the repository:**
    ```sh
    git clone https://github.com/SahanWeerasiri/simple-chat-app.git
    ```
2. **Navigate to the project directory:**
    ```sh
    cd simple-chat-app
    ```
3. **Install dependencies:**
    ```sh
    flutter pub get
    ```
4. **Navigate to the backend project directory:**
    ```sh
    cd simple-chat-app
    cd backend
    ```
5. **Install dependencies for the backend server:**
    ```sh
    npm i
    ```
6. **Build the mysql database:**
    ```sh
    cd simple-chat-app
    cd database
    ```

## Usage

1. **Run the app:**
    ```sh
    flutter run
    ```

2. **Build for release:**
    ```sh
    flutter build apk
    ```
3. **Run the server:**
    ```sh
    cd simple-chat-app
    cd backend
    node server.js
    ```

## Contributing

Contributions are welcome! Please fork this repository and submit a pull request.

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Create a new Pull Request
