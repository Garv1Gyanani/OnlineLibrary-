# Library Management App/Website

A Flutter-based library management application that allows users to browse, search, and manage books efficiently. The app integrates the **Project Gutenberg API** to fetch a rich collection of books and leverages modern Flutter libraries such as **Dio** for API requests and **GetX** for state management.

## Features

- **Browse Books**: Explore a vast collection of books from the Project Gutenberg database.
- **Search Functionality**: Quickly find books by title, author, or keyword.
- **Responsive UI**: A user-friendly interface that adapts to different screen sizes.
- **State Management**: Smooth navigation and reactive UI powered by GetX.
- **Efficient Networking**: Seamless and optimized API integration using Dio.

## Screenshots
![Screenshot 2024-12-04 203455](https://github.com/user-attachments/assets/de1a7a7e-bcf4-43b1-a5e6-5a3302f7f866)
![Screenshot 2024-12-04 203526](https://github.com/user-attachments/assets/8f9cd82a-2714-4417-bb09-08f9785ee357)
![Screenshot 2024-12-04 204001](https://github.com/user-attachments/assets/5d2b3074-b577-4313-9c38-82898b0e216f)
![Screenshot 2024-12-04 204019](https://github.com/user-attachments/assets/0e441876-4fa0-4e2a-a521-32a8edc42153)
![Screenshot 2024-12-04 203935](https://github.com/user-attachments/assets/1a72c190-385e-423f-a8df-6cddb05f105f)

![Screenshot 2024-12-04 203544](https://github.com/user-attachments/assets/956f6f99-fcc3-4842-ae0e-d666c6a221d0)

## Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/garv1gyanani/onlinelibrary.git
   cd onlinelibrary
   ```

2. **Install Dependencies**
   Run the following command to install all required dependencies:
   ```bash
   flutter pub get
   ```

3. **Run the Application**
   Launch the app on an emulator or a physical device:
   ```bash
   flutter run
   ```

## Technologies Used

- **Flutter**: Cross-platform framework for building natively compiled applications.
- **Project Gutenberg API**: Provides access to a vast collection of free eBooks.
- **Dio**: Powerful HTTP client for making API requests.
- **GetX**: Lightweight and reactive state management solution.

## API Integration

The app fetches book data from the [Project Gutenberg API](https://gutenberg.org/). To understand the API and its endpoints, refer to the official documentation.

### Key Endpoints

- **List Books**: Fetches a list of available books.
- **Search Books**: Allows searching for books by specific criteria.

## Project Structure

```
lib/
├── controllers/        # Contains GetX controllers for state management
├── models/             # Defines data models for books
├── services/           # Handles API integration using Dio
├── views/              # UI components and screens
├── widgets/            # Reusable UI widgets
└── main.dart           # Entry point of the application
```

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.

---

### Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dio Package](https://pub.dev/packages/dio)
- [GetX Package](https://pub.dev/packages/get)
- [Project Gutenberg API](https://gutenberg.org/)

For any issues or suggestions, feel free to open an issue in the repository or contact me directly.

