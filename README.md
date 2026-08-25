# Invise

Invise is a modern, predictive demand engine and inventory management platform designed to help businesses optimize their stock levels, identify dead stock, and forecast future demand using intelligent data analysis.

## Core Features

* **Authentication System**: Secure user registration, OTP verification, and login workflows.
* **Intelligent Dashboard**: Real-time overview of capital locked, with a detailed breakdown of healthy, slow-moving, and dead stock items.
* **Predictive Forecast**: AI-driven predictive demand engine providing actionable SKU projections (Restock, Hold, Discount) based on historical data and market intelligence.
* **Dead Stock Diagnosis**: Deep-dive analysis on underperforming stock items with computed opportunity costs and strategic recommendations.
* **Data Integration**: Seamless dataset uploads (CSV format) for rapid inventory synchronization.

## Architecture & Technology Stack

This application is built with the Flutter framework, utilizing a clean, modular architecture to ensure scalability and maintainability.

* **Framework**: Flutter (Dart)
* **State Management & Routing**: GetX
* **Networking**: Dio (with centralized interceptors and error handling)
* **Local Storage**: SharedPreferences
* **UI/UX**: Custom design system with modern aesthetics, smooth animations, and responsive layouts.

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

* [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version 3.19.0 or higher recommended)
* [Dart SDK](https://dart.dev/get-dart)
* IDE of your choice (VS Code, Android Studio, or IntelliJ IDEA) with Flutter extensions installed.
* An active internet connection to communicate with the backend API.

## Installation & Setup

Follow these steps to get your development environment running:

1. **Clone the repository**
   Open your terminal and run the following command:
   ```bash
   git clone https://github.com/Vincent140206/Compfest_FE
   cd compfest
   ```

2. **Install dependencies**
   Fetch all required packages declared in `pubspec.yaml`:
   ```bash
   flutter pub get
   ```

3. **Configure Environment Variables (Optional)**
   If you need to point the application to a different environment, modify the base URL located in:
   `lib/core/network/dio_client.dart`

4. **Run the application**
   Launch the application on your connected device or emulator:
   ```bash
   flutter run
   ```

## Directory Structure

The project follows a feature-based folder structure to separate concerns and improve navigation:

```text
lib/
├── core/                   # Application-wide configurations (Theme, Network, Constants)
├── features/               # Isolated feature modules
│   ├── auth/               # Login, Register, OTP Verification
│   ├── dashboard/          # Main dashboard, Capital locked banner, Dead stock lists
│   ├── data_upload/        # File picking and upload logic
│   ├── dead_stock/         # Detailed diagnostics and opportunity cost metrics
│   ├── forecast/           # Predictive demand UI and SKU projections
│   └── main_navigation/    # Bottom navigation bar and routing wrapper
├── shared/                 # Reusable UI components (Buttons, Empty Views)
└── main.dart               # Application entry point
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.
